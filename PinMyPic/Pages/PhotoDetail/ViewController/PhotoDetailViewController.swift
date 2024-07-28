//
//  PhotoDetailViewController.swift
//  PinMyPic
//
//  Created by 하연주 on 7/28/24.
//

import UIKit

final class PhotoDetailViewController : UIViewController {
    // MARK: - UI
    private let viewManager = PhotoDetailView()
    
    // MARK: - Properties
    var imageId : String?
    var imageUrl : String?
    var uploaderInfo : PhotoUser?
    var createdAt : String?
    var isLiked : Bool?
    var wilDisappearClosure : (() -> Void)?
    
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBasicData()
        setupDelegate()
    }
    
    // MARK: - SetupBasicData
    private func setupBasicData() {
        viewManager.uploaderProfileImageView.loadImage(urlString: uploaderInfo?.profileImage.medium ?? "")
        
        viewManager.uploaderNameLabel.text = uploaderInfo?.name
        viewManager.createdAtLabel.text = createdAt
        viewManager.likeImageView.image = isLiked == true ? Assets.Images.like : Assets.Images.likeInactive
        
        if #available(iOS 16.0, *) {
            if let imageId, let image = ImageSavingManager.loadImageFromDocument(filename: imageId)  {
                //파일매니저에 저장된 이미지가 있으면
                viewManager.photoImageView.image = image
                return
            }
        }
        //파일매니저에 저장된 이미지가 없으면
        viewManager.photoImageView.loadImage(urlString: imageUrl ?? "")
        
        
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoInformationTableViewCell.description(), for: indexPath) as! PhotoInformationTableViewCell
        cell.configureData(title: "title--", ststisticInfo: "statistic--")
        return cell
    }
}
