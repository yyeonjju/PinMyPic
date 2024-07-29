//
//  DateFormatManager.swift
//  PinMyPic
//
//  Created by 하연주 on 7/29/24.
//

import Foundation

final class DateFormatManager {
    static let shared = DateFormatManager()
    private init() {}
    
    enum FormatString : String {
        case fullDateAndTime = "yyyy-MM-dd'T'HH:mm:ss'Z"
        case koDate = "yyyy년 M월 d일"
    }
    
    private let krDateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ko_KR")
        return formatter
    }()
    
    
    func getDateFormatter(format : FormatString, timeZone : TimeZone? = TimeZone(identifier: TimeZone.current.identifier)) -> DateFormatter {
        let formatter = krDateFormatter
        formatter.dateFormat = format.rawValue
        formatter.timeZone = timeZone
        return formatter
    }
}

