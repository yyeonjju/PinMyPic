//
//  ProfileImageSettingViewController.swift
//  PinMyPic
//
//  Created by 하연주 on 7/24/24.
//

import UIKit

final class ProfileImageSettingViewController : UIViewController {
    // MARK: - UI
    let viewManager = ProfileImageSettingView()

    
    // MARK: - Properties
    var pageMode : PageMode?
    var selectedProfileImageName : String?
    var willDisappear : ((_ selectedImageName : String) -> Void)?
    let vm  = ProfileImageSettingViewModel()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Texts.PageTitle.profileImageSetting
//        navigationItem.backBarButtonItem?.title = ""
//        configureNavigationBackButtonItem()
//        configureBackgroundColor()
        bindData()

        setupDelegate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let selectedImageName = vm.outputSelectedImageName.value else {return }
        willDisappear?(selectedImageName)
    }
    
    // MARK: - ViewModelBind
    private func bindData() {
        vm.inputProfileImageName.value = selectedProfileImageName
        
        
        vm.outputSelectedImageName.bind { [weak self] name in
            guard let self else{return }
            self.configureProfileImage()
            viewManager.profileImageCollectionView.reloadData()
        }
        
    }

    

    // MARK: - SetupDelegate
    private func setupDelegate(){
        viewManager.profileImageCollectionView.dataSource = self
        viewManager.profileImageCollectionView.delegate = self
        viewManager.profileImageCollectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.description())
    }
    
    // MARK: - Method
    private func configureProfileImage() {
        guard let selectedImageName = vm.outputSelectedImageName.value else {return }
        viewManager.profileCircleView.imageView.image = UIImage(named: selectedImageName)
    }

}

extension ProfileImageSettingViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileImageName.profileImageNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.description(), for: indexPath) as! ProfileImageCollectionViewCell
        let cellImageName = ProfileImageName.profileImageNameList[indexPath.row]
        
        cell.configureData(imageName: cellImageName, isSelected: cellImageName == vm.outputSelectedImageName.value)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellImageName = ProfileImageName.profileImageNameList[indexPath.row]
        vm.inputProfileImageName.value = cellImageName
    }
    
}
