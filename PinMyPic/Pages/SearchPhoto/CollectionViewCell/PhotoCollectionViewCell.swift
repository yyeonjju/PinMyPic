//
//  PhotoCollectionViewCell.swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit
import SnapKit

final class PhotoCollectionViewCell : UICollectionViewCell {
    var toggleLikeStatus : (()->Void)?
    
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
        photoImageView.loadImage(urlString: data.urls.small)
        likeImageView.image = isLiked ? Assets.Images.likeCircle : Assets.Images.likeCircleInactive
    }
    
    
    // MARK: - AddEvent
    
    @objc func likeTapped() {
        toggleLikeStatus?()
    }
    
    
    // MARK: - ConfigureUI
    
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
