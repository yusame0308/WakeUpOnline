//
//  MainTabBarController.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/08.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTab()
    }
    
    private func setupTab() {
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let houseImage = UIImage(systemName: "house.fill")?.withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        homeViewController.tabBarItem = UITabBarItem(title: "ホーム", image: houseImage, tag: 0)
        
        let mypageViewController = UINavigationController(rootViewController: MypageViewController())
        let personImage = UIImage(systemName: "person.fill")?.withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        mypageViewController.tabBarItem = UITabBarItem(title: "マイページ", image: personImage, tag: 1)
        
        viewControllers = [homeViewController, mypageViewController]
    }
    
}
