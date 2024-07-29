//
//  UserInfoRepository.swift
//  PinMyPic
//
//  Created by 하연주 on 7/23/24.
//

import Foundation
import RealmSwift

final class UserInfoRepository : BaseRepository {
    typealias Item = UserInfo
    
    func getUser<M : Item>(tableModel : M.Type) -> Item? {
        let value =  realm.objects(M.self).first
        return value
    }
    
    func editUser(originalUserInfo : Item, newInfo : Item) {
        //newInfo로 그대로 갈아끼면 id 값이 다른 유저가 되므로 안됨
        
        do {
            try realm.write {
                originalUserInfo.profileImageName = newInfo.profileImageName
                originalUserInfo.nickname = newInfo.nickname
                originalUserInfo.mbti = newInfo.mbti
            }
            
        }catch {
            print("editUser error")
        }
    }
    
}
