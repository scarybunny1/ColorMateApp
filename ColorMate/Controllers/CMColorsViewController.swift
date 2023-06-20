//
//  CMColorsViewController.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 16/06/23.
//

import UIKit

class CMColorsViewController: CMViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 0
        return sv
    }()
    let addButton: UIButton = {
        let b = UIButton()
        b.setTitle("Add Color", for: .normal)
        b.backgroundColor = .lightGray
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setUpLayout()
    }
    
    func setUpViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        contentView.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    func setUpLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            addButton.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2),
            addButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: addButton.bottomAnchor, multiplier: 2)
        ])
    }
    
    func applyTheme() {
        
    }
    
    @objc private func didTapAddButton(){
        let alertVC = UIAlertController(title: "Add a color", message: "Enter RGB values(0 - 255) and Alpha (1-100) to add a new color to the pallete.", preferredStyle: .alert)
        alertVC.addTextField{tf in
            tf.placeholder = "Red"
        }
        alertVC.addTextField{tf in
            tf.placeholder = "Green"
        }
        alertVC.addTextField{tf in
            tf.placeholder = "Blue"
        }
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertVC.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self] alert in
            guard let self = self, let red = alertVC.textFields?.first?.text, let green = alertVC.textFields?[1].text, let blue = alertVC.textFields?[2].text else{return}
            let cgfloat_red = CGFloat(truncating: NumberFormatter().number(from: red)!)
            let cgfloat_green = CGFloat(truncating: NumberFormatter().number(from: green)!)
            let cgfloat_blue = CGFloat(truncating: NumberFormatter().number(from: blue)!)
            self.add(color: RGBA(red: cgfloat_red, green: cgfloat_green, blue: cgfloat_blue))
        }))
        present(alertVC, animated: true)
    }
    
    private func add(color: RGBA){
        let colorView = UIView()
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        colorView.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: 1)
        
        stackView.addArrangedSubview(colorView)
        stackView.layoutIfNeeded()
        view.layoutIfNeeded()
    }
}
