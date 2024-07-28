//
//  LikePhotoViewModel.swift
//  PinMyPic
//
//  Created by 하연주 on 7/27/24.
//

import Foundation
import RealmSwift

final class LikePhotoViewModel {
    private let likedPhotoRepository = LikedPhotoInfoRepository()
    var likedItemListData : Results<LikedPhotoInfo>! {
        didSet{
            //inputLoadLikedItem 시점에 didSet됨
            //outputReloadCollectionViewTrigger 보내기-> collectionView reload
            outputReloadCollectionViewTrigger.value = ()
        }
    }
    
    //input
    //viewDidLoad, viewWillAppear 시점
    let inputLoadLikedItem : Observable<Void?> = Observable(nil)
    //좋아요 버튼
    let inputSwitchToUnlike : Observable<String?> = Observable(nil)
    
    //output
    //likedItemListData didSet 시점 & 좋아요 해제(좋아요 realm데이터에서 삭제) 후 collectionView reload될 수 있도록
    let outputReloadCollectionViewTrigger : Observable<Void?> = Observable(nil)
    
    
    init() {
        setupBind()
    }
    
    
    private func setupBind() {
        inputLoadLikedItem.bind(onlyCallWhenValueDidSet: true) {[weak self] _ in
            guard let self else{return}

            let list = likedPhotoRepository.getAllObjects(tableModel: LikedPhotoInfo.self)
            likedItemListData = list
        }
        
        inputSwitchToUnlike.bind(onlyCallWhenValueDidSet: true) {[weak self] imageId in
            guard let self else{return}
            
            if let savedItem = likedItemListData.first(where: {$0.imageId == imageId}) {
                //이미 좋아요 좋아요 되어 있는 이미지이므로 -> realm에서 삭제
                likedPhotoRepository.removeItem(savedItem)
                
                //파일매니저에서 이미지 삭제
                if #available(iOS 16.0, *) {
                    ImageSavingManager.removeImageFromDocument(filename: imageId ?? "")
                }
            }
            
            
            //likedItemListData가 Results 타입이기 때문에 이미 realm 데이터에서 좋아요 삭제된게 반영되어 있지만 didSet에서 감지되진 않기 떄문에 outputReloadCollectionViewTrigger 보내줘야한다.
            outputReloadCollectionViewTrigger.value = ()
            
        }
    }
}
