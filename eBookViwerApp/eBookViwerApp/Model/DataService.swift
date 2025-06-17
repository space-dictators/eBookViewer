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
    }
    
    //    let bookData:[Book]
    //
    //    init() {
    //        bookData = (try? loadBooks()) ?? []
    //    }
    func loadBooks() throws -> [Book]{
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
/* 사용부
 private let dataService = DataService()
 
 func loadBooks() {
 dataService.loadBooks { [weak self] result in
 guard let self = self else { return }
 
 switch result {
 case .success(let books):
 
 
 case .failure(let error):
 }
 }
 }
 */
