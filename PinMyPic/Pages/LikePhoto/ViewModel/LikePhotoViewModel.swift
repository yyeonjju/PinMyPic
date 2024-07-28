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
//    lazy var likedItemListData : Results<LikedPhotoInfo>! = likedPhotoRepository.getAllObjects(tableModel: LikedPhotoInfo.self)
    
    //input
    let inputLoadLikedItem : Observable<Void?> = Observable(nil)
    //좋아요 버튼
    let inputSwitchToUnlike : Observable<String?> = Observable(nil)
    
    //output
    let outputLikedItemList  : Observable<Results<LikedPhotoInfo>?> = Observable(nil)
    //좋아요 해제(좋아요 realm데이터에서 삭제) 후 collectionView reload될 수 있도록
    let outputReloadCollectionViewTrigger : Observable<Void?> = Observable(nil)
    
    
    init() {
        setupBind()
    }
    
    
    private func setupBind() {
        inputLoadLikedItem.bind(onlyCallWhenValueDidSet: true) {[weak self] _ in
            guard let self else{return}

            let list = likedPhotoRepository.getAllObjects(tableModel: LikedPhotoInfo.self)
            outputLikedItemList.value = list
        }
        
        inputSwitchToUnlike.bind(onlyCallWhenValueDidSet: true) {[weak self] imageId in
            guard let self else{return}
            
            if let savedItem = outputLikedItemList.value?.first(where: {$0.imageId == imageId}) {
                //이미 좋아요 좋아요 되어 있는 이미지이므로 -> realm에서 삭제
                likedPhotoRepository.removeItem(savedItem)
                
                //파일매니저에서 이미지 삭제
                if #available(iOS 16.0, *) {
                    ImageSavingManager.removeImageFromDocument(filename: imageId ?? "")
                }
            }
            
            outputReloadCollectionViewTrigger.value = ()
            
            //outputLikedItemList.value 가 바뀌긴 하는데 outputLikedItemList의 클로저가 실행되지 않는다? => outputReloadCollectionViewTrigger로 collectionView reload할 신호 한 번 더 주기!
            // observable이 아니라 그냥 프로퍼티로 램 데이터 받아왔을 때 프로퍼티 옵저버(didSet)으로 outputReloadCollectionViewTrigger 보내도 똑같이 동작하는지 보기
            // => 이것도 동일하게 동작하면 굳이 outputLikedItemList를 Observable로 만들어줄 필요가 없당
            
            
            //& 좋아요 탭에서 좋아요 해제 하고 검색으로 돌아왔을 때
            //좋아요 해제한거 반영해주기
            
        }
    }
}
