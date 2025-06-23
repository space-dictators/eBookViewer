//
//  AlertFactory.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/17/25.
//

import UIKit

// AlertCotnroller를 사용하는 alert출력 함수
// 굳이 나눌 필요가 없다.
enum AlertFactory {
    static func alert(for error: Error) -> UIAlertController {
        
        let message = error.localizedDescription

        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))

        return alert
    }
}
