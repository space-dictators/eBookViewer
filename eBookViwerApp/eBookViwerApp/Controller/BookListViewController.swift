//
//  BookListViewController.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/16/25.
//

import UIKit
import SnapKit

class BookListViewController: UIViewController {
    private let dataService = DataService()
    
    override func viewDidLoad() {
        //        super.viewDidLoad()
        super.viewDidLoad()
        
        do{
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
    
      
    private func configureUI(_ books: [Book]){
        print("어플리케이션 동작 시작")
        
        
        let decoratedBooks = books.enumerated().map { index, book in
            DecoratedBook(book: book, index: index)
        }
//        print(decoratedBooks[0])
        
        view.backgroundColor = .white
        
        //제목 라벨
        let titleLabel = BookTitleLabel()
        titleLabel.setup(decoratedBooks[6])
        view.addSubview(titleLabel)
        
        let indexButton = BookIndexButton()
        view.addSubview(indexButton)
        
        let bookInfoStackView = BookInfoStackView()
        bookInfoStackView.setup(decoratedBooks[6])
        view.addSubview(bookInfoStackView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        indexButton.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            // TODO 좌우 제약은 스택뷰에 1~7 버튼 만들 때 구현
        }
        
        bookInfoStackView.snp.makeConstraints {
            $0.top.equalTo(indexButton.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
    }
}
