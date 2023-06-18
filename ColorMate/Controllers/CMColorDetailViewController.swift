//
//  CMColorDetailViewController.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 17/06/23.
//

import UIKit

class CMColorDetailViewController: CMViewController {
    
    var rgba: RGBA
    
    init(rgba: RGBA) {
        self.rgba = rgba
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
    }
    
    func setUpLayout() {
    }
    
    func applyTheme() {
            
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Color"
        view.backgroundColor = .systemBackground
        setUpViews()
        setUpLayout()
        
    }

}
