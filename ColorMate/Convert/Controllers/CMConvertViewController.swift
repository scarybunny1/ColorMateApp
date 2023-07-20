//
//  CMColorConvertViewController.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 16/06/23.
//

import UIKit

public struct CMRadioButtonViewModel{
    var title: String
    var tintColor: UIColor
}

public struct CMRadioButtonGroup{

    public var optionsViewModel: [CMRadioButtonViewModel]
    public var options: [UIButton]{
        var a: [UIButton] = []
        optionsViewModel.forEach { vm in
            let b = UIButton()
            b.setTitle(vm.title, for: .normal)
            b.tintColor = vm.tintColor
            a.append(b)
        }
        return a
    }
    
    public init(optionsViewModel: [CMRadioButtonViewModel]) {
        self.optionsViewModel = optionsViewModel
    }
    
    public func select(_ button: UIButton){
        button.isSelected = true
        options.forEach { b in
            if b != button{
                b.isSelected = false
            }
        }
    }
}

public class CMRadioButton: UIView{
    
    public var title: String = "RButton"{
        didSet{
            titleLabel.text = title
        }
    }
    public var color: UIColor = .tintColor{
        didSet{
            backgroundColor = color
        }
    }
    public var selectedColor: UIColor = .black
    public var isSelected: Bool = false{
        didSet{
            layer.borderColor = selectedColor.cgColor
        }
    }
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        return l
    }()
    let button = UIButton()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 2
        layer.borderColor = color.cgColor
        addSubview(titleLabel)
        addSubview(button)
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        button.frame = bounds
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    
}

class CMConvertViewController: CMViewController {
    
    let scrollView = UIScrollView()
    let topView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    let bottomView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    let inputPrimaryTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Primary"
        return tf
    }()
    let inputSecondaryTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Secondary"
        return tf
    }()
    let inputTertiaryTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Tertiary"
        return tf
    }()
    let inputQuaternaryTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Quaternary"
        return tf
    }()
    
    let inputRGBButton: UIButton = {
        let b = UIButton()
        b.setTitle("rgb", for: .normal)
        return b
    }()
    let outputRGBButton: UIButton = {
        let b = UIButton()
        b.setTitle("rgb", for: .normal)
        return b
    }()
    let inputHexButton: UIButton = {
        let b = UIButton()
        b.setTitle("hex", for: .normal)
        return b
    }()
    let outputHexButton: UIButton = {
        let b = UIButton()
        b.setTitle("hex", for: .normal)
        return b
    }()
    let inputHSLButton: UIButton = {
        let b = UIButton()
        b.setTitle("hsl", for: .normal)
        return b
    }()
    let outputHSLButton: UIButton = {
        let b = UIButton()
        b.setTitle("hsl", for: .normal)
        return b
    }()
    let inputCYMKButton: UIButton = {
        let b = UIButton()
        b.setTitle("cymk", for: .normal)
        return b
    }()
    let outputCYMKButton: UIButton = {
        let b = UIButton()
        b.setTitle("cymk", for: .normal)
        return b
    }()
    
    let convertButton: UIButton = {
        let b = UIButton()
        b.setTitle("Convert", for: .normal)
        return b
    }()
    
    let outputLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 18)
        l.textAlignment = .center
        l.text = "OutputLabel"
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setUpLayout()
    }
    
    func setUpViews() {
        
        view.addSubview(scrollView)
        
        let topButtonSelectionView = UIStackView()
        topButtonSelectionView.axis = .horizontal
        topButtonSelectionView.distribution = .equalSpacing
        topButtonSelectionView.alignment = .fill
        topButtonSelectionView.addArrangedSubview(inputRGBButton)
        topButtonSelectionView.addArrangedSubview(inputHexButton)
        topButtonSelectionView.addArrangedSubview(inputHSLButton)
        topButtonSelectionView.addArrangedSubview(inputCYMKButton)
        topView.addArrangedSubview(topButtonSelectionView)
        
        let topTextFieldView = UIStackView()
        topTextFieldView.axis = .vertical
        topTextFieldView.distribution = .fillEqually
        topTextFieldView.spacing = 10
        topTextFieldView.alignment = .fill
        topTextFieldView.addArrangedSubview(inputPrimaryTF)
        topTextFieldView.addArrangedSubview(inputSecondaryTF)
        topTextFieldView.addArrangedSubview(inputTertiaryTF)
        topTextFieldView.addArrangedSubview(inputQuaternaryTF)
        topView.addArrangedSubview(topTextFieldView)
        
        let bottomButtonSelectionView = UIStackView()
        bottomButtonSelectionView.axis = .horizontal
        bottomButtonSelectionView.distribution = .equalSpacing
        bottomButtonSelectionView.alignment = .fill
        bottomButtonSelectionView.addArrangedSubview(outputRGBButton)
        bottomButtonSelectionView.addArrangedSubview(outputHexButton)
        bottomButtonSelectionView.addArrangedSubview(outputHSLButton)
        bottomButtonSelectionView.addArrangedSubview(outputCYMKButton)
        topView.addArrangedSubview(bottomButtonSelectionView)
        
        topView.addArrangedSubview(convertButton)
        bottomView.addArrangedSubview(outputLabel)
        
        scrollView.addSubview(topView)
        scrollView.addSubview(bottomView)
    }
    
    func setUpLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            topView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            topView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            topView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10),
            bottomView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            bottomView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            bottomView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16)
        ])
    }
    
    func applyTheme() {
        
    }
    
}
