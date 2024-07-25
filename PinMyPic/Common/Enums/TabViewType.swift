//
//  TabBarType.swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit


protocol TabBarProtocol{
    var rootVC : UIViewController.Type {get}
    var iconImage : UIImage? {get}
    var title : String? {get}
}


enum TabViewType : String, CaseIterable, TabBarProtocol{
    case topicTrend
    case randomPhoto
    case searchPhoto
    case likePhoto
    
    
    var rootVC : UIViewController.Type {
        switch self {
        case .topicTrend:
            return TopicTrendPhotoViewController.self
        case .randomPhoto:
            return RandomPhotoViewController.self
        case .searchPhoto:
            return SearchPhotoViewController.self
        case .likePhoto:
            return LikePhotoViewController.self
        }
    }
    
    var iconImage : UIImage? {
        switch self {
        case .topicTrend:
            return Assets.Images.tabTrend
        case .randomPhoto:
            return Assets.Images.tabRandom
        case .searchPhoto:
            return Assets.Images.tabSearch
        case .likePhoto:
            return Assets.Images.tabLike
        }
    }
    
    var title : String? {
        switch self {
        case .topicTrend, .randomPhoto, .searchPhoto, .likePhoto:
            return nil
        }
    }
    
}
