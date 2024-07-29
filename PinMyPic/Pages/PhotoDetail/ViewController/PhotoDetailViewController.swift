//
//  PhotoDetailViewController.swift
//  PinMyPic
//
//  Created by 하연주 on 7/28/24.
//

import UIKit
import Toast

final class PhotoDetailViewController : UIViewController {
    // MARK: - UI
    private let viewManager = PhotoDetailView()
    
    // MARK: - Properties
    private let vm = PhotoDetailViewModel()
    var photoData : PhotoResult?
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBind()
        setupBasicData()
        setupDelegate()
        addLikeImageGestureEvent()
    }
    
    // MARK: - SetupBind
    private func setupBind() {
        vm.inputImageId.value = photoData?.id
        
        vm.outputErrorMessage.bind(onlyCallWhenValueDidSet: true) {[weak self] message in
            guard let self else{return }
            self.view.makeToast(message, position: .top)
        }
        
        vm.outputStatisticData.bind(onlyCallWhenValueDidSet: true) {[weak self] data in
            guard let self else{return }
            self.viewManager.photoInformationTableView.reloadData()
        }
        vm.outputConfigureLikeImageTrigger.bind(onlyCallWhenValueDidSet: true) {[weak self] _ in
            guard let self else{return }
            configureLikeStatusImage()
        }
    }

    
    // MARK: - SetupBasicData
    private func setupBasicData() {
        viewManager.uploaderProfileImageView.loadImage(urlString: photoData?.user.profileImage.medium ?? "")
        viewManager.uploaderNameLabel.text = photoData?.user.name ?? "-"
        viewManager.createdAtLabel.text = photoData?.createdAt ?? "-"
        
        configureLikeStatusImage()
        configurePhotoImage()

    }
    
    private func configurePhotoImage() {
        viewManager.photoImageView.loadImage(urlString: photoData?.urls.small ?? "", filename:photoData?.id)
    }
    
    private func configureLikeStatusImage(){
        let isLiked = vm.likedItemListData.map{$0.imageId}.contains(photoData?.id)
        let image = isLiked ? Assets.Images.like : Assets.Images.tabLikeInactive
        viewManager.likeImageView.image = image
    }
    
    
    // MARK: - AddGestureEvent
    private func addLikeImageGestureEvent() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likeImageTapped))
        viewManager.likeImageView.isUserInteractionEnabled = true
        viewManager.likeImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func likeImageTapped() {
        guard let photoData, let image = viewManager.photoImageView.image else {return}
        
        let likedTappedPhoto = LikedPhotoInfo(imageId: photoData.id, savedDate: Date(), uploaderName: photoData.user.name, uploaderProfileImage: photoData.user.profileImage.medium, createdAt: photoData.createdAt, width: photoData.width, height: photoData.height, imageURL: photoData.urls.small)
        vm.inputLikeButtonTapped.value = (likedTappedPhoto, image)
        
    }


    
    
    // MARK: - SetupDelegate
    private func setupDelegate() {
        viewManager.photoInformationTableView.dataSource = self
        viewManager.photoInformationTableView.delegate = self
        viewManager.photoInformationTableView.register(PhotoInformationTableViewCell.self, forCellReuseIdentifier: PhotoInformationTableViewCell.description())
    }
}

extension PhotoDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.informationOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoInformationTableViewCell.description(), for: indexPath) as! PhotoInformationTableViewCell
        let infoOption : PhotoDetailViewModel.PhotoInformationOptions = vm.informationOptions[indexPath.row]
        var statisticText = "-"
        switch infoOption {
        case .resolution:
            statisticText = photoData?.resolutionText ?? "-"
        case .views:
            if let views = vm.outputStatisticData.value?.views.total {
                statisticText = views.formatted()
            }
        case .downloads:
            if let downloads = vm.outputStatisticData.value?.downloads.total {
                statisticText = downloads.formatted()
            }
        }
        cell.configureData(title: infoOption.rawValue, ststisticInfo: statisticText)
        return cell
    }
}
