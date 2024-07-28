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
    private let vm = LikePhotoViewModel()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = viewManager
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "What I Pin"
        
        setupBind()
        setupDelegate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.inputLoadLikedItem.value = ()
    }
    
    // MARK: - SetupBind
    private func setupBind() {
        vm.inputLoadLikedItem.value = ()
        
        vm.outputLikedItemList.bind {[weak self] list in
            guard let self else{return}
            self.viewManager.photosCollectionView.reloadData()
            setupEmptyView()
        }
        
        //좋아요 해제(좋아요 realm데이터에서 삭제) 후 collectionView reload될 수 있도록
        vm.outputReloadCollectionViewTrigger.bind {[weak self] list in
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
        guard let likedList = vm.outputLikedItemList.value else{return}
        if likedList.isEmpty {
            viewManager.emptyView.isHidden = false
            viewManager.emptyView.labal.text = "좋아요한 사진이 없습니다."
        } else{
            //좋아요한 아이템이 있을 때
            viewManager.emptyView.isHidden = true
        }
    }
}

//collectionView
extension LikePhotoViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let list = vm.outputLikedItemList.value else{return 0}
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikePhotoCollectionViewCell.description(), for: indexPath) as! LikePhotoCollectionViewCell
        guard let list = vm.outputLikedItemList.value else{return cell}
        
        let data = list[indexPath.item]
        cell.configureData(likes:nil, id:data.imageId, url:nil, isLiked : true)
        cell.toggleLikeStatus = {[weak self] _ in
            guard let self else{return}
            self.vm.inputSwitchToUnlike.value = data.imageId
        }
        return cell
    }
}

