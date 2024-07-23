//
//  ProfileImageSettingViewModel.swift
//  PinMyPic
//
//  Created by 하연주 on 7/24/24.
//

import Foundation


final class ProfileImageSettingViewModel {
    
    //input
    // 페이지 진입, 프로필 이미지를 선택하는 등 이미지가 수정되어야하는 시점
    var inputProfileImageName : Observable<String?> = Observable(nil)
    
    
    
    //output
    //선택한 프로필 이미지를 UI에 반영할 수 있도록
    var outputSelectedImageName: Observable<String?> = Observable(nil)
    
    
    init() {
        bindData()
    }
    
    private func bindData() {
        inputProfileImageName.bind(onlyCallWhenValueDidSet: true) { [weak self] name in
            guard let self else{return }
            outputSelectedImageName.value = name
        }
    }
}
