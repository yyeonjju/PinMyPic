//
//  NicknameSettingView.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import UIKit
import SnapKit

final class NicknameSettingView : BaseView {
    
    // MARK: - UI
    let profileCircleView = ProfileCircleView(width: Constants.Size.bigProfileImageWidth)
    
    let nicknameTextFieldView = NormalTextFieldView(placeholder: Texts.Placeholder.nicknameTextField)
    
    let mbtiLabel = {
       let label = UILabel()
        label.text = "MBTI"
        label.font = Font.bold16
        return label
    }()
    
    let mbtiCollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionVewLayout(numberofItemInrow: 4, cellIneterSpacing: 4,sectionSpacing : 0, totalWidth: Constants.Size.mbtiCollectionViewWidth))
//        cv.backgroundColor = .cyan
        return cv
    }()
    
    let deleteAccountButton = {
        let btn = UIButton()
        btn.setTitle("회원탈퇴", for: .normal)
        btn.setTitleColor(Assets.Colors.mainBlue, for: .normal)
        btn.titleLabel?.font = Font.regular13
        btn.isHidden = true
        return btn
    }()

    
    let completeButton = MainNormalButton(title: "완료")
    
    
    // MARK: - ConfigureUI
    
    override func configureSubView() {
        [profileCircleView, nicknameTextFieldView, completeButton, mbtiLabel, mbtiCollectionView, deleteAccountButton]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        profileCircleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
        }
        
        nicknameTextFieldView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.top.equalTo(profileCircleView.snp.bottom).offset(30)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.top.equalTo(nicknameTextFieldView.snp.bottom).offset(30)
        }
        
        mbtiCollectionView.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextFieldView.snp.bottom).offset(30)
            make.width.equalTo(Constants.Size.mbtiCollectionViewWidth)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(200)
        }
        
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(50)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        deleteAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(30)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
}
