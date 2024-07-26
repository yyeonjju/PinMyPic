//
//  SearchPhoto.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import Foundation


struct SearchPhoto : Decodable {
    let total : Int
    let totalPages : Int
    var results : [PhotoResult]
    
    enum CodingKeys : String, CodingKey {
        case totalPages = "total_pages"
        case total, results
    }
}

struct PhotoResult : Decodable{
    let id : String
    let createdAt : String
    let updatedAt : String
    let width : Int
    let height : Int
    let color : String
    let urls : PhotoURL
    let likes : Int
    
    enum CodingKeys : String, CodingKey {
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case id, width, height, color, urls, likes
    }
}

struct PhotoURL : Decodable {
    let regular : String
    let small : String
}
