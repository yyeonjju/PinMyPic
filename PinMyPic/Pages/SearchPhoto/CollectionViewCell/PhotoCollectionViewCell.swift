//
//  PhotoCollectionViewCell.swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit
import SnapKit

final class PhotoCollectionViewCell : UICollectionViewCell {
    var toggleLikeStatus : ((UIImage?)->Void)?
    
    // MARK: - UI
    private let photoImageView = {
        let iv = UIImageView()
        iv.configureDefaultImageView()
        return iv
    }()
    
    private let likedAmount = CornerRadiusButton(title: "---", image: UIImage(systemName: "star.fill"), imageTintColor:.yellow, allowSelection: false, normalTitleColor : Assets.Colors.white, normalBgColr : Assets.Colors.gray1, normalBorderColor : .clear)
    
    private lazy var likeImageView = {
       let iv = UIImageView()
        iv.image = Assets.Images.likeCircle
        iv.isUserInteractionEnabled = true
        iv.addSubview(self.likeButton)
        return iv
    }()
    
    private lazy var likeButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializer
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        configureSubView()
        configureLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureData
    func configureData(data : PhotoResult, isLiked : Bool) {
        likedAmount.setTitle(data.likes.formatted(), for: .normal)
        likeImageView.image = isLiked ? Assets.Images.likeCircle : Assets.Images.likeCircleInactive
        //파일매니저에 저장된 이미지(좋아요한 이미지) 확인하고 없으면 url로 이미지 로드
        loadImage(imageId: data.id, urlString: data.urls.small)

    }
    
    
    // MARK: - AddEvent
    @objc func likeTapped() {
        toggleLikeStatus?(photoImageView.image)
    }
    
    
    // MARK: - ConfigureUI
    
    private func loadImage(imageId :String , urlString : String) {
        if #available(iOS 16.0, *) {
            if let image = ImageSavingManager.loadImageFromDocument(filename: imageId)  {
                //파일매니저에 저장된 이미지가 있으면
                photoImageView.image = image
                return
            }
        }
        //파일매니저에 저장된 이미지가 없으면
        photoImageView.loadImage(urlString: urlString)
    }
    
    private func configureSubView() {
        [photoImageView, likedAmount, likeImageView]
            .forEach{
                contentView.addSubview($0)
            }
    }
    
    private func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        likedAmount.snp.makeConstraints { make in
            make.leading.bottom.equalTo(contentView).inset(10)
            
        }
        
        likeImageView.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(contentView).inset(10)
            make.size.equalTo(30)
        }
        
        likeButton.snp.makeConstraints { make in
            make.edges.equalTo(likeImageView)
        }
    }

}
