//
//  DecoratedBook.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/17/25.
//
import Foundation

struct DecoratedBook {
    let book: Book          // 원본 Book 데이터
    let volumeText: String  // "1", "2", ... (권수 정보)
    let imageName: String   // "harrypotter1", "harrypotter2", ...
    
    init(book: Book, index: Int) {
        self.book = book
        self.volumeText = "\(index + 1)"
        self.imageName = "harrypotter\(index + 1)"
    }
    
    func dateFormat(_ dateString: String) -> String{
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




