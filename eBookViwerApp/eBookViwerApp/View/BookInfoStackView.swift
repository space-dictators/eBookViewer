//
//  BookInfoStackView.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/17/25.
//

import UIKit
import SnapKit

final class BookInfoStackView: UIStackView {
    
    private let bookImage = UIImageView()
    private let textStackView = UIStackView()
    
    private var titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let pageCountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(_ decoratedBook: DecoratedBook) {
        // 왼쪽 -> 오른쪽 구성
        axis = .horizontal
        // 스택 뷰 내 요소들 사이의 간격
        spacing = 8
        // 내부 요소들의 정렬 기준선 : 위쪽
        alignment = .top
        // 각 요소의 고유 크기 유지
        distribution = .fill
        
        //책 이미지
        bookImage.image = UIImage(named: decoratedBook.imageName)
        bookImage.contentMode = .scaleAspectFit
        bookImage.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }
        
        //텍스트용 세로 스택 뷰 설정
        textStackView.axis = .vertical
        textStackView.spacing = 8
        textStackView.alignment = .leading
        textStackView.distribution = .fill
        
        titleLabel.text = decoratedBook.book.title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0    
                
        authorLabel.attributedText = AttributedStringBuilder.infoAuthorStyledText(
            mainText: "Author",
            subText: decoratedBook.book.author
        )
        
        releaseDateLabel.attributedText = AttributedStringBuilder.infoStyledText(
            mainText: "Release",
            subText: decoratedBook.dateFormat( decoratedBook.book.releaseDate)
        )
        
        pageCountLabel.attributedText = AttributedStringBuilder.infoStyledText(
            mainText: "Pages",
            subText: String(decoratedBook.book.pages)
        )
        
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(authorLabel)
        textStackView.addArrangedSubview(releaseDateLabel)
        textStackView.addArrangedSubview(pageCountLabel)
        
        addArrangedSubview(bookImage)
        addArrangedSubview(textStackView)
    }
    
}
