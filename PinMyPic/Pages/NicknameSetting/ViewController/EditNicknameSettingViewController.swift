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
        
        navigationItem.title = Texts.PageTitle.editProfile
        configureNavigationBackButtonItem()
        setupUserData()
        modifyUI()
        addTarget()
    }
    
    // MARK: - Override Method

    override func configureCompleteButton(isActivate: Bool) {
        configureNavigation(isActivate: isActivate)
    }
    
    override func setupBind() {
        super.setupBind()
        
        vm.outputChangeRootVCToOnboarding.bind(onlyCallWhenValueDidSet: true) {[weak self] _ in
            guard let self else{return}
            ///루트뷰 변경
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.changeRootViewControllerToOnboarding()
        }
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
        viewManager.deleteAccountButton.isHidden = false
    }
    
    private func addTarget() {
        viewManager.deleteAccountButton.addTarget(self, action: #selector(deleteAccountButtonTapped), for: .touchUpInside)
    }
    
    @objc private func deleteAccountButtonTapped() {
        showAlert(title: "정말 탈퇴하시겠습니까?", message: "탈퇴하면 모든 정보가 사라집니다.", style: .alert) {[weak self] in
            guard let self else{return}
            vm.inputRequestToDeleteAccount.value = ()
        }
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
