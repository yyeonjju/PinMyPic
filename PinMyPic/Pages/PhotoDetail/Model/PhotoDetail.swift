//
//  PhotoDetail.swift
//  PinMyPic
//
//  Created by 하연주 on 7/28/24.
//

import Foundation

struct PhotoStatistic : Decodable{
    let id : String
    let downloads : PhotoDownload
    let views : PhotoDownload
}

struct PhotoDownload : Decodable {
    let total : Int
    let historical : PhotoHistorical
}

struct PhotoHistorical : Decodable {
    let values : [PhotoHistoricalValue]
}

struct PhotoHistoricalValue : Decodable {
    let date : String
    let value : Int
}
