//
//  Separator.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import UIKit
import SnapKit

final class Separator: UIView {
    
    init(color : UIColor = Assets.Colors.gray3) {
        super.init(frame: .zero)
        
        self.backgroundColor = color
        self.clipsToBounds = true
        self.layer.cornerRadius = 1
        
        self.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

