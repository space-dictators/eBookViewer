//
//  BookScrollContainerView.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/18/25.
//
import SnapKit
import UIKit

final class ScrollContainerView: UIView {
    let scrollView = UIScrollView()
    let contentStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    private func setupLayout() {
        // 스크롤 뷰 기본 설정
        addSubview(scrollView)
        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }

        // 콘텐츠를 담을 스택뷰 설정
        scrollView.addSubview(contentStackView)
        contentStackView.axis = .vertical
        contentStackView.spacing = 24
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill

        // 스크롤뷰 내부 constraints (스크롤 가능하도록)
        contentStackView.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView.contentLayoutGuide)
            $0.leading.trailing.equalTo(scrollView.frameLayoutGuide).inset(20)
        }
    }
}
