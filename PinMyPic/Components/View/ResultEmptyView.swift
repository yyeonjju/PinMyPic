//
//  ResultEmptyView.swift
//  PinMyPic
//
//  Created by 하연주 on 7/26/24.
//

import UIKit
import SnapKit

final class ResultEmptyView : BaseView {
    // MARK: - UI
    let labal = {
        let label = UILabel()
        label.textColor = Assets.Colors.black
        label.font = Font.bold16
        label.text = "-"
        return label
    }()
    
    
    // MARK: - ConfigureUI
    
    override func configureSubView() {
        [labal]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        labal.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }

}
