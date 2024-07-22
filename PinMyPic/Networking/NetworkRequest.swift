//
//  NetworkRequest.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import Foundation

enum NetworkRequest {
    case searchPhoto(query:String)
    
    private var baseURL : String{
        return "\(APIURL.scheme)://\(APIURL.host)/"
    }
    
    var endpoint : String {
        switch self {
        case .searchPhoto:
            return baseURL + APIURL.searchPhoto
        }
    }
    
    var method : String {
        return "GET"
        
    }
    
    var parameters : [String : String] {
        switch self {
        case .searchPhoto(let query) :
            return ["query":query]
            
        }
    }
    
    var headers : [String : String] {
        switch self {
        case .searchPhoto :
            return ["Authorization":APIKey.unsplashAccessKey]
        }
    }
    
}
