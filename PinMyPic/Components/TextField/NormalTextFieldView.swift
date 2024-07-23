//
//  NormalTextFieldView.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import UIKit
import SnapKit

final class NormalTextFieldView : UIView {
    
    // MARK: - UI
    let textField = {
        let tf = UITextField()
        tf.layer.borderColor = .none
        return tf
    }()
    
    private let textFieldUnderLine = Separator(color: Assets.Colors.gray3)
    
    let warningLabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = Assets.Colors.mainBlue
        label.textAlignment = .left
        label.font = Font.regular14
        label.alpha = 0
        return label
    }()
    
    // MARK: - Initializer
    
    init(placeholder : String) {
        super.init(frame: .zero)
        
        textField.configurePlaceholderColor(placeholder)
        
        configureSubView()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ConfigureUI
    
    func configureSubView() {
        [textField, textFieldUnderLine, warningLabel]
            .forEach{
                addSubview($0)

            }
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(40)
        }
        
        textFieldUnderLine.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
        }
        
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldUnderLine.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.snp.bottom)
        }
        
    }

    
    
}
