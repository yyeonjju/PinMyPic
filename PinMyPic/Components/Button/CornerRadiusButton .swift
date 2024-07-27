//
//  CornerRadiusButton .swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit

final class CornerRadiusButton : UIButton {
//    
//    override var isSelected: Bool {
//        didSet {
//            print("button isSelected -> ", isSelected)
//        }
//        
//    }
    
    var title : String? {
        didSet{
            guard let title, let normalTitleColor else{return}
            self.configuration = makeConfig(title:title, normalTitleColor:normalTitleColor)
        }
    }
    var normalTitleColor : UIColor?
    
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
        self.normalTitleColor = normalTitleColor
    
//        self.isSelected = isSelected
//        self.normalTitleColor = normalTitleColor
//        self.selectedTitleColor = Color.white!
//        
//        //Button 타이틀 설정
//        self.setTitle(title, for: .normal)
//        ///isSelected = false 상태일 때 TitleColor
//        self.setTitleColor(normalTitleColor, for: .normal)
//        ///isSelected = true 상태일 때 TitleColor
//        self.setTitleColor(selectedTitleColor, for: .selected)
        
        //Button UI 설정
        self.layer.borderWidth = 2
        self.layer.borderColor = normalBorderColor.cgColor
        self.layer.masksToBounds = true
        
        self.backgroundColor = normalBgColr
//        self.setTitleColor(normalTitleColor, for: .normal)
        
        let img = image?.withRenderingMode(.alwaysTemplate)
        self.setImage(img, for: .normal)
//        self.tintColor = .yellow
        
        
        self.configuration = makeConfig(title: title, normalTitleColor: normalTitleColor)

        
//        self.titleLabel?.font = .systemFont(ofSize: 10)
        
        

        

        
//        configureButtonBackgroundColor(
//            isSelected: isSelected,
//            normalTitleColor : normalTitleColor,
//            selectedTitleColor : selectedTitleColor
//        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    private func makeConfig(title:String, normalTitleColor:UIColor) -> UIButton.Configuration{
        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        config.title = title
        config.baseForegroundColor = normalTitleColor
//        config.baseBackgroundColor = normalBgColr
        
//        config.background.cornerRadius = 10
//        config.background.strokeWidth = 2
        
        config.titleAlignment = .center
//        config.attributedTitle = Attri
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 10)
        config.preferredSymbolConfigurationForImage = imageConfig
        
        return config

    }
    
//    private func configureButtonBackgroundColor(isSelected: Bool, normalTitleColor : UIColor?, selectedTitleColor : UIColor?) {
//        guard let normalTitleColor else {return }
//
//        ///isSelected 상태에 따른 backgroundColor
//        self.backgroundColor = isSelected ? normalTitleColor : selectedTitleColor
//    }

}
