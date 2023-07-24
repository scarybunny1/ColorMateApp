//
//  CMCreatePalleteViewController.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 20/07/23.
//

import UIKit

protocol CMCreatePalleteViewControllerDelegate: AnyObject{
    func addPalleteToList(_ : CMColorPalleteViewModel)
}

class CMCreatePalleteViewController: CMBaseViewController{
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 1
        l.font = .systemFont(ofSize: 18)
        l.text = "Add colors to create a color pallete."
        l.textColor = .white
        return l
    }()
    
    let cardView = CMCardView(backgroundColor: .darkGray)
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 0
        return sv
    }()
    
    let addButton: UIButton = {
        let b = UIButton()
        b.setTitle("Add Color", for: .normal)
        b.backgroundColor = .tintColor
        return b
    }()
    
    weak var delegate: CMCreatePalleteViewControllerDelegate?
    private var draftPallete: CMColorPalleteViewModel = CMColorPalleteViewModel(pallete: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(cardView)
        cardView.addSubview(blurView)
        cardView.addSubview(stackView)
        cardView.clipsToBounds = true
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        
        setUpAddBarButton()
        
        let saveBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.translatesAutoresizingMaskIntoConstraints = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.heightAnchor.constraint(equalTo: cardView.widthAnchor),
            
            blurView.topAnchor.constraint(equalTo: cardView.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 2),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -2),
            
            addButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 10),
            addButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    private func setUpAddBarButton(){
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
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
        let palleteColor = CMPallete(name: "Red", color: UIColor(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha))
        let colorView = CMPalleteColorView(viewModel: palleteColor)
        colorView.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: 1)
        draftPallete.pallete.append(palleteColor)
        
        stackView.addArrangedSubview(colorView)
        stackView.layoutIfNeeded()
        view.layoutIfNeeded()
    }
    
    @objc private func saveButtonTapped(){
        self.delegate?.addPalleteToList(draftPallete)
        dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped(){
        dismiss(animated: true)
    }
}
