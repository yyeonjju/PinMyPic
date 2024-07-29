//
//  PhotoDetailViewModel.swift
//  PinMyPic
//
//  Created by 하연주 on 7/28/24.
//

import UIKit
import RealmSwift

final class PhotoDetailViewModel {
    enum PhotoInformationOptions : String, CaseIterable {
        case resolution = "크기"
        case views = "조회수"
        case downloads = "다운로드"
    }
    let informationOptions = PhotoInformationOptions.allCases
    private let likedPhotoRepository = LikedPhotoInfoRepository.shared
    lazy var likedItemListData : Results<LikedPhotoInfo>! = likedPhotoRepository.getAllObjects(tableModel: LikedPhotoInfo.self)
    let userInfo : UserInfo? = UserInfoRepository.shared.getUser(tableModel: UserInfo.self)
    
    //init
    //이미지 아이디로 satistic 데이터 받기
    let inputImageId : Observable<String?> = Observable(nil)
    //좋아요 클릭했을 때
    let inputLikeButtonTapped : Observable<(LikedPhotoInfo, UIImage)?> = Observable(nil)
    
    //output
    let outputErrorMessage : Observable<String?> = Observable(nil)
    //통계데이터
    let outputStatisticData : Observable<PhotoStatistic?> = Observable(nil)
    //좋아요 여부에 따라 다시 하트 모양 바뀔 수 있도록
    let outputConfigureLikeImageTrigger : Observable<Void?> = Observable(nil)
    
    
    init() {
        setupBind()
    }
    
    private func setupBind(){
        inputImageId.bind(onlyCallWhenValueDidSet: true) {[weak self] id in
            guard let self else{return }
            if let id {
                self.getPhotoStatistic(id: id)
            }else{
                self.outputErrorMessage.value = "이미지 id를 받아오지 못했습니다."
            }
            
        }
        
        inputLikeButtonTapped.bind(onlyCallWhenValueDidSet: true) {[weak self] value in
            guard let self, let value else{return }
            
            changeLikedItemData(photoInfo : value.0, image : value.1)
        }
    }
    
    
    private func getPhotoStatistic(id : String) {
        APIFetcher.shared.getPhotoStatistic(imageId: id){ [weak self] result in
            guard let self else{return}
            switch result {
            case .success(let value):
                self.outputStatisticData.value = value
                
            case .failure(let failure):
                self.outputErrorMessage.value = failure.errorMessage
            }
        }
        
    }
    
    private func changeLikedItemData(photoInfo : LikedPhotoInfo, image : UIImage) {
        guard let likedItemListData else{return}
        
        let clickedPhotoId = photoInfo.imageId
        
        //클릭된 아이템이 이미 저장되어있는지
        if let savedItem = likedItemListData.first(where: {$0.imageId == clickedPhotoId}){
            //좋아요 되어 있다면 -> realm에서 삭제
            likedPhotoRepository.removeItem(savedItem)
            
        } else{
            //좋아요 안되어 있다면 -> realm에 추가
            guard let userInfo else{return}
            likedPhotoRepository.createItemAndSaveToDocument(userInfo, photoInfo, image)
            
        }
        outputConfigureLikeImageTrigger.value = ()

    }
}
