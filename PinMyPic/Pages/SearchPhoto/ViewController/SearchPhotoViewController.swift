//
//  SearchPhotoViewController.swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit
import Toast

final class SearchPhotoViewController : UIViewController {
    // MARK: - UI
    private let viewManager = SearchPhotoView()
    
    // MARK: - Properties
    private let vm = SearchPhotoViewModel()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
//        view.backgroundColor = .blue
        
        print("SearchPhotoViewController")
        hideKeyboardWhenTappedAround()
        setupBind()
        setupDelegate()
    }
    
    
    // MARK: - setupBind
    private func setupBind() {
        vm.outputSearchResult.bind(onlyCallWhenValueDidSet: true) { [weak self] value in
            guard let self else{return}
            self.viewManager.photosCollectionView.reloadData()
        }
        
        vm.outputErrorMessage.bind(onlyCallWhenValueDidSet: true) { [weak self] message in
            guard let self else{return}
            self.view.makeToast(message,position: .top)
            
        }
        
        
        
    }
    


    // MARK: - SetupDelegate
    private func setupDelegate(){
        viewManager.searchBar.delegate = self
        
        viewManager.photosCollectionView.dataSource = self
        viewManager.photosCollectionView.delegate = self
        viewManager.photosCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.description())
    }
    
    // MARK: - AddTarget
    private func setupAddTarget() {
    }
    // MARK: - EventSelector
    // MARK: - SetupUI
    // MARK: - APIFetch
    // MARK: - PageTransition
}

extension SearchPhotoViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let searchResult = vm.outputSearchResult.value?.results else{return 0}
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.description(), for: indexPath) as! PhotoCollectionViewCell
        guard let searchResult = vm.outputSearchResult.value?.results else{return cell}
        let data = searchResult[indexPath.item]
        cell.configureData(data: data)
        return cell
    }
}


extension SearchPhotoViewController : UISearchBarDelegate {

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        vm.inputSearchButtonClicked.value = text
    }
}


