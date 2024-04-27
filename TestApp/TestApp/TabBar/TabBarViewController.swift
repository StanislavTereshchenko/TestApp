//
//  TabBarViewController.swift
//  TestApp
//
//  Created by Stanislav Tereshchenko on 26.04.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        let timerVC = BouncingTimerViewController()
        let mapsVC = MapsViewController()
        let infoVC = InfoViewController()
        timerVC.tabBarItem = UITabBarItem(title: NSLocalizedString("timer", comment: ""), image: UIImage(systemName: "timer.square"), selectedImage: nil)
        mapsVC.tabBarItem = UITabBarItem(title: NSLocalizedString("maps", comment: ""), image: UIImage(systemName: "map"), selectedImage: nil)
        infoVC.tabBarItem = UITabBarItem(title: NSLocalizedString("info", comment: ""), image: UIImage(systemName: "info.circle"), selectedImage: nil)
        self.viewControllers = [timerVC, mapsVC, infoVC]
    }
}

