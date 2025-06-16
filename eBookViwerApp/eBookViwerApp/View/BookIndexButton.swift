//
//  BookIndexButton.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/16/25.
//

import UIKit

final class BookIndexButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        self.setTitle("1", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 16)
        self.backgroundColor = .systemBlue
        self.clipsToBounds = true
        /*
         
         좌우 20이상 차이나는건 아래를 참고해서 구현
         lessthanequal greaterthanequal
         */
    }
    
    // 버튼이 레이아웃되는 시점 layoutSubviews 호출(콜백처럼)
    override func layoutSubviews() {
        //super 선언해야함
        super.layoutSubviews()
        // bounds로 자신의 영역의 크기를 알 수 있다.
        // 원형을 만들기 위해서는 radius가 높이의 절반
        self.layer.cornerRadius = bounds.height * 0.5
    }
}
