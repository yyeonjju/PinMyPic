//
//  NetworkRequest.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import Foundation
import Alamofire

enum RequestType {
    case searchPhoto(query:String, page:Int, sortOrder : SortOrder)
    case topicPhotos(topicSlug : String)
    case photoStatistic(imageId : String)
    
    
    private var baseURL : String{
        return "\(APIURL.scheme)://\(APIURL.host)/"
    }
    
    var endpoint : String {
        switch self {
        case .searchPhoto:
            return baseURL + APIURL.searchPhoto
        case .topicPhotos(let topicSlug) :
            return baseURL + "topics/\(topicSlug)/photos"
        case .photoStatistic(let imageId) :
            return baseURL + "photos/\(imageId)/statistics"
        }
    }
    
    var method : HTTPMethod {
        return .get
        
    }
    
    var parameters : [String : String] {
        switch self {
        case .searchPhoto(let query, let page, let sortOrder) :
            return ["query":query, "page":String(page), "per_page": "20", "order_by": sortOrder.rawValue]
        case .topicPhotos, .photoStatistic :
            return [:]
        }
    }
    
    var headers : HTTPHeaders {
        switch self {
        case .searchPhoto, .topicPhotos, .photoStatistic :
            return ["Authorization":APIKey.unsplashAccessKey]
            
        }
    }
    
}
