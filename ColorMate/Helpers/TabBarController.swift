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
        let colorsVC = CMColorsViewController()
        let colorODVC = CMColorOfTheDayViewController()
        
        scanVC.title = "Scan"
        colorsVC.title = "Create"
        colorODVC.title = "Color of the Day"
        
        
        scanVC.navigationItem.largeTitleDisplayMode = .automatic
        colorsVC.navigationItem.largeTitleDisplayMode = .automatic
        colorODVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: scanVC)
        let nav2 = UINavigationController(rootViewController: colorsVC)
        let nav3 = UINavigationController(rootViewController: colorODVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Scan", image: UIImage(systemName: "camera"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "plus"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "COD", image: UIImage(systemName: "lasso.and.sparkles"), tag: 3)
        
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