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

class LikedPhotoInfo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var imageId : String
    @Persisted var savedDate : Date
    
    //디테일 페이지에 정보 넘기기위해 필요한 것
    @Persisted var uploaderName : String
    @Persisted var uploaderProfileImage : String
    @Persisted var createdAt : String
    @Persisted var width : Int
    @Persisted var height : Int
    @Persisted var imageURL : String //이미지 url - 어차피 좋아요 한 건 document에 저장되어 있으므로 이미지 url로 다운 받을 일 없지만 일단 가지고 있기
    
    convenience init(imageId: String, savedDate: Date, uploaderName: String, uploaderProfileImage: String, createdAt: String, width: Int, height: Int, imageURL: String) {
        self.init()
        self.imageId = imageId
        self.savedDate = savedDate
        self.uploaderName = uploaderName
        self.uploaderProfileImage = uploaderProfileImage
        self.createdAt = createdAt
        self.width = width
        self.height = height
        self.imageURL = imageURL
    }
    
}

