//
//  CornerRadiusButton .swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit

final class CornerRadiusButton : UIButton {
    
    var title : String? {
        didSet{
            guard let title else{return}
            self.configuration?.title = title
        }
    }

    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.titleLabel?.font = Font.bold13
        self.layer.cornerRadius = self.bounds.height/2
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.titleLabel?.font = Font.bold13
    }
    
    // MARK: - Initializer
    
    init(title : String,
         image : UIImage?,
         imageTintColor : UIColor? = nil,
         allowSelection : Bool,
         normalTitleColor : UIColor = Assets.Colors.black,
         selectedTitleColor :  UIColor = Assets.Colors.white,
         normalBgColr : UIColor = .clear,
         selectedBgColor : UIColor = Assets.Colors.mainBlue,
         normalBorderColor : UIColor = Assets.Colors.gray3,
         selectedBorderoColor : UIColor = .clear
    ) {
        super.init(frame: .zero)
        
        self.title = title
        
        //Button UI 설정
        self.layer.borderWidth = 2
        self.layer.borderColor = normalBorderColor.cgColor
        self.layer.masksToBounds = true
        self.configuration = makeConfig(title: title, normalTitleColor: normalTitleColor, image : image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    private func makeConfig(title:String, normalTitleColor:UIColor, image : UIImage?) -> UIButton.Configuration{
        var config = UIButton.Configuration.borderedTinted()
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        //title
        config.title = title
        //image
        config.image = image
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 10)
        config.preferredSymbolConfigurationForImage = imageConfig
        config.imagePlacement = .leading
        config.imagePadding = 8
        
        
        config.baseForegroundColor = normalTitleColor
        config.baseBackgroundColor = .white
        config.titleAlignment = .center
        config.buttonSize = .small
        return config

    }

}
