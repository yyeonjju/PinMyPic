//
//  PhotoCollectionViewCell.swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit
import SnapKit

class PhotoCollectionViewCell : UICollectionViewCell {
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
        backgroundColor = .gray2
        configureSubView()
        configureLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureData
    func configureData(likes : Int?, id : String, url : String?, isLiked : Bool) {
        likedAmount.setTitle(likes?.formatted(), for: .normal)
        likedAmount.isHidden = likes == nil
        
        likeImageView.image = isLiked ? Assets.Images.likeCircle : Assets.Images.likeCircleInactive
        //파일매니저에 저장된 이미지(좋아요한 이미지) 확인하고 없으면 url로 이미지 로드
        loadImage(imageId: id, urlString: url)

    }
    
    
    // MARK: - AddEvent
    @objc func likeTapped() {
        toggleLikeStatus?(photoImageView.image)
    }
    
    
    // MARK: - ConfigureUI
    
    private func loadImage(imageId :String , urlString : String?) {
        photoImageView.loadImage(urlString: urlString ?? "", filename : imageId)
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
