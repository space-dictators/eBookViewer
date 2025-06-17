//
//  BookInfoStackView.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/17/25.
//

import UIKit
import SnapKit

final class BookInfoStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        // 왼쪽 -> 오른쪽 구성
        axis = .horizontal
        // 스택 뷰 내 요소들 사이의 간격
        spacing = 8
        // 내부 요소들의 정렬 기준선 : 위쪽
        alignment = .top
        // 각 요소의 고유 크기 유지
        distribution = .fill
    }
    
}
