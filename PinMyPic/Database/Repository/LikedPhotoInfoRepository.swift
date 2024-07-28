//
//  PhotoInfoRepository.swift
//  PinMyPic
//
//  Created by 하연주 on 7/23/24.
//

import UIKit

final class LikedPhotoInfoRepository : BaseRepository {
    typealias Item = LikedPhotoInfo
    
    func createItemAndSaveToDocument(_ data: BaseRepository.Item, _ imageForSavingAtDocument : UIImage?) {
        super.createItem(data)
        
        let likedPhotoData = data as? Item
        //파일매니저에 이미지 저장
        if #available(iOS 16.0, *) {
            ImageSavingManager.saveImageToDocument(image: imageForSavingAtDocument, filename: likedPhotoData?.imageId ?? "")
        }
    }
    
    override func removeItem(_ data: BaseRepository.Item) {
        let likedPhotoData = data as? Item
        //파일매니저에서 이미지 삭제
        if #available(iOS 16.0, *) {
            ImageSavingManager.removeImageFromDocument(filename: likedPhotoData?.imageId ?? "")
        }
        
        //⭐️document에서 먼저 삭제하고 realm데이터 상에서 지워줘야함
        super.removeItem(data)
    }
}
