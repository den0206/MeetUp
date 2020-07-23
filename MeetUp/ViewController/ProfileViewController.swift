//
//  ProfileViewController.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/23.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

private let contentIdentifer = "ContentCell"
private let aboutIdentifer = "AboutCell"
private let profileIdentifer = "ProfileCell"
class ProfileViewController : UITableViewController {
    
    var editingMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// no darkmode
        overrideUserInterfaceStyle = .light
        
        configureTV()
    }
    
    //MARK: - UI
    private func configureTV() {
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        tableView.register(ContentCell.self, forCellReuseIdentifier: contentIdentifer)
        tableView.register(AboutCell.self, forCellReuseIdentifier: aboutIdentifer)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: profileIdentifer)
    }
    
    private func showSaveButton() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
        navigationItem.rightBarButtonItem = editingMode ? saveButton : nil
    }
    
    //MARK: - Actions
    @objc func handleSave() {
        print("Save")
    }

    
    
}

//MARK: - TableView Delegate

extension ProfileViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1 :
            return 1
        case 2 :
            return 3
        case 3 :
            return 5
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell :UITableViewCell!
        
        switch indexPath.section {
        case 0:
            let contentCell = tableView.dequeueReusableCell(withIdentifier: contentIdentifer, for: indexPath) as! ContentCell
            contentCell.delegate = self
            
            return contentCell
        case 1 :
            
            let aboutCell = tableView.dequeueReusableCell(withIdentifier: aboutIdentifer, for: indexPath) as! AboutCell
            aboutCell.textView.isUserInteractionEnabled = editingMode
            
            return aboutCell
            
        case 2,3 :
            cell = tableView.dequeueReusableCell(withIdentifier: profileIdentifer, for: indexPath)
            
            let tf = UITextField()
            tf.backgroundColor = .white
            tf.clipsToBounds = true
            tf.textColor = .black
            tf.layer.cornerRadius = 10
            tf.placeholder = "place"
            tf.isUserInteractionEnabled = editingMode
            
            cell.addSubview(tf)
            cell.contentView.backgroundColor = .lightGray
            tf.anchor(top : cell.topAnchor,left : cell.leftAnchor, bottom: cell.bottomAnchor,right: cell.rightAnchor,paddingTop: 8,paddingLeft: 8,paddingBottom: 8,paddingRight: 8)
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: profileIdentifer, for: indexPath)

        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
             return 450
        case 1 :
            return 200
            
        default:
            return 50
        }
    }
    
    //MARK: - header
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(section)
    }
}

extension ProfileViewController : ContentCellDelegate {
    
    func handlesettingButton() {
        
        showSettingeOptions()
    }
    
    func handleCameraButton() {
        showPicureOptions()
    }
    
    
    func handleEditButton() {
        
        editingMode.toggle()
        tableView.reloadData()
        
        showSaveButton()
        
        if editingMode {
            /// show keyboard
        } else {
            view.endEditing(true)
        }
    }
    
    //MARK: - Alert Controller
    
    private func showSettingeOptions() {
        let alertController = UIAlertController(title: "Edit Account", message: "can Edit", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Change Email", style: .default, handler: { (alert) in
            print("email")
        }))
        
        alertController.addAction(UIAlertAction(title: "Change Name", style: .default, handler: { (alert) in
            print("name")
        }))
        alertController.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (alert) in
            print("logout")
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    private func showPicureOptions() {
        let alertController = UIAlertController(title: "Upload Image", message: "You can Change picture", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Change Avatar", style: .default, handler: { (alert) in
            print("Avater")
        }))
        
        alertController.addAction(UIAlertAction(title: "Upload Pictures", style: .default, handler: { (alert) in
            print("Picture")
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
}
