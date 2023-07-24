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
    
    let view = CMCardView(backgroundColor: .black)
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(view)
        view.addSubview(blurView)
        view.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            view.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 1),
            
            
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 3),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 3)
        ])
        
        let stackViewHeight = stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor)
        stackViewHeight.priority = .defaultLow
        stackViewHeight.isActive = true
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
