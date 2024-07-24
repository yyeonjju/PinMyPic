//
//  OnboardingView.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import UIKit
import SnapKit

final class OnboardingView : BaseView{
   
    // MARK: - UI
    private let logoLabel = {
        let iv = UILabel()
        iv.text = "📍Pin My Pic"
        iv.font = .boldSystemFont(ofSize: 30)
        iv.textColor = Assets.Colors.mainBlue
        return iv
    }()
    
    private let launchImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = Assets.Images.launch
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let startButton = MainNormalButton(title : "시작하기")
    
    
    // MARK: - ConfigureUI
    
    override func configureSubView() {
        [logoLabel, launchImageView, startButton]
            .forEach{
                addSubview($0)

            }
    }
    
    override func configureLayout() {
        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.centerX.equalTo(safeAreaLayoutGuide)
//            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(70)
        }
        
        launchImageView.snp.makeConstraints { make in
            make.top.equalTo(logoLabel.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            make.height.equalTo(launchImageView.snp.width)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(50)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(30)
        }
    }
}


