//
//  BookIndexButton.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/16/25.
//

import UIKit

// 시리즈 순서 인덱스 버튼
final class BookIndexButton: UIButton {
    // 초기 설정용 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        setTitle("1", for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16)
        backgroundColor = .systemBlue
        clipsToBounds = true
    }

    // 버튼이 레이아웃되는 시점 layoutSubviews 호출(콜백처럼)
    override func layoutSubviews() {
        // super 선언해야함
        super.layoutSubviews()
        // bounds로 자신의 영역의 크기를 알 수 있다.
        // 원형을 만들기 위해서는 radius가 높이의 절반
        layer.cornerRadius = bounds.height * 0.5
    }
}
