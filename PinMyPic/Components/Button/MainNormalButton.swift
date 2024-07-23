//
//  MainNormalButton.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import UIKit
import SnapKit

final class MainNormalButton : UIButton{

    // MARK: - Initializer
    init(title : String, bgColor : UIColor = Assets.Colors.mainBlue) {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 25
        self.backgroundColor = bgColor
        self.setTitleColor(Assets.Colors.white, for: .normal)
        self.setTitle(title, for: .normal)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
