//
//  ProfileImageSettingView.swift
//  PinMyPic
//
//  Created by 하연주 on 7/24/24.
//

import UIKit
import SnapKit

final class ProfileImageSettingView : BaseView {
    // MARK: - UI
    let profileCircleView : ProfileCircleView = {
        let view = ProfileCircleView(width: Constants.Size.bigProfileImageWidth)
        
        return view
    }()
    
    lazy var profileImageCollectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout:  configureCollectionVewLayout(numberofItemInrow: 4))
       
        return cv
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
    
    override func configureSubView() {
        [profileCircleView, profileImageCollectionView]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        profileCircleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
        }
        
        profileImageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(profileCircleView.snp.bottom).offset(30)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

}
