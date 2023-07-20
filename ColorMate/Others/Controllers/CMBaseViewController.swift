//
//  CMBaseViewController.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 16/06/23.
//

import UIKit

typealias CMViewController = CMBaseViewController & CMViewControllerProtocol

protocol CMViewControllerProtocol{
    func setUpViews()
    func setUpLayout()
    func applyTheme()
}

class CMBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let vc = self as? CMViewController else{
            return
        }
        
        vc.applyTheme()
    }
}
