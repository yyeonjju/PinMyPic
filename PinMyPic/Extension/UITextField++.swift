//
//  UITextField++.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import UIKit

extension UITextField {
    func configurePlaceholderColor(_ placeholder: String, _ color : UIColor = Assets.Colors.gray2) {
        let centeredParagraphStyle = NSMutableParagraphStyle()
//        centeredParagraphStyle.alignment = .center
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : color, .paragraphStyle: centeredParagraphStyle])
    }
}

