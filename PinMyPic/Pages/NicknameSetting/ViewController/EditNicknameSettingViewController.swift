//
//  EditNicknameSettingViewController.swift
//  PinMyPic
//
//  Created by 하연주 on 7/29/24.
//

import UIKit

final class EditNicknameSettingViewController : NicknameSettingViewController {
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Edit Profile"
        
        setupUserData()
        modifyUI()
    }
    
    // MARK: - Override Method

    override func configureCompleteButton(isActivate: Bool) {
        configureNavigation(isActivate: isActivate)
    }


    
    // MARK: - Own Method

    private func setupUserData() {
        //닉네임
        if let nickname = vm.userInfoData?.nickname{
            viewManager.nicknameTextFieldView.textField.text = nickname
            vm.inputNicknameText.value = nickname
        }
        
        //프로필이미지
        if let profileImageName = vm.userInfoData?.profileImageName{
            vm.inputSelectedProfileImageName.value = profileImageName
        }
        
        //mbti
        if let userMbti = vm.userInfoData?.mbti {
            for mbtiItemInitialString in userMbti {
                if let item = vm.mbtiItemList.first(where: {$0.itemInitialString == mbtiItemInitialString}) {
                    vm.inputSelectedMbti.value = item
                }
                
            }
        }

    }
    
    private func modifyUI() {
        viewManager.completeButton.isHidden = true
    }
    
    private func configureNavigation(isActivate : Bool) {
        let saveBtn = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        saveBtn.tintColor = isActivate ? Assets.Colors.black : Assets.Colors.gray2
        navigationItem.rightBarButtonItem = saveBtn
    }
    
    @objc private func saveButtonClicked() {
        vm.inputCompleteButtonValidation.value = viewManager.nicknameTextFieldView.textField.text
    }
    
}
