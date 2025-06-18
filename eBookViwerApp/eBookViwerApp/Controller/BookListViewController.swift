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

        // 책정보 스택 뷰
        let bookInfoStackView = BookInfoStackView()
        bookInfoStackView.setup(decoratedBooks[0])
        view.addSubview(bookInfoStackView)

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

        bookInfoStackView.snp.makeConstraints {
            $0.top.equalTo(indexButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
