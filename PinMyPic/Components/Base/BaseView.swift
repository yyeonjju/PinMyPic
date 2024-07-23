//
//  BaseView.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import UIKit

class BaseView : UIView {
    // MARK: - UI
    
    // MARK: - Initializer
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        configureBackgroundColor()
        configureSubView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ConfigureUI
    
    func configureSubView() {
    }
    
    func configureLayout() {
        
    }

}

