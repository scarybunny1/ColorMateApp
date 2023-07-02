//
//  TabBarController.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 16/06/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTabs()
    }
    
    private func setUpTabs(){
        let scanVC = CMScanViewController()
        let createVC = CMCreateViewController()
        let convertVC = CMColorConvertViewController()
        
        scanVC.title = "Scan"
        createVC.title = "Create"
        convertVC.title = "Convert"
        
        
        scanVC.navigationItem.largeTitleDisplayMode = .automatic
        createVC.navigationItem.largeTitleDisplayMode = .never
        convertVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: scanVC)
        let nav2 = UINavigationController(rootViewController: createVC)
        let nav3 = UINavigationController(rootViewController: convertVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Scan", image: UIImage(systemName: "camera"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "plus"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Convert", image: UIImage(systemName: "arrow.left.arrow.right"), tag: 3)
        
        [nav1, nav2, nav3].forEach { nav in
            nav.navigationBar.prefersLargeTitles = true
            
        }
        
        setViewControllers([
        nav1,
        nav2,
        nav3
        ], animated: true)
        
        
        tabBar.backgroundColor = .systemBackground
        tabBar.isTranslucent = true
    }

}
