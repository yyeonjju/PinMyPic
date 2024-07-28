//
//  TopicTrendPhotoViewController.swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit
import Toast

final class TopicTrendPhotoViewController : UIViewController {
    // MARK: - UI
    private let viewManager = TopicTrendPhotoView()
    
    // MARK: - Properties
    private let vm = TopicTrendPhotoViewModel()
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setupBind()
        
    }
    
    private func setupBind() {
        vm.inputViewDidLoadTrigger.value = ()
        
        vm.outputErrorMessage.bind(onlyCallWhenValueDidSet: true) {[weak self] message in
            guard let self else{return }
            self.view.makeToast(message,position: .top)
        }
        
        vm.outputTopicContents.bind(onlyCallWhenValueDidSet: true) {[weak self] (contents:[TopicContent]) in
            guard let self else{return }

            //원하는 토픽 갯수만큼 데이터 로드됐을 때 tableView와 collectionView reload될 수 있도록
            if contents.count == vm.topicQueryList.count {
                viewManager.topicsTableView.reloadData()
            }
        }
    }

    // MARK: - SetupDelegate
    private func setupDelegate() {
        
//        viewManager.topicsTableView.rowHeight = UITableView.automaticDimension
        viewManager.topicsTableView.rowHeight = Constants.Size.topicsTableViewRowHeight
        viewManager.topicsTableView.dataSource = self
        viewManager.topicsTableView.delegate = self
        viewManager.topicsTableView.register(TopicsTableViewCell.self, forCellReuseIdentifier: TopicsTableViewCell.description())
        
    }
}


extension TopicTrendPhotoViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.outputTopicContents.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopicsTableViewCell.description(), for: indexPath) as! TopicsTableViewCell
        
        let topic = vm.outputTopicContents.value[indexPath.row].topic
        let topicTitle = TopicQuery(rawValue: topic)?.koText
        cell.topicTitleLabel.text = topicTitle
        
        cell.topicContentsCollectionView.dataSource = self
        cell.topicContentsCollectionView.delegate = self
        cell.topicContentsCollectionView.register(TopicContentsCollectionViewCell.self, forCellWithReuseIdentifier: TopicContentsCollectionViewCell.description())
        
        cell.topicContentsCollectionView.tag = indexPath.row
        cell.topicContentsCollectionView.reloadData()
        return cell
    }
}

extension TopicTrendPhotoViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dataList = vm.outputTopicContents.value[collectionView.tag].content
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicContentsCollectionViewCell.description(), for: indexPath) as! TopicContentsCollectionViewCell
        let data = vm.outputTopicContents.value[collectionView.tag].content[indexPath.row]
        cell.configureData(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = vm.outputTopicContents.value[collectionView.tag].content[indexPath.row]
        
        let vc = PhotoDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.photoData = data
        pageTransition(to: vc, type: .push)
    }
}
