//
//  UserInfo.swift
//  PinMyPic
//
//  Created by 하연주 on 7/23/24.
//

import Foundation
import RealmSwift

class UserInfo : Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var nickname: String
    @Persisted var profileImageName: String
    @Persisted var mbti: List<String>
    @Persisted var registerDate : Date
    
    //1:n
    @Persisted var likedPhoto : List<LikedPhotoInfo>
    
    convenience init(nickname: String, profileImageName: String, mbti: List<String>, registerDate: Date) {
        self.init()
        self.nickname = nickname
        self.profileImageName = profileImageName
        self.mbti = mbti
        self.registerDate = registerDate
    }
}
