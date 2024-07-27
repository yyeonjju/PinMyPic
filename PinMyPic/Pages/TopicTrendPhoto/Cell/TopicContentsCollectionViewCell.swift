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
    
    // MARK: - Initializer
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        configureSubView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ConfigureUI
    
    private func configureSubView() {
        [photoImageView]
            .forEach{
                contentView.addSubview($0)
            }
    }
    
    private func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }

}


