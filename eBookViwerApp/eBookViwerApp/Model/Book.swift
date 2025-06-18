//
//  Book.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/16/25.
//

import Foundation

// JSON 파싱용 객체
struct Book: Codable {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]

    // JSON에서는 snake_case이므로 camelCase로 바꾸기 위해 Codingkey사용
    enum CodingKeys: String, CodingKey {
        case title, author, pages, dedication, summary, wiki, chapters
        case releaseDate = "release_date"
    }
}

// chapters는 [{"title" : "string"}, ...] 형태이므로 사용자객체 정의
struct Chapter: Codable {
    let title: String
}

// JSON의 구조를 살표보면
// data -> [ {attributes : Book }, ... ] 형태이므로 Wrapper를 추가해야함
struct BookResponse: Codable {
    let data: [BookWrapper]
}

// attributes -> { Book }
struct BookWrapper: Codable {
    let attributes: Book
}
