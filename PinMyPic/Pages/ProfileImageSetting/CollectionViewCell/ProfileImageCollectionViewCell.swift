//
//  ProfileImageCollectionViewCell.swift
//  PinMyPic
//
//  Created by 하연주 on 7/24/24.
//

import UIKit
import SnapKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    // MARK: - UI
    private lazy var profileCircleView : ProfileCircleView = {
        let view = ProfileCircleView(width: contentView.frame.width, isCameraIconShown: false)
        return view
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
    func configureData(imageName : String, isSelected : Bool){
        profileCircleView.imageView.image = UIImage(named: imageName)
        profileCircleView.configureSelectedUI(isSelected: isSelected)
    }
    
    
    // MARK: - ConfigureUI
    
    private func configureSubView() {
        [profileCircleView]
            .forEach{
                contentView.addSubview($0)
            }
    }
    
    private func configureLayout() {
        profileCircleView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }

}

