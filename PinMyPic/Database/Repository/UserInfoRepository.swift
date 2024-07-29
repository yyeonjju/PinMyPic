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
    
    static let shared = UserInfoRepository()
    private override init(){}
    
    
    //좋아요한 아이템을 유저에 1:n으로 저장
    func addLikeItemInUser(parentData : Item, childData : LikedPhotoInfo) {
        do {
            try realm.write{
                parentData.likedPhoto.append(childData)
            }
        } catch {
            print(error)
        }
    }
    
    
    //유저 지울 때 먼저 1:n relationship 자식 삭제하고 지워야함
    override func removeItem(_ data: Object) {
        do {
            try realm.write {
                if let data = data as? Item{
                    realm.delete(data.likedPhoto)
                }
                
                realm.delete(data)
                print("delete succeed")
            }
        }catch {
            print(error)
        }
        
    }
    
    
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
