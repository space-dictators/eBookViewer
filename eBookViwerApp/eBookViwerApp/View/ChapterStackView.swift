//
//  ChapterStackView.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/18/25.
//

import SnapKit
import UIKit

final class ChapterStackView: UIStackView {
    private let chapterTitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .vertical // 위 -> 아래 구성
        spacing = 8 // 스택 뷰 내 요소들 사이의 간격
        alignment = .top // 내부 요소들의 정렬 기준선 : 위쪽
        distribution = .fill // 각 요소의 고유 크기 유지
        
        chapterTitleLabel.text = "Chapters"
        chapterTitleLabel.font = .boldSystemFont(ofSize: 18)
        chapterTitleLabel.textColor = .black
        
        addArrangedSubview(chapterTitleLabel)
    }

    func updateChapter(_ decoratedBook: DecoratedBook) {
        
        // TODO: 여기선 이게 맞는지?
        // 동적 구성시 상위 스택 뷰 중복 제거 코드
        arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for item in decoratedBook.chapterArray {
            let chapterLabel = UILabel()
            chapterLabel.text = item
            chapterLabel.font = .systemFont(ofSize: 14)
            chapterLabel.textColor = .darkGray
            chapterLabel.numberOfLines = 0
            addArrangedSubview(chapterLabel)
        }
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
