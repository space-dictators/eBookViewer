//
//  AlertFactory.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/17/25.
//

import UIKit

// AlertCotnroller를 사용하는 alert출력 함수
enum AlertFactory {
    static func alert(for error: Error) -> UIAlertController {
        let message: String
        switch error {
        case DataService.DataError.fileNotFound:
            message = "파일을 찾을 수 없습니다."
        case DataService.DataError.parsingFailed:
            message = "책 정보를 불러오는 데 실패했습니다."
        default:
            message = "알 수 없는 에러가 발생했습니다"
        }

        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))

        return alert
    }
}
