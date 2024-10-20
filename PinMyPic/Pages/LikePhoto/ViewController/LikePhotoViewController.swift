//
//  LikePhotoViewController.swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit
import RealmSwift

final class LikePhotoViewController : UIViewController {
    // MARK: - UI
    private let viewManager = PhotoListBaseView()
    // MARK: - Properties
    private let vm = LikePhotoViewModel(likedPhotoRepository: LikedPhotoInfoRepository())
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = viewManager
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Texts.PageTitle.whatIPin
        
        setupBind()
        setupDelegate()
        setupSortMenuItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.inputLoadLikedItem.value = ()
    }
    
    // MARK: - SetupBind
    private func setupBind() {
        vm.inputLoadLikedItem.value = ()
        
        //inputLoadLikedItem 시점이나 좋아요 해제(좋아요 realm데이터에서 삭제) 후 collectionView reload될 수 있도록
        vm.outputReloadCollectionViewTrigger.bind(onlyCallWhenValueDidSet: true) {[weak self] list in
            guard let self else{return}
            self.viewManager.photosCollectionView.reloadData()
            setupEmptyView()
        }
    }

    

    // MARK: - SetupDelegate
    private func setupDelegate(){
        viewManager.photosCollectionView.dataSource = self
        viewManager.photosCollectionView.delegate = self
        viewManager.photosCollectionView.register(LikePhotoCollectionViewCell.self, forCellWithReuseIdentifier: LikePhotoCollectionViewCell.description())
    }
    
    // MARK: - Method
    private func setupEmptyView() {
        //좋아요한 아이템이 없을 때
        guard let likedList = vm.likedItemListData else{return}
        if likedList.isEmpty {
            viewManager.emptyView.isHidden = false
            viewManager.emptyView.labal.text = "좋아요한 사진이 없습니다."
        } else{
            //좋아요한 아이템이 있을 때
            viewManager.emptyView.isHidden = true
        }
    }
    
    // MARK: - setupMenuItem
    private func setupSortMenuItem() {
        viewManager.sortButton.title = vm.inputSelectedSortMenu.value.koText
        
        let latestOrder = UIAction(title: SortOrder.latest.koText){ [weak self] _ in
            guard let self else{return}
            vm.inputSelectedSortMenu.value = .latest
            viewManager.sortButton.title = SortOrder.latest.koText
        }
        
        let oldestOder = UIAction(title: SortOrder.oldest.koText){ [weak self] _ in
            guard let self else{return}
            vm.inputSelectedSortMenu.value = .oldest
            viewManager.sortButton.title = SortOrder.oldest.koText
        }
        
        let items = [latestOrder, oldestOder]
        let menu = UIMenu(title: "정렬", children: items)
        viewManager.sortButton.menu = menu
        viewManager.sortButton.showsMenuAsPrimaryAction = true
    }
}

//collectionView
extension LikePhotoViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.likedItemListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikePhotoCollectionViewCell.description(), for: indexPath) as! LikePhotoCollectionViewCell
        let data = vm.likedItemListData[indexPath.item]
        
        cell.configureData(likes:nil, id:data.imageId, url:nil, isLiked : true)
        cell.toggleLikeStatus = {[weak self] _ in
            guard let self else{return}
            self.vm.inputSwitchToUnlike.value = data.imageId
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = vm.likedItemListData[indexPath.item]
        
        let vc = PhotoDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.photoData = PhotoResult(id: data.imageId, createdAt: data.createdAt, updatedAt: "", width: data.width, height: data.height, color: "", urls: PhotoURL(regular: "", small: data.imageURL), likes: 0, user: PhotoUser(name: data.uploaderName, profileImage: PhotoUserProfileImage(medium: data.uploaderProfileImage)))
        pageTransition(to: vc, type: .push)
    }
}

