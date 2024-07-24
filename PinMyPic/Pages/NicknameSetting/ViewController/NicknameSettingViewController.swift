//
//  NicknameSettingViewController.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import UIKit
import Toast
import RealmSwift





final class NicknameSettingViewController : UIViewController {
    // MARK: - UI
    private let viewManager = NicknameSettingView()
    
    // MARK: - Properties
    var pageMode : PageMode = .create
    let vm = NicknameSettingViewModel()
    let userInfo = UserInfo()

    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setupAddTarget()
        setupGestureEvent()
        if pageMode == .create {
            vm.inputViewDidLoadTrigger.value = ()
        }
        
        bindData()
    }
    
    // MARK: - BindData
    func bindData() {
        //💚💚 outputValidationNoticeText, mbti 모두 선택되었나에 대한 output bind에 버튼 색깔 configure해주는 코드 실행해주기
        
        vm.outputValidationNoticeText.bind(onlyCallWhenValueDidSet: true) { [weak self] value in
            guard let self else {return }
            self.changeWarningLabel(value)
        }
        
        vm.outputCountResettingNicknameText.bind { [weak self] value in
            guard let self else {return }
            viewManager.nicknameTextFieldView.textField.text = value
        }
        
        vm.outputProfileImageName.bind { [weak self] value in
            guard let self else {return }
            //userInfo 객체에 임시 저장
            self.userInfo.profileImageName = value
            configureProfileImage(imageName : value)
        }
        
        vm.outputPermitToPageTransition.bind(onlyCallWhenValueDidSet: true) {[weak self]  _ in
            guard let self else {return }
            if self.pageMode == .create {
                ///루트뷰 변경
                print("💚💚 루트뷰 변경")
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                sceneDelegate?.changeRootViewControllerToHome()
            }else {
                ///pop 뷰컨트롤러
                print("💚💚 pop 뷰컨트롤러")
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        vm.outputMbtiList.bind(onlyCallWhenValueDidSet: true) {[weak self] list in
            guard let self else {return }
            self.viewManager.mbtiCollectionView.reloadData()
            vm.setupMbtiInitialStringList()
        }

    }
    
    // MARK: - SetupDelegate
    private func setupDelegate() {
        viewManager.nicknameTextFieldView.textField.delegate = self
        
        viewManager.mbtiCollectionView.dataSource = self
        viewManager.mbtiCollectionView.delegate = self
        viewManager.mbtiCollectionView.register(MBTICollectionViewCell.self, forCellWithReuseIdentifier: MBTICollectionViewCell.description())
    }

    // MARK: - AddTarget
    private func setupAddTarget() {
        viewManager.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        viewManager.nicknameTextFieldView.textField.addTarget(self, action: #selector(nicknameTextFieldDidChange), for: .editingChanged)
    }
    
    private func setupGestureEvent() {
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        viewManager.profileCircleView.addGestureRecognizer(imageTapGesture)
    }
    
    // MARK: - EventSelector
    @objc func completeButtonTapped() {
        guard let textCount = viewManager.nicknameTextFieldView.textField.text?.count else {return }

        if textCount >= Constants.NicknameValidation.textMinCount 
            && textCount <= Constants.NicknameValidation.textMaxCount{
            showAlert(title: Texts.AlertTitle.profileSettingComplete, message: nil, style: .alert){[weak self] in
                guard let self else{return }
                //확인버튼 누르면 해줄 작업
                
                //입력한 닉네임 저장
                self.userInfo.nickname = viewManager.nicknameTextFieldView.textField.text!
                //선택한 프로필 이미지 이름 저장
                self.userInfo.profileImageName = vm.outputProfileImageName.value
                //선택한
                let mbtiRealmList = List<String>()
                vm.outputMbtiInitialStringList.forEach{
                    mbtiRealmList.append($0)
                }
                self.userInfo.mbti = mbtiRealmList
                if self.pageMode == .create{
                    // 가입한 날짜 저장
                    self.userInfo.registerDate = Date()
                }
                
                vm.inputPermitToSaveProfile.value = self.userInfo
                
            }
        }else {
            self.view.makeToast(Texts.ToastMessage.checkProfileInput, duration: 2.0, position: .top)
        }

    }
    
    @objc func nicknameTextFieldDidChange() {
        vm.inputNicknameText.value = viewManager.nicknameTextFieldView.textField.text

    }
    
    @objc func profileImageTapped() {
        let vc = ProfileImageSettingViewController()
        vc.pageMode = pageMode
        vc.selectedProfileImageName = userInfo.profileImageName
        vc.willDisappear = {[weak self] selectedImageName in
            guard let self else{return }
            vm.inputSelectedProfileImageName.value = selectedImageName
        }
        pageTransition(to: vc, type: .push)
    }
    
    // MARK: - Method
    
    func changeWarningLabel(_ noticeText : String = "") {
        
        let targetLabel = viewManager.nicknameTextFieldView.warningLabel
        if noticeText.isEmpty {
            targetLabel.text = Texts.NicknameValidationNoticeText.validNickname
            targetLabel.textColor = Assets.Colors.mainBlue
            targetLabel.alpha = 1
        }else {
            targetLabel.text = noticeText
            targetLabel.textColor = Assets.Colors.pointPink
            targetLabel.alpha = 1
        }

    }
    
    private func configureProfileImage(imageName : String) {
        viewManager.profileCircleView.imageView.image = UIImage(named: imageName)
    }
    
}



extension NicknameSettingViewController : UITextFieldDelegate{
    //입력할때마다
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        vm.inputNicknameWillReplaced.value = string
        return vm.outputChatacterValidation.value
    }
}


extension NicknameSettingViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let list = vm.outputMbtiList.value else{return 0}
        return list.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MBTICollectionViewCell.description(), for: indexPath) as! MBTICollectionViewCell
        guard let list = vm.outputMbtiList.value else{return cell}
        let data = list[indexPath.item]
        cell.configureData(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let list = vm.outputMbtiList.value else{return }
        let selectedMbti = list[indexPath.item]
        vm.inputSelectedMbti.value = selectedMbti
    }
}
 
