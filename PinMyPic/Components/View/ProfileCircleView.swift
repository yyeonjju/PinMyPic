//
//  ProfileCircleView.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import UIKit
import SnapKit

final class ProfileCircleView : UIView {
    // MARK: - UI
    private let imageContentView : UIView = {
        let view = UIView()
        view.layer.borderColor = Assets.Colors.mainBlue.cgColor
        view.layer.borderWidth = 3
        view.clipsToBounds = true
        return view
    }()
    
    let imageView : UIImageView = {
        let iv = UIImageView()
//        iv.image = AssetImage.profile0
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let cameraIconView : UIView = {
        let view = UIView()
        view.backgroundColor = Assets.Colors.mainBlue
        view.layer.borderColor = .none
        return view
    }()
    
    private let cameraIconImage : UIImageView = {
        let iv = UIImageView()
        iv.image = Assets.IconImage.cameraFill
        iv.tintColor = Assets.Colors.white
        return iv
    }()
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageContentView.layer.cornerRadius = imageContentView.frame.width/2
        cameraIconView.layer.cornerRadius = cameraIconView.frame.width/2
    }
    
    // MARK: - Initializer
    
    init(width : CGFloat, isCameraIconShown : Bool = true) {
        super.init(frame: .zero)
        
        if !isCameraIconShown {
            cameraIconView.alpha = 0
        }
        
        configureSubView()
        configureLayout(width : width)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ConfigureUI
    
    func configureSubView() {
        [imageContentView, cameraIconView]
            .forEach{
                addSubview($0)
            }
        
        [imageView]
            .forEach{
                imageContentView.addSubview($0)
            }
        
        [cameraIconImage]
            .forEach {
                cameraIconView.addSubview($0)
            }
    }
    
    func configureLayout(width : CGFloat) {
        self.snp.makeConstraints { make in
            make.size.equalTo(width)
        }
        
        imageContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cameraIconView.snp.makeConstraints { make in
            make.size.equalTo(width/3.5)
            make.centerX.equalTo(imageView.snp.trailing).inset(width/6)
            make.centerY.equalTo(imageView.snp.bottom).inset(width/6)
        }
        
        cameraIconImage.snp.makeConstraints { make in
            make.size.equalTo(width/6)
            make.center.equalToSuperview()
        }
    }
    
    func configureSelectedUI(isSelected : Bool){
        if isSelected {
            imageContentView.layer.borderColor = Assets.Colors.mainBlue.cgColor
            imageContentView.layer.borderWidth = 3
            imageContentView.alpha = 1
        } else {
            imageContentView.layer.borderColor = Assets.Colors.gray3.cgColor
            imageContentView.layer.borderWidth = 1
            imageContentView.alpha = 0.5
            
        }
        
    }

}

