//
//  NameSpace.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import UIKit


enum Assets{
    enum Images {
        static let launchImage = UIImage(named: "launchImage")
        static let sort = UIImage(named: "sort")
        
        static let likeCircleInactive = UIImage(named: "like_circle_inactive")
        static let likeCircle = UIImage(named: "like_circle")
        
        static let likeInactive = UIImage(named: "like_inactive")
        static let like = UIImage(named: "like")
        
        
        //탭이미지
        static let tabLikeInactive = UIImage(named: "tab_like_inactive")
        static let tabLike = UIImage(named: "sort")
        static let tabRandomInactive = UIImage(named: "tab_random_inactive")
        static let tabRandom = UIImage(named: "tab_random")
        static let tabSearchInactive = UIImage(named: "tab_search_inactive")
        static let tabSearch = UIImage(named: "tab_search")
        static let tabTrend = UIImage(named: "tab_trend")
        static let tapTrendInactive = UIImage(named: "tap_trend_inactive")
    }
    
    
    enum Colors {
        static let mainBlue = UIColor(named: "mainBlue")
        static let pointPink = UIColor(named: "pointPink")
        static let black = UIColor(named: "black")
        static let gray1 = UIColor(named: "gray1")
        static let gray2 = UIColor(named: "gray2")
        static let gray3 = UIColor(named: "gray3")
        static let white = UIColor(named: "white")
    }
}


enum Font {
    static let regular13 = UIFont.systemFont(ofSize: 13)
    static let regular14 = UIFont.systemFont(ofSize: 14)
    static let regular15 = UIFont.systemFont(ofSize: 15)
    static let regular16 = UIFont.systemFont(ofSize: 16)
    
    static let bold13 = UIFont.boldSystemFont(ofSize: 13)
    static let bold14 = UIFont.boldSystemFont(ofSize: 14)
    static let bold15 = UIFont.boldSystemFont(ofSize: 15)
    static let bold16 = UIFont.boldSystemFont(ofSize: 16)
}


enum ProfileImageName {
    static let profile0 = "profile_0"
    static let profile1 = "profile_1"
    static let profile2 = "profile_2"
    static let profile3 = "profile_3"
    static let profile4 = "profile_4"
    static let profile5 = "profile_5"
    static let profile6 = "profile_6"
    static let profile7 = "profile_7"
    static let profile8 = "profile_8"
    static let profile9 = "profile_9"
    static let profile10 = "profile_10"
    static let profile11 = "profile_11"
    
    static let profileImageNameList = [ProfileImageName.profile0, ProfileImageName.profile1, ProfileImageName.profile2, ProfileImageName.profile3, ProfileImageName.profile4, ProfileImageName.profile5, ProfileImageName.profile6, ProfileImageName.profile7, ProfileImageName.profile8, ProfileImageName.profile9, ProfileImageName.profile10, ProfileImageName.profile11]
    
    static func returnRandomProfileImageName() -> String {
        return profileImageNameList.randomElement()!
    }
}
