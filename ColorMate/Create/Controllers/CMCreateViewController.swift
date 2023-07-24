//
//  CMCreateViewController.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 16/06/23.
//

import UIKit

class CMCreateViewController: CMViewController {
    
    let tableView = UITableView()
    let emptyViewLabel: UILabel = {
        let l = UILabel()
        l.text = "You do not have any palletes. Create one."
        l.numberOfLines = 0
        l.textAlignment = .center
        l.font = .systemFont(ofSize: 16, weight: .semibold)
        l.textColor = .secondaryLabel
        l.isHidden = true
        return l
    }()
    
    private(set) var viewModel: [CMColorPalleteViewModel] = [
                CMColorPalleteViewModel(pallete: [CMPallete(name: "red", color: .red), CMPallete(name: "blue", color: .blue), CMPallete(name: "green", color: .green), CMPallete(name: "red", color: .red), CMPallete(name: "blue", color: .blue), CMPallete(name: "green", color: .green)])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        emptyViewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            
            emptyViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyViewLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setUpViews() {
        setUpTableView()
        view.addSubview(emptyViewLabel)
        
        if viewModel.isEmpty{
            emptyViewLabel.isHidden = false
            tableView.isHidden = true
        } else{
            tableView.isHidden = false
            emptyViewLabel.isHidden = true
        }
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddPalleteView))
        navigationItem.rightBarButtonItem = addBarButtonItem
        
    }
    
    func setUpLayout() {}
    func applyTheme() {}
    
    private func setUpTableView(){
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CMColorPalleteTableViewCell.self, forCellReuseIdentifier: CMColorPalleteTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func showAddPalleteView(){
        let vc = CMCreatePalleteViewController()
        vc.title = "Create"
        vc.delegate = self
        let navigationController = UINavigationController(rootViewController: vc)
        
        navigationController.modalPresentationStyle = .popover
        present(navigationController, animated: true, completion: nil)
        getUserProfile(userId: "", completion: {_ in})
    }
    
    /// Retrieves the user profile from the server.
    /// - Parameters:
    ///   - userId: The unique identifier of the user.
    ///   - completion: A closure called with the result of the request. If successful, it returns the user's profile information as a `UserProfile` object. If an error occurs, it returns a `ServiceError`.
    func getUserProfile(userId: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Implementation details...
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension CMCreateViewController: CMCreatePalleteViewControllerDelegate{
    func addPalleteToList(_ newColorPallete: CMColorPalleteViewModel) {
        self.viewModel.append(newColorPallete)
        tableView.reloadData()
    }
}
