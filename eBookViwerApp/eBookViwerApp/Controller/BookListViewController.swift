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

    override func viewDidLoad() {
        //        super.viewDidLoad()
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
        print("어플리케이션 동작 시작")

        // UI에 사용하기 위해 데이터 추가 가공
        let decoratedBooks = books.enumerated().map { index, book in
            DecoratedBook(book: book, index: index)
        }

        // 배경색
        view.backgroundColor = .white

        // 제목 라벨
        let titleLabel = BookTitleLabel()
        titleLabel.setup(decoratedBooks[0])
        view.addSubview(titleLabel)

        // 인덱스 버튼
        let indexButton = BookIndexButton()
        view.addSubview(indexButton)

        // 스크롤 뷰
        let scrollContainer = ScrollContainerView()
        view.addSubview(scrollContainer)

        // 책정보 스택 뷰
        let bookInfoStackView = BookInfoStackView()
        bookInfoStackView.setup(decoratedBooks[0])

        // 책 설명 스택 뷰
        let descriptionStackView = DescriptionStackView()

        // 토글 관련 처리

        // 토글 컨트롤러 객체 생성
        let summaryToggle = SummaryToggleController(volumText: decoratedBooks[0].volumeText)

        // 처리용 변수에 값 할당
        let isExpanded = summaryToggle.isExpanded
        let fullText = decoratedBooks[0].book.summary
        let foldedText = decoratedBooks[0].foldedSummary

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

        // descriptionStackView의 setup함수에 전달
        descriptionStackView.setup(decoratedBooks[0], summaryViewModel: summaryViewModel)

        // 챕터 스택 뷰
        let chapterStackView = ChapterStackView()
        chapterStackView.setup(decoratedBooks[0])

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

        indexButton.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            /*
             TODO: 좌우 제약은 1~7로 버튼 늘어날 때 구현
             슈퍼뷰로부터 20이상 차이나는 조건은 아래를 참고해서 구현
             lessThanOrEqualTo, greaterThanOrEqualTo
             */
        }

        scrollContainer.snp.makeConstraints {
            $0.top.equalTo(indexButton.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
}
