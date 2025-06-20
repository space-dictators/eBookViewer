//
//  BookListViewController.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/16/25.
//

import SnapKit
import UIKit

class BookListViewController: UIViewController {
   
    private let dataService = DataService()
    private var decoratedBooks: [DecoratedBook] = []
    
    let titleLabel = BookTitleLabel()
    let indexBar = BookIndexBarView()
    let scrollContainer = ScrollContainerView()
    let bookInfoStackView = BookInfoStackView()
    let descriptionStackView = DescriptionStackView()
    let chapterStackView = ChapterStackView()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()

        do {
            let bookData = try dataService.loadBooks()
            configureUI(bookData)
                
        } catch {
            print(error)
            // 메인 쓰레드 다음 런루프 싸이클에 작업할당
            DispatchQueue.main.async {
                let alert = AlertFactory.alert(for: error)
                self.present(alert, animated: true)
            }
        }
    }

    private func configureUI(_ books: [Book]) {

        // UI에 사용하기 위해 데이터 추가 가공
        decoratedBooks = books.enumerated().map { index, book in
            DecoratedBook(book: book, index: index)
        }
        // 배경색
        view.backgroundColor = .white
        
        //마지막에 본 권수 취득
        let savedVolume = UserDefaults.standard.integer(forKey: "LastSelectedVolume")
        // 값이 없으면 0 → 그 경우 1로 대체
        let initialVolume = (savedVolume == 0) ? 1 : savedVolume
        
        //인덱스바 셋업
        indexBar.setup(volumeCount: decoratedBooks.count, initialVolume: initialVolume)
        
        indexBar.didSelectVolume = { [weak self] selectedVolume in
            guard let self else { return }
            // 선택된 버튼만 파란색으로
            indexBar.updateSelectedIndex(to: selectedVolume)
            // 마지막에 열람한 권수 저장
            UserDefaults.standard.set(selectedVolume, forKey: "LastSelectedVolume")
            // 뷰 바꾸는 함수 실행
            print(UserDefaults.standard.integer(forKey: "LastSelectedVolume"))
            updateBookListView(for: selectedVolume)
        }

        view.addSubview(titleLabel)
        view.addSubview(indexBar)
        view.addSubview(scrollContainer)


        // 스크롤 뷰에 위 세개 스택뷰 추가
        let scrollviewList = [bookInfoStackView, descriptionStackView, chapterStackView]
        for item in scrollviewList {
            scrollContainer.contentStackView.addArrangedSubview(item)
        }

        // 오토 레이아웃 정의
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

      
        indexBar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.greaterThanOrEqualToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }

        scrollContainer.snp.makeConstraints {
            $0.top.equalTo(indexBar.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            
        }
        
        updateBookListView(for: initialVolume)
    }
    
    // 뷰 업데이트 함수
    private func updateBookListView(for volume: Int){
        
        // 객체 인덱스 첫번째는 0이기 때문에 -1 변수 생성
        let index = volume - 1
        let book = decoratedBooks[index]
        titleLabel.setup(book)
        bookInfoStackView.setup(book)
        
        // 토글 관련 처리
        // 토글 컨트롤러 객체 생성
        let summaryToggle = SummaryToggleController(volumText: book.volumeText)

        // 처리용 변수에 값 할당
        let isExpanded = summaryToggle.isExpanded
        let fullText = book.book.summary
        let foldedText = book.foldedSummary

        // SummaryViewModel 객체 생성
        let summaryViewModel: SummaryViewModel

        // 450자 이하인 경우 전체 텍스트만 보이고 버튼 필요없음 -> nil로 두기
        if fullText.count < 450 {
            summaryViewModel = SummaryViewModel(
                text: fullText,
                toggleButtonTitle: nil,
                toggleAction: nil
            )
        } else {
            // 버튼을 눌렀을때 클로즈 기반의 액션 정의
            let toggleAction = UIAction { [weak descriptionStackView] _ in
                guard let descriptionStackView = descriptionStackView else { return }

                // 토글 실행
                summaryToggle.toggle()

                // 토글에 따라 변수에 바뀌는 값 할당
                let newIsExpanded = summaryToggle.isExpanded
                let newText = newIsExpanded ? fullText : foldedText
                let newTitle = newIsExpanded ? "접기" : "더보기"

                // 바뀐 값 적용하는 함수 실행
                descriptionStackView.updateSummary(text: newText, buttonTitle: newTitle)
            }

            // 최초 실행시의 값을 뷰모델에 설정
            summaryViewModel = SummaryViewModel(
                text: isExpanded ? fullText : foldedText,
                toggleButtonTitle: isExpanded ? "접기" : "더보기",
                toggleAction: toggleAction
            )
        }
        
        descriptionStackView.setup(book, summaryViewModel: summaryViewModel)
        chapterStackView.setup(book)
        
    }
}
