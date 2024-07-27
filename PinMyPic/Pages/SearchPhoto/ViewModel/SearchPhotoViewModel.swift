//
//  SearchPhotoViewModel.swift
//  PinMyPic
//
//  Created by 하연주 on 7/26/24.
//

import UIKit
import RealmSwift


final class SearchPhotoViewModel {
    struct LikedTappedPhoto{
        let imageId : String
        let image : UIImage?
    }
    
    var page = 0
    private let likedPhotoRepository = LikedPhotoInfoRepository()
    lazy var likedItemListData : Results<LikedPhotoInfo>! = likedPhotoRepository.getAllObjects(tableModel: LikedPhotoInfo.self)
    
    //input
    //search button clicked -> page 1
    var inputSearchKeyword : Observable<String?> = Observable(nil)
    //prefetch
    var inputPrefetchForPagenation : Observable<Void?> = Observable(nil)
    //좋아요 버튼 누른 셀의 index
    var inputLikeButtonTapped : Observable<LikedTappedPhoto?> = Observable(nil)
    //정렬 버튼 누름 (정렬버튼 누르지 않았을 때의 초기값 - relevant)
    var inputSortMenuTapped : Observable<SortOrder> = Observable(.relevant)
    
    
    //output
    //검색 결과
    var outputSearchResult : Observable<SearchPhoto?> = Observable(nil)
    //에러 메세지
    var outputErrorMessage : Observable<String?> = Observable(nil)
    //좋아요 눌렀을 때 셀 리로드할 수 있도록
    var outputReloadCollectionViewTrigger : Observable<Void?> = Observable(nil)
    
    
    init(){
//        likedPhotoRepository.checkFileURL()
        
        setupBind()
    }
    
    
    private func setupBind(){
        
        inputSearchKeyword.bind(onlyCallWhenValueDidSet: true) {[weak self] keyword in
            guard let self, let keyword else{return}
            page = 1
            self.getSearchList(keyword, sortOrder : inputSortMenuTapped.value)
            
        }
        
        inputPrefetchForPagenation.bind(onlyCallWhenValueDidSet: true) {[weak self] _ in
            guard let self, let keyword = self.inputSearchKeyword.value else{return}
            page += 1
            self.getSearchList(keyword, sortOrder : inputSortMenuTapped.value)
        }
        
        inputLikeButtonTapped.bind(onlyCallWhenValueDidSet: true) {[weak self] (photoInfo:LikedTappedPhoto?) in
            guard let self, let photoInfo else{return}
            self.changeLikedItemData(photoInfo : photoInfo)
        }
        
        inputSortMenuTapped.bind(onlyCallWhenValueDidSet: true) {[weak self] sortOrder in
            guard let self, let searchKeyword = inputSearchKeyword.value else{return}
            page = 1
            self.getSearchList(searchKeyword, sortOrder : sortOrder)
        }
        
        
    }
    
    
    
    private func getSearchList(_ keyword: String, sortOrder : SortOrder) {
        
        guard !isOnlyWhitespace(keyword) else{return}
            
        APIFetcher.shared.getSearchPhoto(keyword: keyword, page : page, sortOrder : sortOrder) { [weak self] result in
            guard let self else{return}
            switch result {
            case .success(let value):
                if page < 2 {
                    outputSearchResult.value = value
                }else {
                    outputSearchResult.value?.results.append(contentsOf: value.results)
                }

            case .failure(let failure):
                self.outputErrorMessage.value = failure.errorMessage
            }
        }
    }
    
    private func changeLikedItemData(photoInfo : LikedTappedPhoto) {
        guard let likedItemListData else{return}
        
        let clickedPhotoId = photoInfo.imageId
        
        //클릭된 아이템이 이미 저장되어있는지
        if let savedItem = likedItemListData.first(where: {$0.imageId == clickedPhotoId}){
            //좋아요 되어 있다면 -> realm에서 삭제
            likedPhotoRepository.removeItem(savedItem)
            
            //파일매니저에서 이미지 삭제
            if #available(iOS 16.0, *) {
                ImageSavingManager.removeImageFromDocument(filename: clickedPhotoId)
            }
            
        } else{
            //좋아요 안되어 있다면 -> realm에 추가
            let itemData = LikedPhotoInfo(imageId: clickedPhotoId, savedDate: Date())
            likedPhotoRepository.createItem(itemData)
            
            //파일매니저에 이미지 저장
            if #available(iOS 16.0, *) {
                ImageSavingManager.saveImageToDocument(image: photoInfo.image, filename: clickedPhotoId)
            }
            
        }
        outputReloadCollectionViewTrigger.value = ()

    }
    
    
}
