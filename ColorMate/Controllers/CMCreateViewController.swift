//
//  CMCreateViewController.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 16/06/23.
//

import UIKit

struct CMPallete{
    var name: String
    var color: UIColor
}

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

struct CMColorPalleteViewModel{
    let pallete: [CMPallete]
}

class CMCreateViewController: CMViewController {
    
    let tableView = UITableView()
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 1
        l.font = .systemFont(ofSize: 18)
        l.text = "Add colors to create a color pallete."
        l.textColor = .white
        return l
    }()
    
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
    
    private var viewModel: [CMColorPalleteViewModel] = [
//        CMColorPalleteViewModel(pallete: [CMPallete(name: "red", color: .red), CMPallete(name: "blue", color: .blue), CMPallete(name: "green", color: .green)])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setUpLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
        sizeHeaderToFit()
    }
    
    func setUpViews() {
        setUpTableView()
        
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    func setUpLayout() {
        
    }
    
    func applyTheme() {
        
    }
    
    private func setUpTableView(){
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CMColorPalleteTableViewCell.self, forCellReuseIdentifier: CMColorPalleteTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let header = UIView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(titleLabel)
        header.addSubview(stackView)
        header.addSubview(addButton)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: header.topAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: header.leadingAnchor, multiplier: 2),
            titleLabel.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: header.leadingAnchor, multiplier: 2),
            stackView.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor),
            
            addButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            addButton.leadingAnchor.constraint(equalToSystemSpacingAfter: header.leadingAnchor, multiplier: 2),
            addButton.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            
            header.bottomAnchor.constraint(equalToSystemSpacingBelow: addButton.bottomAnchor, multiplier: 1),
            
        ])
        tableView.tableHeaderView = header
        
        header.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tabBarController?.tabBar.frame.height ?? 60, right: 0)
    }
    
    private func sizeHeaderToFit(){
        let headerView = tableView.tableHeaderView!
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        
        tableView.tableHeaderView = headerView
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
        let colorView = CMPalleteColorView(viewModel: CMPallete(name: "Red", color: UIColor(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha)))
        colorView.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: 1)
        
        stackView.addArrangedSubview(colorView)
        stackView.layoutIfNeeded()
        view.layoutIfNeeded()
    }
}

extension CMCreateViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CMColorPalleteTableViewCell.identifier, for: indexPath) as! CMColorPalleteTableViewCell
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
