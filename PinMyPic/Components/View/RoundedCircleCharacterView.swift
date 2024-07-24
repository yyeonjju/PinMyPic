//
//  RoundedCircleCharacterView.swift
//  PinMyPic
//
//  Created by 하연주 on 7/24/24.
//

import UIKit
import SnapKit

final class CircleBorderCharacterView : UIView {
    // MARK: - UI
    let characterLabel = {
        let label = UILabel()
        label.text = "E"
        label.font = Font.bold18
        label.layer.masksToBounds = true
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.width/2
    }
    
    
    // MARK: - Init

    init(baseColor : UIColor = Assets.Colors.gray2, selectedColor : UIColor = Assets.Colors.mainBlue) {
        super.init(frame: .zero)
        
        characterLabel.textColor = baseColor
        self.layer.borderColor = baseColor.cgColor
        self.layer.borderWidth = 2
        
        
        
        configureSubView()
        configureLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - ConfigureUI

    func configureSubView() {
        [characterLabel]
            .forEach{
                self.addSubview($0)
            }
    }
    
    func configureLayout() {
        
        characterLabel.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
    
    
    func configureSelectedUI(isSelected : Bool){
        if isSelected {
            characterLabel.textColor = Assets.Colors.white
            self.backgroundColor = Assets.Colors.mainBlue
            self.layer.borderColor = Assets.Colors.mainBlue.cgColor
        } else {
            characterLabel.textColor = Assets.Colors.gray2
            self.backgroundColor = .clear
            self.layer.borderColor = Assets.Colors.gray2.cgColor
            
        }
        
    }
    
}
