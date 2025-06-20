//
//  BookTitleLabel.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/16/25.
//

import UIKit

// 책 제목 라벨(최상단)
final class BookTitleLabel: UILabel {
    // 코드로 라벨을 만들 때 호출되는 초기화 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // 스토리보드용 코드지만 규약상 구현해야함
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 라벨 속성
    func setup(_ decoratedBook: DecoratedBook) {
        text = decoratedBook.book.title
        textColor = .black
        font = .boldSystemFont(ofSize: 24)
        textAlignment = .center
        numberOfLines = 0 // 텍스트 줄 수를 제한하지 않음 -> 줄바꿈 허용, 모든 글자 출력
    }
    
    func updateLabel(){
        
    }
}
