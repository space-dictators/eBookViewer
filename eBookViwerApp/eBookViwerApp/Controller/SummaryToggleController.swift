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

    init(volumeText: String) {
        // 몇 권인지 받아서 저장된 값 불러옴
        key = "summary_expanded_\(volumeText)"
        isExpanded = UserDefaults.standard.bool(forKey: key)
    }

    func toggle() {
        // 토글 후 상태 저장
        isExpanded.toggle()
        UserDefaults.standard.set(isExpanded, forKey: key)
    }
    
    func createSummaryToggleStatus(_ decoratedBook: DecoratedBook) -> SummaryToggleStatus {
        let toggleStatus: SummaryToggleStatus
        let fullText = decoratedBook.book.summary
        let foldedText = decoratedBook.foldedSummary
        
        if decoratedBook.book.summary.count < 450 {
            toggleStatus = SummaryToggleStatus(
                text: fullText,
                toggleButtonTitle: nil,
                isHidden: true
            )
        } else {
            toggleStatus = SummaryToggleStatus(
                text: isExpanded ? fullText : foldedText,
                toggleButtonTitle: isExpanded ? "접기" : "더보기",
                isHidden: false
            )
        }
        return toggleStatus
    }
}
