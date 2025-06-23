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

    func updateChapter(_ bookData: BookData) {
        
        // TODO:
        // 동적 구성시 상위 스택 뷰 중복 제거 코드
        // 멀티라인 간격 attributeString으로 조절
        arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 좋은 방법이 아니다. 수정
        // 1. 하나의 멀티라인 텍스트 (attributeString)
        // 2. 최대갯수만큼 만들고 나머진 hidden
        for item in bookData.chapterArray {
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
