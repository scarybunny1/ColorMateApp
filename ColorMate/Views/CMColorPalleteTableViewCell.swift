//
//  CMPalleteTableViewCell.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 25/06/23.
//

import UIKit

class CMColorPalleteTableViewCell: UITableViewCell {
    
    static let identifier = "CMColorPalleteTableViewCell"
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 0
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
    }
    
    func configure(with model: CMColorPalleteViewModel){
        model.pallete.forEach { palleteColor in
            let colorView = CMPalleteColorView(viewModel: palleteColor)
            colorView.backgroundColor = palleteColor.color
            stackView.addArrangedSubview(colorView)
        }
        stackView.layoutIfNeeded()
        layoutIfNeeded()
    }
}
