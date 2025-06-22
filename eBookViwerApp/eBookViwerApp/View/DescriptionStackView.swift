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

    private let toggleButton = UIButton(type: .system)
    private let buttonContainerView = UIView()

    private var isExpanded = false
    private var fullText = ""
    private var foldedText = ""
    
    var didToggle: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .vertical // 위 -> 아래 구성
        spacing = 24 // 스택 뷰 내 요소들 사이의 간격
        alignment = .leading // 내부 요소들의 정렬 기준선 : 왼쪽
        distribution = .fill // 각 요소의 고유 크기 유지
        
        // Dedicaton 설정들
        dedicationTitleLabel.text = "Dedicaton"
        dedicationTitleLabel.font = .boldSystemFont(ofSize: 18)
        dedicationTitleLabel.textColor = .black
        dedicationTextLabel.font = .systemFont(ofSize: 14)
        dedicationTextLabel.textColor = .darkGray
        dedicationTextLabel.numberOfLines = 0
        
        // dedicationStackView 설정
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
        summaryTextLabel.font = .systemFont(ofSize: 14)
        summaryTextLabel.textColor = .darkGray
        summaryTextLabel.numberOfLines = 0
        
        // summaryStackView 설정
        summaryStackView.axis = .vertical
        summaryStackView.spacing = 8
        summaryStackView.alignment = .leading
        summaryStackView.distribution = .fill
        
        // 버튼 액션 설정
        toggleButton.addAction(UIAction { [weak self] _ in
            self?.didToggle?()
        }, for: .touchUpInside)
        
        toggleButton.titleLabel?.font = .systemFont(ofSize: 14)
        toggleButton.setTitleColor(.systemBlue, for: .normal)
        
        // summaryStackView에 Summary타이틀, 내용, 버튼 컨테이너 뷰 추가
        let summaryList = [summaryTitleLabel, summaryTextLabel, buttonContainerView]

        for item in summaryList {
            summaryStackView.addArrangedSubview(item)
        }

        // 버튼 컨테이너 뷰에 토글 버튼 추가 (따로 오른쪽 정렬이 가능 해진다)
        buttonContainerView.addSubview(toggleButton)

        // 슈퍼뷰가 존재해야하므로 스택뷰 추가 뒤에 오토레이아웃
        buttonContainerView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        toggleButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
               

    }

    func updateDescriptonStackView(_ decoratedBook: DecoratedBook, SummaryToggleStatus: SummaryToggleStatus) {
        // 동적 구성시 상위 스택 뷰 중복 제거 코드
        arrangedSubviews.forEach { $0.removeFromSuperview() }

        // dedication 내용 업데이트
        dedicationTextLabel.text = decoratedBook.book.dedication
        
        // summary 내용 업데이트
        summaryTextLabel.text = SummaryToggleStatus.text
        
        // 토글 버튼 처리
        // 버튼 숨김 관련 설정
        toggleButton.isHidden = SummaryToggleStatus.toggleButtonTitle == nil

        // 옵셔널 바인딩 해제 후 버튼에 제목 부여
        if let title = SummaryToggleStatus.toggleButtonTitle {
            toggleButton.setTitle(title, for: .normal)
        }
        
        // TODO: 왜 얘는 올리면 안되지?
        // DescriptionStackView에 각각의 스택뷰 추가
        let descriptionList = [dedicationStackView, summaryStackView]

        for item in descriptionList {
            addArrangedSubview(item)
        }

    }
    //TODO: 중복 해결
    // summaryTextLabel과 toggleButton를 업데이트
    func updateSummary(text: String, buttonTitle: String) {
        summaryTextLabel.text = text
        toggleButton.setTitle(buttonTitle, for: .normal)
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

}
