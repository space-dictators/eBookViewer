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

        // 챕터 제목 부분 설정
        chapterTitleLabel.text = "Chapters"
        chapterTitleLabel.font = .boldSystemFont(ofSize: 18)
        chapterTitleLabel.textColor = .black

        addArrangedSubview(chapterTitleLabel)
    }

    // 챕터 업데이트 함수
    func updateChapter(_ bookData: BookData) {
        // "Chapters"가 있기 때문에 전체 서브뷰에서 1을 빼주어야 한다.
        let subviewCount = arrangedSubviews.count - 1
        let chapterCount = bookData.book.chapters.count

        // 서브뷰가 챕터 수보다 적으면 라벨 생성
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

        // 챕터 영역의 내용 변경, 만들어놓은 라벨 수가 많을 경우 hidden으로 변경
        for (index, label) in chatperLabels.enumerated() {
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
