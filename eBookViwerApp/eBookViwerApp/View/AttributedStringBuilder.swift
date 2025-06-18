//
//  AttributedStringBuilder.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/17/25.
//

import UIKit

// 하나의 UILabel에 두 가지 폰트스타일을 넣기 위한 스트링빌더
// TODO: 더 간편하게 쓰는 라이브러리로 변환
enum AttributedStringBuilder {
    static func infoStyledText(
        mainText: String,
        mainFont: UIFont = .boldSystemFont(ofSize: 14),
        mainTextColor: UIColor = .black,
        subText: String,
        subFont: UIFont = .systemFont(ofSize: 14),
        subTextColor: UIColor = .gray,
        seprator: String = " "
    ) -> NSAttributedString {
        let fullText = "\(mainText)\(seprator)\(subText)"
        let attributed = NSMutableAttributedString(string: fullText)
        let mainRange = (fullText as NSString).range(of: mainText)
        let subRange = (fullText as NSString).range(of: subText)

        attributed.addAttributes([
            .font: mainFont,
            .foregroundColor: mainTextColor,
        ], range: mainRange)

        attributed.addAttributes([
            .font: subFont,
            .foregroundColor: subTextColor,
        ], range: subRange)

        return attributed
    }

    // 작가는 스타일이 달라서 편의상 추가
    // 패러매터를 넘겨서 공용으로 만들 수 있지만 편의상 사용
    // TODO: 실행시 하나의 모듈화
    static func infoAuthorStyledText(
        mainText: String,
        mainFont: UIFont = .boldSystemFont(ofSize: 16),
        mainTextColor: UIColor = .black,
        subText: String,
        subFont: UIFont = .systemFont(ofSize: 18),
        subTextColor: UIColor = .darkGray,
        seprator: String = " "
    ) -> NSAttributedString {
        let fullText = "\(mainText)\(seprator)\(subText)"
        let attributed = NSMutableAttributedString(string: fullText)
        let mainRange = (fullText as NSString).range(of: mainText)
        let subRange = (fullText as NSString).range(of: subText)

        attributed.addAttributes([
            .font: mainFont,
            .foregroundColor: mainTextColor,
        ], range: mainRange)

        attributed.addAttributes([
            .font: subFont,
            .foregroundColor: subTextColor,
        ], range: subRange)

        return attributed
    }
}
