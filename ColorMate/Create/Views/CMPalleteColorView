//
//  CMPalleteColorView.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 20/07/23.
//

import UIKit

class CMPalleteColorView: UIView{
    let nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12, weight: .medium)
        l.textAlignment = .right
        return l
    }()
    
    var title: String = ""{
        didSet{
            nameLabel.text = title
        }
    }
    
    init(viewModel: CMPallete){
        super.init(frame: .zero)
        
        backgroundColor = viewModel.color
        title = viewModel.name
        
        addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
