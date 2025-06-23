//
//  BookData.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/17/25.
//
import Foundation

// Book객체에 UI에서 쓸 데이터를 추가 가공
class BookData {
    let book: Book // 원본 Book 데이터
    let volumeText: String // "1", "2", ... (권수 정보)
    let imageName: String // "harrypotter1", "harrypotter2", ...
    let foldedSummary: String
    let key: String
    var isExpanded: Bool
    var summaryToggleStatus: SummaryToggleStatus?

    init(book: Book, index: Int) {
        // 원본 JOSN 파싱은 book에 저장
        self.book = book

        // UI용 가공 데이터
        volumeText = "\(index + 1)"
        imageName = "harrypotter\(index + 1)"
        foldedSummary = book.summary.prefix(450) + "..."
        key = "summary_expanded_\(volumeText)"
        isExpanded = UserDefaults.standard.bool(forKey: key)
    }

    func getSummaryToggleStatus() -> SummaryToggleStatus {
        let toggleStatus: SummaryToggleStatus
        let fullText = book.summary
        let foldedText = foldedSummary

        if book.summary.count < 450 {
            toggleStatus = SummaryToggleStatus(
                text: fullText,
                toggleButtonTitle: nil,
            )
        } else {
            toggleStatus = SummaryToggleStatus(
                text: isExpanded ? fullText : foldedText,
                toggleButtonTitle: isExpanded ? "접기" : "더보기",
            )
        }
        return toggleStatus
    }

    func toggle() {
        // 토글 후 상태 저장
        isExpanded.toggle()
        UserDefaults.standard.set(isExpanded, forKey: key)
    }

    // 날짜 포맷을 MMMM d, yyyy로 변환
    func dateFormat(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
}
