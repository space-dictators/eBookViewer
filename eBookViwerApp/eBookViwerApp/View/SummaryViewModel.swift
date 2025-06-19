//
//  SummaryViewModel.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/19/25.
//

import UIKit

// Summary관련 토글버튼에 할당할 값을 저장할 구조체
struct SummaryViewModel {
    let text: String
    let toggleButtonTitle: String?
    let toggleAction: UIAction?
}
