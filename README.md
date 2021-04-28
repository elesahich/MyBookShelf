# My BookShelf 

**`VIPER`, `RxSwift`, `Realm`, `NSCache`, `SnapKit`, `RxAlamofire`, `Dependency-Injection`, `NSCache`, `Pagination`**

![Generic badge](https://img.shields.io/badge/Licence-MIT-lightgray) ![Generic badge](https://img.shields.io/badge/Language-Swift-black) 



**`나의 책장`** 앱은 VIPER패턴을 이용한 첫번째 샘플 앱입니다. <br> VIPER 패턴에 맞춰서 MVVM-C를 확장하여 앱 구조를 구성했습니다. (Interactor)

## 구조 소개
VIPER 패턴의 각 컴포넌트는 단일 책임을 가집니다. [VIPER?](https://www.raywenderlich.com/8440907-getting-started-with-the-viper-architecture-pattern) <br>
앱에서 고안한 구조를 그림으로 표현하면 다음과 같습니다. <br><br>
![Group 6 (1)](https://user-images.githubusercontent.com/82797883/116359502-d3814a00-a839-11eb-997f-534de3cb8211.png)

1. Router는 가장 먼저 생성되어 다른 컴포넌트에 필요한 의존성을 주입합니다.
2. View는 유저의 이벤트를 Presenter로 전송합니다. Presenter에서 받아온 데이터를 뷰에 그리는 역할을 합니다.
3. Presenter는 View에서 발생하는 트리거를 처리합니다. 만약 화면 전환 액션이 호출되면 Router의 메소드를 호출하고, 비지니스로직이 필요하면 Interactor의 메소드를 호출합니다.
4. Interactor는 단순히 비지니스 로직을 처리합니다. 해당 액션을 처리하면서 중요한 것은 Presenter는 해당 정보가 어디에서 오는지 모른다는 것입니다. Presenter가 `Observable<[Book]>` 리턴값을 받았을 때 이 값이 캐시에서 온 것인지, 서버에서 온 값인지 알 수 없고 View에 전달할 뿐입니다.
5. Entity는 도메인 로직이 필요한 경우 처리할 수 있습니다. 해당 Scene에서만 필요한 모델을 정의할 수 있습니다.

## 사용한 라이브러리 (External Libraries via Cocoapods)
- RxSwift
- RxCocoa
- RxDataSource
- Snapkit
- Realm
- Alamofire
- Kingfisher

## etc
- PR, issue 환영합니다!
- 궁금한 점이 있으시면 elesahich@gmail.com으로 메일 주세요!

