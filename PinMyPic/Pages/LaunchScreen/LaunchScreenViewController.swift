//
//  LaunchScreenViewController.swift
//  PinMyPic
//
//  Created by 하연주 on 7/29/24.
//

import UIKit

final class LaunchScreenViewController : OnboardingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewManager.startButton.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            let userInfoRepository = UserInfoRepository()
            let noUser = userInfoRepository.getUser(tableModel: UserInfo.self) == nil
            
            
            if noUser {
                print("📍📍📍 유저 없음!")
                sceneDelegate?.changeRootViewControllerToOnboarding()
            }else{
                print("📍📍📍 유저 있음!")
//                if let user = userInfoRepository.getUser(tableModel: UserInfo.self) {
//                    userInfoRepository.removeItem(user)
//                }
                sceneDelegate?.changeRootViewControllerToHome()
            }
        }
        
    }
}
