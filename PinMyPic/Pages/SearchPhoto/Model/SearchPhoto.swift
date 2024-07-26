//
//  SearchPhoto.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import Foundation


struct SearchPhoto : Decodable {
    let total : Int
    let total_pages : Int
    let results : [PhotoResult]
}

struct PhotoResult : Decodable{
    let id : String
    let created_at : String
    let updated_at : String
    let width : Int
    let height : Int
    let color : String
    let urls : PhotoURL
    let likes : Int
}

struct PhotoURL : Decodable {
    let regular : String
    let small : String
}
