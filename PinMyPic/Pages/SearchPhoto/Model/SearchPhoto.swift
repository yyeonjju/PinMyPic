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
    let user : PhotoUser
    
    enum CodingKeys : String, CodingKey {
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case id, width, height, color, urls, likes, user
    }
    
    var resolutionText : String{
        return "\(width) x \(height)"
    }
}

struct PhotoURL : Decodable {
    let regular : String
    let small : String
}

struct PhotoUser : Decodable{
    let name : String
    let profileImage : PhotoUserProfileImage
    
    enum CodingKeys : String, CodingKey{
        case name
        case profileImage = "profile_image"
    }
    
}

struct PhotoUserProfileImage : Decodable {
    let medium : String
}
