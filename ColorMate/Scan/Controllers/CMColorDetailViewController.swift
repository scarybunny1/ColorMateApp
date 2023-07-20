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
    
    var viewModel: CMColorDetailViewModel?
    var rgba: RGBA
    var delegate: CMColorDetailViewControllerDelegate?
    
    init(rgba: RGBA) {
        self.rgba = rgba
        super.init(nibName: nil, bundle: nil)
        
        getColorDetails()
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

    private func getColorDetails(){
        APIManager.shared.checkColor(color: rgba) { [weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let colorData):
                DispatchQueue.main.async {
                    let rgba = "rgb(\(colorData.rgb.r), \(colorData.rgb.g), \(colorData.rgb.b))"
                    let detailVM = CMColorDetailViewModel(name: colorData.name.value, rbga: rgba, hex: colorData.hex.value, colorImageUrl: colorData.image.bare, colorImageNamedUrl: colorData.image.named)
                    self.configure(with: detailVM)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configure(with vm: CMColorDetailViewModel){
        print(vm)
    }
}
