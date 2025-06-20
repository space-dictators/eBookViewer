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

    private let summaryToggleButton = UIButton(type: .system)
    private let buttonContainerView = UIView()

    private var isExpanded = false
    private var fullText = ""
    private var foldedText = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(_ decoratedBook: DecoratedBook, summaryViewModel: SummaryViewModel) {
        // 동적 구성시 상위 스택 뷰 중복 제거 코드
        arrangedSubviews.forEach { $0.removeFromSuperview() }

        axis = .vertical // 위 -> 아래 구성
        spacing = 24 // 스택 뷰 내 요소들 사이의 간격
        alignment = .leading // 내부 요소들의 정렬 기준선 : 왼쪽
        distribution = .fill // 각 요소의 고유 크기 유지

        // summary 출력용 변수 할당
        fullText = decoratedBook.book.summary
        foldedText = decoratedBook.foldedSummary

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

        summaryTextLabel.text = summaryViewModel.text
        summaryTextLabel.font = .systemFont(ofSize: 14)
        summaryTextLabel.textColor = .darkGray
        summaryTextLabel.numberOfLines = 0

        summaryStackView.axis = .vertical
        summaryStackView.spacing = 8
        summaryStackView.alignment = .leading
        summaryStackView.distribution = .fill

        // 토글 버튼 처리

        // 버튼 숨김 관련 설정
        summaryToggleButton.isHidden = summaryViewModel.toggleButtonTitle == nil

        // 옵셔널 바인딩 해제 후 버튼에 제목과 액션 속성 부여
        if let title = summaryViewModel.toggleButtonTitle {
            summaryToggleButton.setTitle(title, for: .normal)
            summaryToggleButton.titleLabel?.font = .systemFont(ofSize: 14)
            summaryToggleButton.setTitleColor(.systemBlue, for: .normal)
        }
        
        //갱신 전 이전 액션을 지워야 한다.
        summaryToggleButton.removeTarget(nil, action: nil, for: .allEvents)
//        
        if let action = summaryViewModel.toggleAction {
            summaryToggleButton.addAction(action, for: .touchUpInside)
        }

        // summaryStackView에 Summary타이틀, 내용, 버튼 컨테이너 뷰 추가
        let summaryList = [summaryTitleLabel, summaryTextLabel, buttonContainerView]

        for item in summaryList {
            summaryStackView.addArrangedSubview(item)
        }

        // 버튼 컨테이너 뷰에 토글 버튼 추가 (따로 오른쪽 정렬이 가능 해진다)
        buttonContainerView.addSubview(summaryToggleButton)

        // 슈퍼뷰가 존재해야하므로 스택뷰 추가 뒤에 오토레이아웃
        buttonContainerView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        summaryToggleButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }

        // DescriptionStackView에 각각의 스택뷰 추가

        let descriptionList = [dedicationStackView, summaryStackView]

        for item in descriptionList {
            addArrangedSubview(item)
        }
    }

    // summaryTextLabel과 summaryToggleButton를 업데이트
    func updateSummary(text: String, buttonTitle: String) {
        summaryTextLabel.text = text
        summaryToggleButton.setTitle(buttonTitle, for: .normal)
    }
}
