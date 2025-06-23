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

    private let authorStackview = UIStackView()
    private let authorSectionLabel = UILabel()
    private let authorNameLabel = UILabel()

    private let releaseDateStackView = UIStackView()
    private let releaseDateSectionLabel = UILabel()
    private let releaseDateLabel = UILabel()

    private let pagesStackView = UIStackView()
    private let pagesSection = UILabel()
    private let pagesLabel = UILabel()

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

        // 작가 정보란 라벨 설정
        authorSectionLabel.text = "Author"
        authorSectionLabel.textColor = .black
        authorSectionLabel.font = .boldSystemFont(ofSize: 16)

        authorNameLabel.font = .systemFont(ofSize: 18)
        authorNameLabel.textColor = .darkGray

        authorStackview.axis = .horizontal
        authorStackview.spacing = 8
        authorStackview.alignment = .center
        authorStackview.distribution = .fill
        authorStackview.addArrangedSubview(authorSectionLabel)
        authorStackview.addArrangedSubview(authorNameLabel)

        // 발매일 정보란 라벨 설정

        releaseDateSectionLabel.text = "Released"
        releaseDateSectionLabel.font = .boldSystemFont(ofSize: 14)
        releaseDateSectionLabel.textColor = .black

        releaseDateLabel.font = .systemFont(ofSize: 14)
        releaseDateLabel.textColor = .gray

        releaseDateStackView.axis = .horizontal
        releaseDateStackView.spacing = 8
        releaseDateStackView.alignment = .leading
        releaseDateStackView.distribution = .fill
        releaseDateStackView.addArrangedSubview(releaseDateSectionLabel)
        releaseDateStackView.addArrangedSubview(releaseDateLabel)

        // 페이지 수란 라벨 설정
        pagesSection.text = "Pages"
        pagesSection.font = .boldSystemFont(ofSize: 14)
        pagesSection.textColor = .black

        pagesLabel.font = .systemFont(ofSize: 14)
        pagesLabel.textColor = .gray

        pagesStackView.axis = .horizontal
        pagesStackView.spacing = 8
        pagesStackView.alignment = .leading
        pagesStackView.distribution = .fill

        pagesStackView.addArrangedSubview(pagesSection)
        pagesStackView.addArrangedSubview(pagesLabel)

        // 텍스트용 스택뷰에 라벨과 하위 스택뷰 추가
        let itemList = [titleLabel, authorStackview, releaseDateStackView, pagesStackView]

        for item in itemList {
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

        // 작가란 업데이트
        authorNameLabel.text = bookData.book.author

        // 발매일 업데이트
        releaseDateLabel.text = bookData.dateFormat(bookData.book.releaseDate)

        // 페이지 수 업데이트
        pagesLabel.text = String(bookData.book.pages)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
