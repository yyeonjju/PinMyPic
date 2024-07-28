//
//  PhotoInformationTableViewCell.swift
//  PinMyPic
//
//  Created by 하연주 on 7/28/24.
//

import UIKit
import SnapKit

final class PhotoInformationTableViewCell : UITableViewCell {
    // MARK: - UI
    let titleTextLabel = {
        let label = UILabel()
        label.text = "title"
        label.font = Font.bold16
        return label
    }()
    
    let statisticInfoLabel = {
        let label = UILabel()
        label.text = "statistic"
        label.textColor = Assets.Colors.gray1
        return label
    }()
    
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureData
    func configureData(title : String,ststisticInfo : String) {
        titleTextLabel.text = title
        statisticInfoLabel.text = ststisticInfo
    }
    
    // MARK: - ConfigureUI
    
    private func configureSubView() {
        [titleTextLabel, statisticInfoLabel]
            .forEach{
                contentView.addSubview($0)
            }
    }
    
    private func configureLayout() {
        titleTextLabel.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(contentView)
        }
        statisticInfoLabel.snp.makeConstraints { make in
            make.trailing.verticalEdges.equalTo(contentView)
        }
    }

}


