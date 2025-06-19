//
//  SummaryToggleController.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/19/25.
//

import Foundation

final class SummaryToggleController {
    private let key: String
    private(set) var isExpanded: Bool

    init(volumText: String) {
        // 몇 권인지 받아서 저장된 값 불러옴
        key = "summary_expanded_\(volumText)"
        isExpanded = UserDefaults.standard.bool(forKey: key)
    }

    func toggle() {
        // 토글 후 상태 저장
        isExpanded.toggle()
        UserDefaults.standard.set(isExpanded, forKey: key)
    }
}
