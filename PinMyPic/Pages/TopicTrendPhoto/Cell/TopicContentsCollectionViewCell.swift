//
//  TopicContentsCollectionViewCell.swift
//  PinMyPic
//
//  Created by 하연주 on 7/27/24.
//

import UIKit
import SnapKit

final class TopicContentsCollectionViewCell : UICollectionViewCell {
    // MARK: - UI
    private let photoImageView = {
        let iv = UIImageView()
        iv.configureDefaultImageView()
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    private let likedAmount = CornerRadiusButton(title: "---", image: UIImage(systemName: "star.fill"), imageTintColor:.yellow, allowSelection: false, normalTitleColor : Assets.Colors.white, normalBgColr : Assets.Colors.gray1, normalBorderColor : .clear)
    
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
        photoImageView.loadImage(urlString: data.urls.small, filename: data.id)
//        likedAmount.title = data.likes.formatted()
        likedAmount.setTitle(data.likes.formatted(), for: .normal)
    }
    
    
    // MARK: - ConfigureUI
    
    private func configureSubView() {
        [photoImageView, likedAmount]
            .forEach{
                contentView.addSubview($0)
            }
    }
    
    private func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        likedAmount.snp.makeConstraints { make in
            make.leading.bottom.equalTo(contentView).inset(4)
        }
    }

}


