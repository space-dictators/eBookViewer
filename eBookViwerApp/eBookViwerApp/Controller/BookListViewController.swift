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
            let books = try dataService.loadBooks()
            configureUI(books)
            
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
        let decoratedBook = decoratedBooks[index]
        
        // 최상단 제목 업데이트
        titleLabel.updateTitleLabel(decoratedBook)
        
        // 책 정보 영역 업데이트
        bookInfoStackView.updateBookInfo(decoratedBook)
        
        // 토글 관련 처리
        // 토글 컨트롤러 객체 생성
        let summaryToggle = SummaryToggleController(volumeText: decoratedBook.volumeText)

        // SummaryToggleStatus 객체 생성
        let toggleStatus = summaryToggle.createSummaryToggleStatus(decoratedBook)
        
        /*
         TODO: 작동 방식에 대해서
         1. 실행시 클로저 이하의 구문 실행여부
         2. 클로저 위에서 선언된 객체 사용
         3. if else 안에 있을때
         */

        // 토글 버튼 클로저
        descriptionStackView.didToggle = { [weak self] in
            guard let self else { return }
            summaryToggle.toggle()
            
            let status = summaryToggle.createSummaryToggleStatus(decoratedBook)
            
            // 바뀐 값 적용하는 함수 실행
            self.descriptionStackView.updateSummary(status: status)
        }
        
        descriptionStackView.updateDescriptonStackView(decoratedBook, summaryToggleStatus: toggleStatus)
        
        chapterStackView.updateChapter(decoratedBook)
        
    }
}
