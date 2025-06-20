//
//  BookIndexButton.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/16/25.
//

import UIKit

// 시리즈 순서 인덱스 버튼
final class BookIndexButton: UIButton {
    private(set) var index: Int = 0
    
    // 최초 설정
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = .systemFont(ofSize: 16)
        clipsToBounds = true
    }

    // 버튼의 인덱스 번호와 버튼에 표시될 숫자문자 설정
    func configure(with index: Int){
        self.index = index
        setTitle(String(index), for: .normal)
    }
    
    // 선택여부에 따라 색 설정변경
    func updateSelection(isSelected: Bool){
        backgroundColor = isSelected ? .systemBlue : .systemGray5
        setTitleColor(isSelected ? .white : .systemBlue, for: .normal)
    }

    // 버튼이 레이아웃되는 시점 layoutSubviews 호출(콜백처럼)
    override func layoutSubviews() {
        // super 선언해야함
        super.layoutSubviews()
        // bounds로 자신의 영역의 크기를 알 수 있다.
        // 원형을 만들기 위해서는 radius가 높이의 절반
        layer.cornerRadius = bounds.height * 0.5
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
