//
//  OnboardingViewController.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import UIKit

class OnboardingViewController : UIViewController {
    // MARK: - UI
    let viewManager = OnboardingView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        
        view = viewManager
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddTarget()
    }
    
    
    // MARK: - AddTarget
    private func setupAddTarget() {
        viewManager.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    // MARK: - EventSelector
    @objc private func startButtonTapped() {
        let vc = NicknameSettingViewController()
        pageTransition(to: vc, type: .push)
    }

}


