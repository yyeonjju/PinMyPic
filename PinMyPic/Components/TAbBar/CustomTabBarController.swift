//
//  CustomTabBarController.swift
//  PinMyPic
//
//  Created by 하연주 on 7/25/24.
//

import UIKit

final class CustomTabBarController<T: CaseIterable&TabBarProtocol> : UITabBarController {
    
    var type : T.Type?

    
    init(type : T.Type) {
        super.init(nibName: nil, bundle: nil)
        self.type = type.self
        
        configureTabBar()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureTabBar() {

        guard let type else {return }
        let tabList = type.allCases
        
        let rootVCList = tabList.map{
            UINavigationController(rootViewController: $0.rootVC.init())
            
        }
        setViewControllers(rootVCList, animated: true)
        
        guard let items = self.tabBar.items else { return }
        tabList.enumerated().forEach{
            items[$0.offset].title = $0.element.title
            items[$0.offset].image = $0.element.iconImage
        }
        
        modalPresentationStyle = .fullScreen
        tabBar.tintColor = Assets.Colors.black
        tabBar.unselectedItemTintColor = Assets.Colors.gray2
    }
   
}

