//
//  ProfileViewController.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/25.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

private let headerCellIdentifer = "profileHeaderCell"
private let aboutIdentifer = "AboutCell"

private let cellIdentifer = "Cell"
class ProfileViewController : UITableViewController {
    
    private let user : User
    var aboutCell : AboutCell!
    
    init(user : User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        configureTV()
    }
    
    //MARK: - UI
    
    private func configureTV() {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: headerCellIdentifer)
        tableView.register(AboutCell.self, forCellReuseIdentifier: aboutIdentifer)
    }
    
    
}

extension ProfileViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return 4
        default:
            return 1
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        
        switch indexPath.section {
            
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifer, for: indexPath) as! ProfileHeaderCell
        case 1 :
            aboutCell = tableView.dequeueReusableCell(withIdentifier: aboutIdentifer, for: indexPath) as? AboutCell
            
            return aboutCell
            
        case 2 :
            aboutCell = tableView.dequeueReusableCell(withIdentifier: aboutIdentifer, for: indexPath) as? AboutCell
            
            aboutCell.titleLabel.text = "Education"
            return aboutCell
            
        case 3 :
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
            
            let tf = UITextField()
            tf.backgroundColor = .white
            tf.clipsToBounds = true
            tf.textColor = .black
            tf.layer.cornerRadius = 10
            tf.placeholder = "place"
            tf.isUserInteractionEnabled = false
            
            cell.addSubview(tf)
            cell.contentView.backgroundColor = .lightGray
            tf.anchor(top : cell.topAnchor,left : cell.leftAnchor, bottom: cell.bottomAnchor,right: cell.rightAnchor,paddingTop: 8,paddingLeft: 8,paddingBottom: 8,paddingRight: 8)
            
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 602
        case 1,2 :
            return 200
        default:
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(section)
    }
    
}
