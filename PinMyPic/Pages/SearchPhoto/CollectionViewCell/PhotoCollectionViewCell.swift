//
//  PhotoCollectionViewCell.swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit
import SnapKit

final class PhotoCollectionViewCell : UICollectionViewCell {
    // MARK: - UI
    private let photoImageView = {
        let iv = UIImageView()
        iv.configureDefaultImageView()
        return iv
    }()
    
    private let likedAmount = CornerRadiusButton(title: "---", image: UIImage(systemName: "star.fill"), imageTintColor:.yellow, allowSelection: false, normalTitleColor : Assets.Colors.white, normalBgColr : Assets.Colors.gray1, normalBorderColor : .clear)
    
    private let likeImageView = {
       let iv = UIImageView()
        iv.image = Assets.Images.likeCircle
        return iv
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
    func configureData(data : PhotoResult) {
        likedAmount.setTitle(data.likes.formatted(), for: .normal)
        photoImageView.loadImage(urlString: data.urls.small)
        
        
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
    }

}
