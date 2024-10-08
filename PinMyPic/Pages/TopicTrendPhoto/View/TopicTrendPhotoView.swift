//
//  TopicTrendPhotoView.swift
//  PinMyPic
//
//  Created by 하연주 on 7/27/24.
//

import UIKit
import SnapKit

final class TopicTrendPhotoView : BaseView {
    // MARK: - UI
    
    let profileCircleView = ProfileCircleView(width: Constants.Size.microProfileImageWidth, isCameraIconShown: false)
    
    private let mainLabel = {
        let label = UILabel()
        label.text = "OUR TOPIC"
        label.font = .boldSystemFont(ofSize: 35)
        return label
    }()
    
    let topicsTableView = {
        let tv = UITableView()
        return tv
    }()
    
    // MARK: - Initializer
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        configureSubView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ConfigureUI
    
    override func configureSubView() {
        [profileCircleView, mainLabel, topicsTableView]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        profileCircleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(profileCircleView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            
        }
        
        topicsTableView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

}
