//
//  TopicsTableViewCell.swift
//  PinMyPic
//
//  Created by 하연주 on 7/27/24.
//

import UIKit
import SnapKit

final class TopicsTableViewCell : UITableViewCell {
    // MARK: - UI
    let topicTitleLabel = {
       let label = UILabel()
        label.text = "하하하하"
        label.font = Font.bold18
        return label
    }()
    
    let topicContentsCollectionView = {
        let collectionViewLayout = configureCollectionVewLayout(scrollDirection: .horizontal, numberofItemInrow: 2, sectionSpacing : 10, height: Constants.Size.topicContentsCollectionViewHeight)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.showsHorizontalScrollIndicator = false
        
        return cv
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
    
    
    // MARK: - ConfigureUI
    
    private func configureSubView() {
        [topicTitleLabel, topicContentsCollectionView]
            .forEach{
                contentView.addSubview($0)
            }
    }
    
    private func configureLayout() {
        topicTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(4)
            make.horizontalEdges.equalTo(contentView).inset(10)
        }
        
        topicContentsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topicTitleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView)
            
        }
       
    }

}
