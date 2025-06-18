//
//  DescriptionStackView.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/18/25.
//

import SnapKit
import UIKit

final class DescriptionStackView: UIStackView {
    private let dedicationTitleLabel = UILabel()
    private let dedicationTextLabel = UILabel()
    private let dedicationStackView = UIStackView()

    private let summaryTitleLabel = UILabel()
    private let summaryTextLabel = UILabel()
    private let summaryStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(_ decoratedBook: DecoratedBook) {
        // 동적 구성시 상위 스택 뷰 중복 제거 코드
        arrangedSubviews.forEach { $0.removeFromSuperview() }

        axis = .vertical // 왼쪽 -> 오른쪽 구성
        spacing = 24 // 스택 뷰 내 요소들 사이의 간격
        alignment = .top // 내부 요소들의 정렬 기준선 : 위쪽
        distribution = .fill // 각 요소의 고유 크기 유지

        // Dedicaton 설정들
        dedicationTitleLabel.text = "Dedicaton"
        dedicationTitleLabel.font = .boldSystemFont(ofSize: 18)
        dedicationTitleLabel.textColor = .black

        dedicationTextLabel.text = decoratedBook.book.dedication
        dedicationTextLabel.font = .systemFont(ofSize: 14)
        dedicationTextLabel.textColor = .darkGray
        dedicationTextLabel.numberOfLines = 0

        dedicationStackView.axis = .vertical
        dedicationStackView.spacing = 8
        dedicationStackView.alignment = .leading
        dedicationStackView.distribution = .fill

        let dedicaitonList = [dedicationTitleLabel, dedicationTextLabel]

        for item in dedicaitonList {
            dedicationStackView.addArrangedSubview(item)
        }

        // Summary 설정들
        summaryTitleLabel.text = "Summary"
        summaryTitleLabel.font = .boldSystemFont(ofSize: 18)
        summaryTitleLabel.textColor = .black

        summaryTextLabel.text = decoratedBook.book.summary
        summaryTextLabel.font = .systemFont(ofSize: 14)
        summaryTextLabel.textColor = .darkGray
        summaryTextLabel.numberOfLines = 0

        summaryStackView.axis = .vertical
        summaryStackView.spacing = 8
        summaryStackView.alignment = .leading
        summaryStackView.distribution = .fill

        let summaryList = [summaryTitleLabel, summaryTextLabel]

        for item in summaryList {
            summaryStackView.addArrangedSubview(item)
        }

        // DescriptionStackView에 각각의 스택뷰 추가

        let descriptionList = [dedicationStackView, summaryStackView]

        for item in descriptionList {
            addArrangedSubview(item)
        }
    }
}
