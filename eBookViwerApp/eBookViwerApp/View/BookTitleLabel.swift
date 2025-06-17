//
//  BookTitleLabel.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/16/25.
//

import UIKit

final class BookTitleLabel: UILabel {
    
    //코드로 라벨을 만들 때 호출되는 초기화 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //스토리보드용 코드지만 규약상 구현해야함
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 라벨 속성
    func setup(_ decoratedBook: DecoratedBook) {
        self.text = decoratedBook.book.title
        self.textColor = .black
        self.font = .boldSystemFont(ofSize: 24)
        self.textAlignment = .center
        //텍스트 줄 수를 제한하지 않음 -> 줄바꿈 허용, 모든 글자 출력
        self.numberOfLines = 0
    }
}
