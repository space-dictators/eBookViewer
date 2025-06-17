//
//  AttributedStringBuilder.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/17/25.
//


import UIKit

enum AttributedStringBuilder {
    static func infoStyledText(
        mainText: String,
        mainFont: UIFont = .boldSystemFont(ofSize: 14),
        mainTextColor: UIColor = .black,
        subText: String,
        subFont: UIFont = . systemFont(ofSize: 14),
        subTextColor: UIColor = .gray,
        seprator: String = " "
    ) -> NSAttributedString {
        let fullText = "\(mainText)\(seprator)\(subText)"
        let attributed = NSMutableAttributedString(string: fullText)
        let mainRange = (fullText as NSString).range(of: mainText)
        let subRange = (fullText as NSString).range(of: subText)
        
        attributed.addAttributes([
            .font: mainFont,
            .foregroundColor: mainTextColor
        ], range: mainRange)
        
        
        attributed.addAttributes([
            .font: subFont,
            .foregroundColor: subTextColor
        ], range: subRange)
        
        return attributed
    }
    
    
    static func infoAuthorStyledText(
        mainText: String,
        mainFont: UIFont = .boldSystemFont(ofSize: 16),
        mainTextColor: UIColor = .black,
        subText: String,
        subFont: UIFont = . systemFont(ofSize: 18),
        subTextColor: UIColor = .darkGray,
        seprator: String = " "
    ) -> NSAttributedString {
        let fullText = "\(mainText)\(seprator)\(subText)"
        let attributed = NSMutableAttributedString(string: fullText)
        let mainRange = (fullText as NSString).range(of: mainText)
        let subRange = (fullText as NSString).range(of: subText)
        
        attributed.addAttributes([
            .font: mainFont,
            .foregroundColor: mainTextColor
        ], range: mainRange)
        
        
        attributed.addAttributes([
            .font: subFont,
            .foregroundColor: subTextColor
        ], range: subRange)
        
        return attributed
    }
}
