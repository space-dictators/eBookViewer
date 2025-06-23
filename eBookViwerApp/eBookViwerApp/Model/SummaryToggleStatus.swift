//
//  SummaryToggleStatus.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/19/25.
//

// Summary관련 토글 시 출력 내용을 담은 클래스
final class SummaryToggleStatus {
    var text: String // 출력할 텍스트를 받음
    var toggleButtonTitle: String? // 접기 / 더보기
    var isHidden: Bool {
        toggleButtonTitle == nil
    } // 숨길지 여부

    init(text: String, toggleButtonTitle: String?) {
        self.text = text
        self.toggleButtonTitle = toggleButtonTitle
    }
}
