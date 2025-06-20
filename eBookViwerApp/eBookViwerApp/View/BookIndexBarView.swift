//
//  BookIndexBarView.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/19/25.
//

import UIKit
import SnapKit

final class BookIndexBarView: UIView {
    
    // 버튼 저장용 배열
    private var buttons: [BookIndexButton] = []
    var didSelectVolume: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        // 버튼을 담을 수평 뷰 생성
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        // 스택 뷰 추가
        addSubview(stackView)
        
        // 오토 레이아웃
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    func setup(volumeCount: Int, initialVolume: Int){
        guard let stackView = self.subviews.first as? UIStackView else { return }
        
        //기존 버튼 제거
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        for index in 1...volumeCount {
            let button = BookIndexButton()
            button.configure(with: index)
            button.updateSelection(isSelected: index==initialVolume) // 선택체크
            
            button.snp.makeConstraints {
                $0.width.height.equalTo(32)
            }
                
            // 버튼 액션 설정 (클로저 통해 ViewController로 권 번호 전달)
            button.addAction(UIAction { [weak self] _ in
                self?.didSelectVolume?(index)
            }, for: .touchUpInside)
            
            buttons.append(button)
            stackView.addArrangedSubview(button)
            
        }
    }
    
    func updateSelectedIndex(to selectedIndex: Int) {
        for button in buttons {
            let isSelected = (button.index == selectedIndex)
            button.updateSelection(isSelected: isSelected)
        }
    }
}
