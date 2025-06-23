//
//  BookInfoStackView.swift
//  eBookViwerApp
//
//  Created by Yoon on 6/17/25.
//

import SnapKit
import UIKit

final class BookInfoStackView: UIStackView {
    private let bookImage = UIImageView()
    private let textStackView = UIStackView()

    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let pageCountLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .horizontal // 왼쪽 -> 오른쪽 구성
        spacing = 8 // 스택 뷰 내 요소들 사이의 간격
        alignment = .top // 내부 요소들의 정렬 기준선 : 위쪽
        distribution = .fill // 각 요소의 고유 크기 유지
        
           
        // 책 이미지 설정
        bookImage.contentMode = .scaleAspectFit // 비율 유지 + 전체 보이게
        bookImage.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(bookImage.snp.width).multipliedBy(1.5)
        }
        
        // 텍스트용 세로 스택 뷰 설정
        textStackView.axis = .vertical // 위 -> 아래 구성
        textStackView.spacing = 8
        textStackView.alignment = .leading
        textStackView.distribution = .fill
        
        // 정보란의 제목 라벨 설정
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        // 텍스트용 스택뷰에 라벨들 추가
        let labeList = [titleLabel, authorLabel, releaseDateLabel, pageCountLabel]

        for item in labeList {
            textStackView.addArrangedSubview(item)
        }

        // 이미지와 텍스트 스택뷰를 메인 스택뷰에 추가
        let stackViewList = [bookImage, textStackView]

        for item in stackViewList {
            addArrangedSubview(item)
        }
        
    }

    func updateBookInfo(_ bookData: BookData) {

        // 책 이미지 업데이트
        bookImage.image = UIImage(named: bookData.imageName)

        // 책 정보란의 제목 업데이트
        titleLabel.text = bookData.book.title

        // 작가 라벨 업데이트
        authorLabel.attributedText = AttributedStringBuilder.infoAuthorStyledText(
            mainText: "Author",
            subText: bookData.book.author
        )

        // 출판일 라벨 업데이트
        releaseDateLabel.attributedText = AttributedStringBuilder.infoStyledText(
            mainText: "Release",
            subText: bookData.dateFormat(bookData.book.releaseDate)
        )

        // 페이지수 라벨 업데이트
        pageCountLabel.attributedText = AttributedStringBuilder.infoStyledText(
            mainText: "Pages",
            subText: String(bookData.book.pages)
        )

    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
