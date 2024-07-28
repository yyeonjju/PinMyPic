//
//  ETC.swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import Foundation

enum PageMode {
    case create
    case edit
}

enum SortOrder : String {
    case relevant
    case latest
    case oldest
    
    var koText : String {
        switch self {
        case .relevant:
            "관련순"
        case .latest:
            "최신순"
        case .oldest :
            "과거순"
        }
    }
}

