//
//  DecoratedBook.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/17/25.
//
import Foundation

// Book객체에 UI에서 쓸 데이터를 추가 가공
struct DecoratedBook {
    let book: Book // 원본 Book 데이터
    let volumeText: String // "1", "2", ... (권수 정보)
    let imageName: String // "harrypotter1", "harrypotter2", ...
    let chapterArray: [String]
    var isExpanded: Bool
    let foldedSummary: String

    init(book: Book, index: Int) {
       
        // 원본 JOSN 파싱은 book에 저장
        self.book = book
        
        //UI용 가공 데이터
        volumeText = "\(index + 1)"
        imageName = "harrypotter\(index + 1)"
        chapterArray = book.chapters.map { "\($0.title)" }
        isExpanded = false
        foldedSummary = book.summary.prefix(450) + "..."
    }

    // JSON의 날짜 포맷을 MMMM d, yyyy로 변환
    func dateFormat(_ dateString: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "MMMM d, yyyy"

        if let date = inputDateFormatter.date(from: dateString) {
            return outputDateFormatter.string(from: date)
        }
        return dateString
    }
}
