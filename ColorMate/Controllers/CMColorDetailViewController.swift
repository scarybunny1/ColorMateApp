//
//  CMColorDetailViewController.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 17/06/23.
//

import UIKit

protocol CMColorDetailViewControllerDelegate{
    func colorDetailVC(_ vc: CMColorDetailViewController, didGetDismissed: Bool)
}

class CMColorDetailViewController: CMViewController {
    
    var rgba: RGBA
    var delegate: CMColorDetailViewControllerDelegate?
    
    init(rgba: RGBA) {
        self.rgba = rgba
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        delegate?.colorDetailVC(self, didGetDismissed: true)
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
