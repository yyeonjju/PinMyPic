//
//  TopicTrendPhotoViewModel.swift
//  PinMyPic
//
//  Created by 하연주 on 7/27/24.
//

import Foundation
import RealmSwift

struct TopicContent {
    let topic : String
    let content : [PhotoResult]
}

final class TopicTrendPhotoViewModel {
    let topicQueryList = [TopicQuery.goldenHour.rawValue, TopicQuery.businessWork.rawValue, TopicQuery.architectureInterior.rawValue]
    private let likedPhotoRepository = LikedPhotoInfoRepository()
    lazy var likedItemListData : Results<LikedPhotoInfo>! = likedPhotoRepository.getAllObjects(tableModel: LikedPhotoInfo.self)
    
    
    
    //input
    let inputViewDidLoadTrigger : Observable<Void?> = Observable(nil)
    
    //output
    let outputErrorMessage : Observable<String?> = Observable(nil)
    let outputTopicContents : Observable<[TopicContent]> = Observable([])
    
    
    init() {
        setupBind()
    }
    
    
    private func setupBind(){
        inputViewDidLoadTrigger.bind(onlyCallWhenValueDidSet: true) { [weak self] _ in
            guard let self else{return}
            
            for topic in topicQueryList{
                getTopicPhotos(topic: topic)
            }

        }
    }
    
    
    private func getTopicPhotos(topic : String) {
        APIFetcher.shared.getTopicPhotos(topicSlug: topic){ [weak self] result in
            guard let self else{return}
            switch result {
            case .success(let value):
                outputTopicContents.value.append(TopicContent(topic: topic, content: value))
                
            case .failure(let failure):
                self.outputErrorMessage.value = failure.errorMessage
            }
        }
        
    }
    
}


