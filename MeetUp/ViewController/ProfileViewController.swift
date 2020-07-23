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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTV()
    }
    
    //MARK: - UI
    private func configureTV() {
        
        tableView.separatorStyle = .none
        
        tableView.register(ContentCell.self, forCellReuseIdentifier: contentIdentifer)
        tableView.register(AboutCell.self, forCellReuseIdentifier: aboutIdentifer)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: profileIdentifer)
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
        default:
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell :UITableViewCell!
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: contentIdentifer, for: indexPath) as! ContentCell
        case 1 :
            cell = tableView.dequeueReusableCell(withIdentifier: aboutIdentifer, for: indexPath) as! AboutCell
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
            return 60
        }
    }
    
    //MARK: - header
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 25
//    }
//
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return String(section)
//    }
}
