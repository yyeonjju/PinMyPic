//
//  SearchPhotoView.swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit
import SnapKit

final class SearchPhotoView : BaseView {
    // MARK: - UI
    let searchBar = UISearchBar()
    
//    let filterButtonsView = UIView()
    
    let sortButton = CornerRadiusButton(title: "최신순", image: Assets.Images.sort, allowSelection: true)
    
    
    let photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionVewLayout(numberofItemInrow: 2, cellIneterSpacing: 2, sectionSpacing: 2, height: 240))


    
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
        [searchBar, sortButton, photosCollectionView]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        sortButton.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-4)
        }
        
        photosCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sortButton.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            
        }
    }

    
    
}

