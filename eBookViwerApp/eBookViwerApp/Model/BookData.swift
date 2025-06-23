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
    let foldedSummary: String // 접힌 Summary에서 보여줄 450자 데이터
    let key: String // 각권의 접힘상태를 불러올 키
    var isExpanded: Bool // 접힌 상태
    var status: SummaryToggleStatus // 뷰에 출력할 내용을 담은 객체

    init(book: Book, index: Int) {
        // 원본 JOSN 파싱은 book에 저장해서 그대로 사용
        self.book = book

        // UI용 가공 데이터
        volumeText = "\(index + 1)"
        imageName = "harrypotter\(index + 1)"
        foldedSummary = book.summary.prefix(450) + "..."
        key = "summary_expanded_\(volumeText)"
        isExpanded = UserDefaults.standard.bool(forKey: key)
        status = SummaryToggleStatus(text: "", toggleButtonTitle: nil)

        // 생성시 최초 출력을 위해 뷰 출력물을 업데이트
        updateToggleStatus()
    }

    // 뷰에 전달할 내용을 업데이트
    func updateToggleStatus() {
        let fullText = book.summary
        let foldedText = foldedSummary

        // 450자 이하면 토글 버튼 이름에 전체텍스트, 버튼이름:nil, 이상이면 현재 접힌상태에 맞추어 데이터 입력
        if book.summary.count < 450 {
            status.text = fullText
            status.toggleButtonTitle = nil
        } else {
            status.text = isExpanded ? fullText : foldedText
            status.toggleButtonTitle = isExpanded ? "접기" : "더보기"
        }
    }

    // 뷰에 전달할 내용을 리턴
    func getSummaryToggleStatus() -> SummaryToggleStatus {
        return status
    }

    // 토글 버튼을 눌렀을 때 접힘 상태의 변환, 유저디폴트에 키값 저장, 뷰에 전달할 내용 업데이트
    func toggle() {
        // 토글 후 상태 저장 및 업데이트
        isExpanded.toggle()
        UserDefaults.standard.set(isExpanded, forKey: key)
        updateToggleStatus()
    }

    // 날짜 포맷을 MMMM d, yyyy로 변환
    func dateFormat(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
}
