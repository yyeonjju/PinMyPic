//
//  PhotoDetailView.swift
//  PinMyPic
//
//  Created by 하연주 on 7/28/24.
//

import UIKit
import SnapKit

final class PhotoDetailView : BaseView {
    // MARK: - UI
    let uploaderProfileImageView = {
        let iv = UIImageView()
        iv.backgroundColor = Assets.Colors.gray2
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let uploaderNameLabel = {
        let label = UILabel()
        label.text = "이름이다"
        label.font = Font.regular14
        return label
    }()
    
    let createdAtLabel = {
        let label = UILabel()
        label.text = "---년 --월 - 일 "
        label.font = Font.bold13
        return label
    }()
    
    let likeImageView = {
        let iv = UIImageView()
        iv.image = Assets.Images.like
        return iv
    }()
    
    let photoImageView = {
        let iv = UIImageView()
        iv.configureDefaultImageView()
        return iv
    }()
    
    private let informationText = {
        let label = UILabel()
        label.text = "정보"
        label.font = Font.bold18
        return label
    }()
    
    let photoInformationTableView = {
        let tv = UITableView()
        tv.rowHeight = 28
        tv.isScrollEnabled = false
        tv.allowsSelection = false
        return tv
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        uploaderProfileImageView.layer.cornerRadius = uploaderProfileImageView.frame.width/2
        
    }
    
    // MARK: - ConfigureUI
    
    override func configureSubView() {
        [uploaderProfileImageView, uploaderNameLabel, createdAtLabel, likeImageView, photoImageView, informationText, photoInformationTableView]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        uploaderProfileImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(10)
        }
        uploaderNameLabel.snp.makeConstraints { make in
            make.top.equalTo(uploaderProfileImageView.snp.top)
            make.leading.equalTo(uploaderProfileImageView.snp.trailing).offset(8)
        }
        
        createdAtLabel.snp.makeConstraints { make in
            make.top.equalTo(uploaderNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(uploaderProfileImageView.snp.trailing).offset(8)
        }
        
        likeImageView.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.centerY.equalTo(uploaderProfileImageView.snp.centerY)
        }
        
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(uploaderProfileImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        
        informationText.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).inset(10)

        }
        
        photoInformationTableView.snp.makeConstraints { make in
            make.top.equalTo(informationText.snp.top)
            make.leading.equalTo(informationText.snp.trailing).offset(50)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(150)
        }
        
        
        
    }

}


