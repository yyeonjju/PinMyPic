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
            if let user = UserInfoRepository.shared.getUser(tableModel: UserInfo.self){
                //유저 있다면
                sceneDelegate?.changeRootViewControllerToHome()
            }else{
                //유저 없다면
                sceneDelegate?.changeRootViewControllerToOnboarding()
            }
        }
        
    }
}
