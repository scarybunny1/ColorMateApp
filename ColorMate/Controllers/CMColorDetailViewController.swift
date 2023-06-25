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

struct CMColorDetailViewModel{
    let name: String
    let rbga: String
    let hex: String
    let colorImageUrl: String
    let colorImageNamedUrl: String
}

class CMColorDetailViewController: CMViewController {
    
    let imageView = UIImageView()
    let nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 18, weight: .semibold)
        l.textAlignment = .center
        return l
    }()
    let rgbLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .regular)
        l.textAlignment = .center
        return l
    }()
    let hexLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .regular)
        l.textAlignment = .center
        return l
    }()
    
    var viewModel: CMColorDetailViewModel
    var delegate: CMColorDetailViewControllerDelegate?
    
    init(viewModel: CMColorDetailViewModel) {
        self.viewModel = viewModel
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
