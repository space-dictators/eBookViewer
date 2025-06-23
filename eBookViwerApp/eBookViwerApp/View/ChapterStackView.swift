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
    private var chatperLabels: [UILabel] = []
    
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
        
        let subviewCount = self.arrangedSubviews.count - 1
        let chapterCount = bookData.book.chapters.count
        
        if subviewCount < chapterCount {
            let addCount = chapterCount - subviewCount
            for _ in 0 ..< addCount {
                let chapterLabel = UILabel()
                chapterLabel.font = .systemFont(ofSize: 14)
                chapterLabel.textColor = .darkGray
                chapterLabel.numberOfLines = 0
                chapterLabel.isHidden = true
                chatperLabels.append(chapterLabel)
                addArrangedSubview(chapterLabel)
            }
        }
        
        for (index, label) in chatperLabels.enumerated(){
            if index < chapterCount {
                label.text = bookData.book.chapters[index].title
                label.isHidden = false
            } else {
                label.text = nil
                label.isHidden = true
            }
        }

    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
