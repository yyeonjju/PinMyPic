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
    
    
    override func getAllObjects<M : Object>(tableModel : M.Type) -> Results<M>? {
        return nil
    }
    
    func getUser<M : Item>(tableModel : M.Type) -> Item? {
        let value =  realm.objects(M.self).first
        return value
    }
    
}
