# eBookViewer 개인과제
hamakko branch
# 폴더 및 파일 구성
```
📁 eBookViwerApp   
├─── 📁 Controller   
│   ├── 🟧 AlertFactory.swift   
│   ├── 🟧 BookListViewController.swift   
├── 📁 Extension   
├── 📁 Model   
│   ├── 🟧 Book.swift   
│   ├── 🟧 BookData.swift   
│   ├── 🟧 DataService.swift 
│   └── 🟧 SummaryToggleStatus.swift   
├── 📁 Resources   
│   ├── 📁 Assets   
│   ├── 📄 data.json   
├── 📁 Support   
│   ├── 🟧 AppDelegate.swift   
│   └── 🟧 SceneDelegate.swift   
├── 📁 View   
│   ├── 🟧 BookIndexVarView.swift 
│   ├── 🟧 BookIndexButton.swift   
│   ├── 🟧 BookInfoStackView.swift   
│   ├── 🟧 BookTitleLabel.swift   
│   ├── 🟧 ChapterStackView.swift     
│   ├── 🟧 DescriptionStackView.swift   
│   └── 🟧 ScrollContainerView.swift   
```

# 각 부분 역할 설명

## Controller

- AlertFactory : Alert을 담당하는 컨트롤러
- BookListViewController : 메인 뷰 컨트롤러

## Model

- Book : JSON 파싱용 원본 객체
- BookData : JSON 파싱한 Book 객체에 UI에서 사용편의성을 위해 데이터를 덧붙인 객체
- DataService : 과제에서 제공한 에러와 JSON디코딩 관련 모델
- SummaryToggleStatus : 뷰에 전달하기 위한 중간다리용 상태 객체

## View

- BookIndexVarView : 버튼이 가로로 놓여져 있는 뷰
- BookIndexButton : 권수를 선택하는 버튼
- BookInfoStackView : 책 정보영역 뷰
- BookTitleLabel : 최상단의 책의 이름을 나타내는 라벨
- ChapterStackView : 챕터를 담고 있는 스택 뷰     
- DescriptionStackView : 설명 영역을 담고 있는 스택 뷰
- ScrollContainerView : 스크롤뷰용 컨테이너 뷰

# 작동 설명

- 각 권을 누르면 해당 하는 권의 정보가 출력
- Summary는 450자 이상인 경우 접기/더보기 버튼이 출력되고 각 권마다 접힌 상태를 보관하고 있음
- 앱 실행시 종료 전에 마지막으로 열람했던 권 수를 기억하고 출력해줌 (최초 실행시는 1권)