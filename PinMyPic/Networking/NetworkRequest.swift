//
//  NetworkRequest.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import Foundation
import Alamofire

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
    
    var method : HTTPMethod {
        return .get
        
    }
    
    var parameters : [String : String] {
        switch self {
        case .searchPhoto(let query) :
            return ["query":query, "page":"1", "per_page":"20", "order_by": "relevant"]
            
        }
    }
    
    var headers : HTTPHeaders {
        switch self {
        case .searchPhoto :
            return ["Authorization":APIKey.unsplashAccessKey]
        }
    }
    
}
