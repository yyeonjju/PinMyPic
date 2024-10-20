//
//  PhotoInfoRepository.swift
//  PinMyPic
//
//  Created by 하연주 on 7/23/24.
//

import UIKit
import RealmSwift



final class LikedPhotoInfoRepository : BaseRepository  {
    typealias Item = LikedPhotoInfo
    
//    static let shared = LikedPhotoInfoRepository()
//    private override init(){}
    

    
    //유저를 삭제할 때 하위 list를 모두 삭제하기 위해
    /*
     func removeAllItemInDocument(list : List<LikedPhotoInfo>) {
         for item in list {
             removeItem(item)
         }
     }
     */

    override func removeItem<M : Object>(_ data : M) {
        print("❤️❤️removeItem")
        let likedPhotoData = data as? Item

        //파일매니저에서 이미지 삭제
        if #available(iOS 16.0, *) {
            ImageSavingManager.removeImageFromDocument(filename: likedPhotoData?.imageId ?? "")
        }
        
        //⭐️document에서 먼저 삭제하고 realm데이터 상에서 지워줘야함
        super.removeItem(data)
    }
}

extension LikedPhotoInfoRepository : LikedPhotoInfoType {
    func createItemAndSaveToDocument(_ user: UserInfo, _ data: LikedPhotoInfo, _ imageForSavingAtDocument : UIImage?) {
        print("❤️❤️ createItemAndSaveToDocument")
        //직접 저장해주지 말고❌
        //createItem(data)
        //유저의 하위에 List로 추가해주기⭕️
        UserInfoRepository.shared.addLikeItemInUser(parentData: user, childData: data)
        
        
        let likedPhotoData = data
        //파일매니저에 이미지 저장
        if #available(iOS 16.0, *) {
            ImageSavingManager.saveImageToDocument(image: imageForSavingAtDocument, filename: likedPhotoData.imageId)
        }
    }
}
