//
//  SearchPhotoView.swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit
import SnapKit

final class SearchPhotoView : PhotoListBaseView {
    // MARK: - UI
    let searchBar = UISearchBar()
    
    // MARK: - ConfigureUI
   
    override func configureSubView() {
        super.configureSubView()
        [searchBar]
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
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(photosCollectionView)
        }
    }

}

