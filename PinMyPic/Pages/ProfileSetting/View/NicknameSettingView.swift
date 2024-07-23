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
    
    let nicknameTextFieldView = NormalTextFieldView(placeholder: "닉네임을 입력해주세요 :)")
    
    let completeButton = MainNormalButton(title: "완료")
    
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
        [profileCircleView, nicknameTextFieldView, completeButton]
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
            make.top.equalTo(profileCircleView.snp.bottom).offset(40)
        }
        
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(50)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}
