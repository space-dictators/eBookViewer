//
//  DataService.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/16/25.
//

import Foundation

class DataService {
    enum DataError: Error {
        case fileNotFound
        case parsingFailed
        var localizedDescription: String {
            switch self {
            case .fileNotFound:
                return "파일이 없습니다."
            case .parsingFailed:
                return "JSON 파싱에 실패했습니다."
            }
        }
    }

    func loadBooks() throws -> [Book] {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            throw DataService.DataError.fileNotFound
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let bookResponse = try JSONDecoder().decode(BookResponse.self, from: data)
            let books = bookResponse.data.map { $0.attributes }
            return books
        } catch {
            print("🚨 JSON 파싱 에러 : \(error)")
            throw DataService.DataError.parsingFailed
        }
    }
}
