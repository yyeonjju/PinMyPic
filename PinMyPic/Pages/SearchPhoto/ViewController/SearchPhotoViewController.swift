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
        setupSortMenuItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //좋아요 탭에서 좋아요 해제하고 다시 돌아왔을 때 데이터 동기화 시켜주기 위해
        self.viewManager.photosCollectionView.reloadData()
    }
    
    
    // MARK: - setupBind
    private func setupBind() {
        vm.outputSearchResult.bind { [weak self] value in
            guard let self else{return}
            self.viewManager.photosCollectionView.reloadData()
            self.setupEmptyView()
            
            guard let value else {return}
            if vm.page == 1 && !value.results.isEmpty {
                self.viewManager.photosCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
        }
        
        vm.outputErrorMessage.bind(onlyCallWhenValueDidSet: true) { [weak self] message in
            guard let self else{return}
            self.view.makeToast(message,position: .top)
            
        }
        
        vm.outputReloadCollectionViewTrigger.bind(onlyCallWhenValueDidSet: true) { [weak self] _ in guard let self else{return}
            self.viewManager.photosCollectionView.reloadData()
        }
        
        
        
    }
    


    // MARK: - SetupDelegate
    private func setupDelegate(){
        viewManager.searchBar.delegate = self
        
        viewManager.photosCollectionView.dataSource = self
        viewManager.photosCollectionView.delegate = self
        viewManager.photosCollectionView.prefetchDataSource = self
        viewManager.photosCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.description())
    }
    
    // MARK: - Method
    private func setupEmptyView() {
        //검색하기 전 일 때
        guard let searchResult = vm.outputSearchResult.value else{
            viewManager.emptyView.isHidden = false
            viewManager.emptyView.labal.text = "사진을 검색해보세요"
            return
        }
        //검색 결과가 없을 때
        if searchResult.results.isEmpty {
            viewManager.emptyView.isHidden = false
            viewManager.emptyView.labal.text = "검색결과가 없습니다."
        } else{
            //검색 결과가 있을 때
            viewManager.emptyView.isHidden = true
        }
    }

    // MARK: - setupMenuItem
    private func setupSortMenuItem() {
        let latestOrder = UIAction(title: SortOrder.latest.koText){ [weak self] _ in
            guard let self else{return}
            vm.inputSortMenuTapped.value = .latest
            viewManager.sortButton.title = SortOrder.latest.koText
        }
        
        let relevantOder = UIAction(title: SortOrder.relevant.koText){ [weak self] _ in
            guard let self else{return}
            vm.inputSortMenuTapped.value = .relevant
            viewManager.sortButton.title = SortOrder.relevant.koText
        }
        
        let items = [latestOrder, relevantOder]
        let menu = UIMenu(title: "정렬", children: items)
        viewManager.sortButton.menu = menu
        viewManager.sortButton.showsMenuAsPrimaryAction = true
    }
}


//collectionView
extension SearchPhotoViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let searchResult = vm.outputSearchResult.value?.results else{return 0}
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.description(), for: indexPath) as! PhotoCollectionViewCell
        guard let searchResult = vm.outputSearchResult.value?.results else{return cell}
        let data = searchResult[indexPath.item]
        let alreadyLikedItem = vm.likedItemListData?.first(where: {$0.imageId == data.id})
        cell.configureData(likes : data.likes, id : data.id, url : data.urls.small, isLiked : !(alreadyLikedItem==nil) )
        cell.toggleLikeStatus = {[weak self] image in
            guard let self else{return}
            let likedTappedPhoto = LikedTappedPhoto(imageId: data.id, image: image)
            self.vm.inputLikeButtonTapped.value = likedTappedPhoto
        }
        return cell
    }
}



//searchBar
extension SearchPhotoViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        if vm.inputSearchKeyword.value == text {
            vm.outputErrorMessage.value = Texts.ToastMessage.searchSameKeyword
        }else{
            vm.inputSearchKeyword.value = text
        }

    }
}

//collectionView - prefetch
extension SearchPhotoViewController : UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let result = vm.outputSearchResult.value else {return}
        
        for item in indexPaths {
            if result.results.count - 2 == item.row && vm.page < result.totalPages{
                vm.inputPrefetchForPagenation.value = ()
            }
        }
    }
    
}


