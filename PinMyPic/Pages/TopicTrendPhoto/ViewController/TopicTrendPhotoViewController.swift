//
//  TopicTrendPhotoViewController.swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit

final class TopicTrendPhotoViewController : UIViewController {
    // MARK: - UI
    private let viewManager = TopicTrendPhotoView()
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        
    }

    // MARK: - SetupDelegate
    private func setupDelegate() {
        
//        viewManager.topicsTableView.rowHeight = UITableView.automaticDimension
        viewManager.topicsTableView.rowHeight = Constants.Size.topicsTableViewRowHeight
        viewManager.topicsTableView.dataSource = self
        viewManager.topicsTableView.delegate = self
        viewManager.topicsTableView.register(TopicsTableViewCell.self, forCellReuseIdentifier: TopicsTableViewCell.description())
        
    }
    
    // MARK: - AddTarget
    private func setupAddTarget() {
    }
    // MARK: - EventSelector
    // MARK: - SetupUI
    // MARK: - APIFetch
    // MARK: - PageTransition
}


extension TopicTrendPhotoViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopicsTableViewCell.description(), for: indexPath) as! TopicsTableViewCell
        
        cell.topicContentsCollectionView.dataSource = self
        cell.topicContentsCollectionView.dataSource = self
        cell.topicContentsCollectionView.register(TopicContentsCollectionViewCell.self, forCellWithReuseIdentifier: TopicContentsCollectionViewCell.description())
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "하하하하"
//    }
}

extension TopicTrendPhotoViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicContentsCollectionViewCell.description(), for: indexPath) as! TopicContentsCollectionViewCell
        
        return cell
    }
}
