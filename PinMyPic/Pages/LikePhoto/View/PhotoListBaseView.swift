//
//  PhotoListBaseView.swift
//  PinMyPic
//
//  Created by 하연주 on 7/27/24.
//

import UIKit

class PhotoListBaseView : BaseView {
    // MARK: - UI
    
//    let filterButtonsView = UIView()
    
    let sortButton = CornerRadiusButton(title: SortOrder.relevant.koText, image: Assets.Images.sort, allowSelection: true)
    
    
    let photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionVewLayout(numberofItemInrow: 2, cellIneterSpacing: 2, sectionSpacing: 2, height: 240))


    let emptyView = ResultEmptyView()
    
    
    // MARK: - ConfigureUI
    
    override func configureSubView() {
        [sortButton, photosCollectionView, emptyView]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        
        sortButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-4)
        }
        
        photosCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sortButton.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(photosCollectionView)
        }
    }

    
    
    
}
