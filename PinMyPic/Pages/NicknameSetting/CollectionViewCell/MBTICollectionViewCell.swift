//
//  MBTICollectionViewCell.swift
//  PinMyPic
//
//  Created by 하연주 on 7/24/24.
//

import UIKit

final class MBTICollectionViewCell : UICollectionViewCell {
    private let circleCharacter = CircleBorderCharacterView()
    
    // MARK: - Initializer
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        configureSubView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureData
    func configureData(data : MbtiItem) {
        circleCharacter.characterLabel.text = data.itemInitialString
        circleCharacter.configureSelectedUI(isSelected: data.isSelected)
    }

    
    // MARK: - ConfigureUI
    
    private func configureSubView() {
        [circleCharacter]
            .forEach{
                contentView.addSubview($0)
            }
    }
    
    private func configureLayout() {
        circleCharacter.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }

}


