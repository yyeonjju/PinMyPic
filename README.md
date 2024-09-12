# PinMyPic | 감성 사진 검색/저장 앱


![image.jpg1](https://github.com/user-attachments/assets/a70c3928-a53a-42d3-9672-d5d88ebba96c) |![image.jpg2](https://github.com/user-attachments/assets/30308a26-375e-4fef-891c-ce9368ad2c7a) |![image.jpg3](https://github.com/user-attachments/assets/32eea4b1-6a4d-422d-b194-c1d7e84a5cf7) |![image.jpg4](https://github.com/user-attachments/assets/f7bfe01a-676d-46ac-a206-f42c6baca6bc)
--- | --- | --- | --- | 



<br/><br/>

## 🪗 Mapl-Upl

- 앱 소개 : 관심있는 키워드의 감성 사진을 검색하고 보관할 수 있는 앱
- 개발 인원 : 1인
- 개발 기간 : 7/24 - 7/29 ( 6 일 )
- 최소 버전 : 15.0


<br/><br/><br/>

## 📎 기술 스택

- UIKit, Realm, Kingfisher, snapkit, Toast



<br/><br/><br/>



## 📝 핵심 기능
- 닉네임, 사진, mbti 정보 기입하여 유저 등록 / 유저 정보 수정
- 찾고자 하는 사진의 키워드로 unsplash API 사용해 사진 검색
- 특정 사진 좋아요 / 사진 디테일 데이터 조회


<br/><br/><br/>



## 💎 주요 구현 내용
### 1. Custom Observable 클래스를 이용한 반응형 MVVM 구현

<details>
  <summary>Observable class</summary>

```swift

final class Observable<T : Any> {
    
    private var closure : ((T)->Void)?
    
    var value : T  {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    

    func bind(onlyCallWhenValueDidSet : Bool = false, closure : @escaping (T) -> Void ) {
        if !onlyCallWhenValueDidSet{
            closure(value)
        }

        self.closure = closure
    }
}
```

</details>


<br/><br/>


### 2. FileManager 사용해서 좋아요한 사진을 저장, 삭제
<details>
  <summary>DB(Realm) 저장 시점에 FileManager에 사진 데이터 저장</summary>
  

  ```swift
static func saveImageToDocument(image: UIImage?, filename: String) {
    
    guard let documentDirectory = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask).first else { return }
    
    //이미지를 저장할 경로(파일명) 지정
    let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
    
    //이미지 압축
    guard let image ,let data = image.jpegData(compressionQuality: 0.5) else { return }
    
    //이미지 파일 저장
    do {
        try data.write(to: fileURL)
    } catch {
        print("file save error", error)
    }
}
  ```
</details>

<details>
  <summary>DB(Realm) 삭제 시점에 FileManager에 사진 데이터 에서 삭제 </summary>
  

  ```swift

static func removeImageFromDocument(filename: String) {
    guard let documentDirectory = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask).first else { return }

    let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
    
    if FileManager.default.fileExists(atPath: fileURL.path()) {
        
        do {
            try FileManager.default.removeItem(atPath: fileURL.path())
        } catch {
            print("file remove error", error)
        }
        
    } else {
        print("file no exist")
    }
    
}

  ```
</details>


<br/><br/>


### 3. BaseRepository를 정의하여 각 Realm 테이블 모델에 해당하는 레포지터리 구현
<details>
  <summary>RepositoryType protocol</summary>
  
```swift
import RealmSwift

protocol RepositoryType {
    associatedtype Item = Object
    
    var realm : Realm { get }

    func checkFileURL()
    func checkSchemaVersion()
    func createItem(_ data : Item)
    func getAllObjects<M : Object>(tableModel : M.Type) -> Results<M>?
    func removeItem(_ data : Item)
    func editItem<M : Object>(_ data : M.Type, at id : ObjectId ,editKey : String, to editValue : Any)
}
```

</details>

<details>
  <summary>BaseRepository class </summary>
  

  ```swift

class BaseRepository : RepositoryType {
    var realm = try! Realm()
    
    func checkFileURL() {
        print("fileURL -> ", realm.configuration.fileURL)
    }
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("version -> ",version)
        }catch {
            print(error)
        }
    }
    
    func createItem(_ data : Item) {
        do {
            try realm.write{
                realm.add(data)
                print("Realm Create Succeed")
            }
        } catch {
            print(error)
        }
    }
    
    func getAllObjects<M : Object>(tableModel : M.Type) -> Results<M>? {
       
        let value =  realm.objects(M.self)
        return value
    }
    
    func removeItem(_ data : Item) {
        do {
            try realm.write {
                realm.delete(data)
            }
        }catch {
            print(error)
        }
    }
    
    func editItem<M : Object>(_ data : M.Type, at id : ObjectId ,editKey : String, to editValue : Any) {
        do {
            try realm.write{
                realm.create(
                    M.self,
                    value: [
                        "id" : id, //수정할 컬럼
                        editKey : editValue
                    ],
                    update: .modified
                )
            }
        }catch {
            print(error)
        }
        
    }
}


  ```
</details>



<br/><br/>


### 4. 닉네임 유효성 검증

<details>
  <summary>NicknameInputError 정의</summary>

```swift

enum NicknameInputError : Error {
    case specialCharacterInput(character : String)
    case numberInput
    case lessThanMinAmount
    case moreThanMaxAmount
    case invalidateAmount
    
    func validationNoticeText() -> String {
        switch self {
        case .specialCharacterInput(let invalidCharacter):
            return Texts.NicknameValidationNoticeText.invalidCharacter(invalid: invalidCharacter)
        case .numberInput:
            return Texts.NicknameValidationNoticeText.invalidNumber
        case .lessThanMinAmount, .moreThanMaxAmount, .invalidateAmount:
            return Texts.NicknameValidationNoticeText.invalidCount
        }
    }
    
}

```

</details>

<details>
  <summary>닉네임 유효성 검증 - 1)  곧 입력될 문자 판벌 (shouldChangeCharactersIn 시점)</summary>

  ```swift

private func validateNicknameInputCharacter(willBeReplaced : String) throws -> Bool {
    let invalidSpecialCharaters = Constants.NicknameValidation.invalidSpecialCharaters

    if let index = invalidSpecialCharaters.firstIndex(of: willBeReplaced) {
        throw NicknameInputError.specialCharacterInput(character: invalidSpecialCharaters[index])
    }
    
    if let _ = Int(willBeReplaced) {
        throw NicknameInputError.numberInput
    }
    
    outputValidationNoticeText.value = ""
    return true
}

  ```

</details>

<details>
  <summary>닉네임 유효성 검증 - 2)  입력된 후 count 판별 (.editingChanged 시점)</summary>

  ```swift


private func validateNicknameInputCount(text : String?) throws {
    let textMinCount = Constants.NicknameValidation.textMinCount
    let textMaxCount = Constants.NicknameValidation.textMaxCount
    
    guard let text else {return }
    
    if (text.count) < textMinCount {
        throw NicknameInputError.lessThanMinAmount
    }

    if (text.count) > textMaxCount {
        outputCountResettingNicknameText.value = String(text.dropLast())
        throw NicknameInputError.moreThanMaxAmount
    }
    
    outputValidationNoticeText.value = ""
}

  ```

</details>




<br/><br/><br/>




## 🔥 트러블 슈팅


<br/>

### 1️. 


#### 📍 이슈 : 
#### 📍 문제 코드
#### 📍 문제 원인
#### 📍 해결 코드 및 인사이트




<br/><br/><br/>




