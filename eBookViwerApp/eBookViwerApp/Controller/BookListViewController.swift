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
    private var bookDatas: [BookData] = []

    let titleLabel = BookTitleLabel()
    let indexBar = BookIndexBarView()
    let scrollContainer = ScrollContainerView()
    let bookInfoStackView = BookInfoStackView()
    let descriptionStackView = DescriptionStackView()
    let chapterStackView = ChapterStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            // 최초 실행시 JSON파싱 후 데이터 전달
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

    // 최초 UI 생성
    private func configureUI(_ books: [Book]) {
        // UI에 사용하기 위해 데이터 추가 가공
        bookDatas = books.enumerated().map { index, book in
            BookData(book: book, index: index)
        }

        // 배경색
        view.backgroundColor = .white

        // 마지막에 본 권수 취득
        let savedVolume = UserDefaults.standard.value(forKey: "LastSelectedVolume") as? Int

        // 값이 없으면 1로 대체
        let initialVolume = savedVolume ?? 1

        // 인덱스바 셋업
        indexBar.setup(volumeCount: bookDatas.count, initialVolume: initialVolume)

        // 시리즈 권수 버튼을 선택했을 때 사용하는 클로저
        indexBar.didSelectVolume = { [weak self] selectedVolume in
            guard let self else { return }
            // 선택된 버튼만 파란색으로
            indexBar.updateSelectedIndex(to: selectedVolume)
            // 마지막에 열람한 권수 저장
            UserDefaults.standard.set(selectedVolume, forKey: "LastSelectedVolume")
            // 뷰 업데이트 함수 실행
            updateBookListView(for: selectedVolume)
        }

        // 루트 뷰에 제목(최상단), 버튼 영역, 스크롤뷰를 담을 컨테이너 뷰 추가
        view.addSubview(titleLabel)
        view.addSubview(indexBar)
        view.addSubview(scrollContainer)

        // 스크롤 뷰에 책 정보 영역 / 설명 영역 / 챕터 영역 세개의 스택뷰 추가
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
    private func updateBookListView(for volume: Int) {
        // 객체 인덱스 첫번째는 0이기 때문에 -1을 해서 변수 생성
        let index = volume - 1
        let bookData = bookDatas[index]

        // 최상단 제목 업데이트
        titleLabel.updateTitleLabel(bookData)

        // 책 정보 영역 업데이트
        bookInfoStackView.updateBookInfo(bookData)

        // 토글 관련 처리
        // 토글에 관한 데이터 획득
        let toggleStatus = bookData.getSummaryToggleStatus()

        // 토글 버튼 클로저
        descriptionStackView.didToggle = { [weak self] in
            guard let self else { return }

            // 토글버튼에 설정한 토글함수 실행
            bookData.toggle()

            // 뷰에 전달할 바뀐 정보 회득
            let status = bookData.getSummaryToggleStatus()

            // 바뀐 값 적용하는 함수 실행
            self.descriptionStackView.updateSummary(status: status)
        }

        // descriptionStackView 업데이트 함수 실행
        descriptionStackView.updateDescriptonStackView(bookData, summaryToggleStatus: toggleStatus)

        // chapterStackView 업데이트 함수 실행
        chapterStackView.updateChapter(bookData)
    }
}
