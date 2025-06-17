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
        super.viewDidLoad()
        
        let bookData = dataService.bookData
        //        print(type(of: bookData))
        configureUI(bookData)
    }
    
    
    
    
    //
    private func configureUI(_ book: [Book]){
        print("어플리케이션 동작 시작")
        
        view.backgroundColor = .white
        
        //제목 라벨
        let titleLabel = BookTitleLabel()
        titleLabel.setup(book[0])
        view.addSubview(titleLabel)
        
        let indexButton = BookIndexButton()
        view.addSubview(indexButton)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "harrypotter1") // 정확한 이름 확인
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
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
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(indexButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }
    }
}
