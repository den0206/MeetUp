//
//  SettingsViewController.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/23.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import Gallery
import ProgressHUD


private let contentIdentifer = "ContentCell"
private let aboutIdentifer = "AboutCell"
private let settingIdentifer = "SeettingCell"
class SettingsViewController : UITableViewController {
    
    //MARK: - propertt
    
    let user : User
    var contentCell : ContentCell!
    var aboutCell : AboutCell!
    
    var uploadingAvatar = true
    var editingMode = false
    
    var avatarImage : UIImage?
    var gallry : GalleryController!
    
    var alertTextField : UITextField!
    
    init(user : User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// no darkmode
        overrideUserInterfaceStyle = .light
        
        configureTV()
        print(user.userName)

    }
    
  
    
    //MARK: - UI
    private func configureTV() {
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        tableView.register(ContentCell.self, forCellReuseIdentifier: contentIdentifer)
        tableView.register(AboutCell.self, forCellReuseIdentifier: aboutIdentifer)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: settingIdentifer)
    }
    
    private func showSaveButton() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
        navigationItem.rightBarButtonItem = editingMode ? saveButton : nil
    }
    
    //MARK: - API
    
 

    
    //MARK: - Actions
    @objc func handleSave() {
        guard user.uid == User.currentId() else {return}
        
        // TODO: - chage user parametaer
        
        if avatarImage !=  nil {
            /// upload new avatar
            uploadAvatar(avatarImage!) { (avatarLink) in
                
                self.user.avatarLink = avatarLink ?? ""
                self.user.avatar = self.avatarImage
                
                self.saveUserData(user: self.user)
                self.tableView.reloadData()
            }
            
        } else {
            /// no upload avatar
            saveUserData(user: user)
        }
        
        editingMode = false
        showSaveButton()

//        tableView.reloadData()
        

    }

    private func saveUserData(user : User) {
        /// userDictionaey
        user.saveUserLocaly()
        user.saveUserToFireStore()
        
    }
    
}

//MARK: - TableView Delegate

extension SettingsViewController {
    
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
            contentCell = tableView.dequeueReusableCell(withIdentifier: contentIdentifer, for: indexPath) as? ContentCell
            contentCell.delegate = self
            contentCell.user = user
            return contentCell
        case 1 :
            
            aboutCell = tableView.dequeueReusableCell(withIdentifier: aboutIdentifer, for: indexPath) as? AboutCell
            aboutCell.textView.isUserInteractionEnabled = editingMode
            aboutCell.user = user
            return aboutCell
            
        case 2,3 :
            cell = tableView.dequeueReusableCell(withIdentifier: settingIdentifer, for: indexPath)
            
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
            cell = tableView.dequeueReusableCell(withIdentifier: settingIdentifer, for: indexPath)

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

extension SettingsViewController : ContentCellDelegate {
    
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
            self.showChangeField(value: "Email")
        }))
        
        alertController.addAction(UIAlertAction(title: "Change Name", style: .default, handler: { (alert) in
            self.showChangeField(value: "Name")
        }))
        alertController.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (alert) in
            self.logOutUser()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func showChangeField(value : String) {
        
        let alertView = UIAlertController(title: "Updating\(value)", message: "書き込んでください", preferredStyle: .alert)
        alertView.addTextField { (tf) in
            self.alertTextField = tf
            self.alertTextField.placeholder = "New \(value)"

        }
        
        alertView.addAction(UIAlertAction(title: "Update", style: .destructive, handler: { (action) in
            self.updateUserWith(value: value)
        }))
        
        alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertView, animated: true, completion: nil)
    }
    
    //MARK: - Change User info
    
    private func updateUserWith(value : String) {
        
        guard alertTextField.text != "" else {ProgressHUD.showError("書き込みがありません"); return}
        
        if value == "Email" {
            changeEmail()
        } else {
            changeUsername()
        }
    }
    
    private func changeEmail() {
        
        guard let email = alertTextField.text else {return}
        
        user.updateUserEmail(email: email) { (error) in
            
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
            self.user.email = email
            self.saveUserData(user: self.user)
            
            ProgressHUD.showSucceed("Change succes")
        }
    }
    
    private func changeUsername() {
        
        user.userName = alertTextField.text!
        saveUserData(user: user)
        tableView.reloadData()
    }
    
    
    
    
    private func showPicureOptions() {
        let alertController = UIAlertController(title: "Upload Image", message: "You can Change picture", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Change Avatar", style: .default, handler: { (alert) in
            self.uploadingAvatar = true
            self.showGallry(forAvatar: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Upload Pictures", style: .default, handler: { (alert) in
            self.showGallry(forAvatar: false)

        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func logOutUser() {
        User.logOutCurrentUser { (error) in
            
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
            let loginVC  = LoginViewController()

            DispatchQueue.main.async {
                loginVC.modalPresentationStyle = .fullScreen
                
                self.present(loginVC, animated: true, completion: nil)
            }
            
        }
    }
    
    //MARK: - Gallary
    
    private func showGallry(forAvatar : Bool) {
        
        uploadingAvatar = forAvatar
        
        self.gallry = GalleryController()
        self.gallry.delegate = self
        Config.tabsToShow = [.imageTab, .cameraTab]
        Config.Camera.imageLimit = forAvatar ? 1 : 10
        Config.initialTab = .imageTab
        
        self.present(gallry, animated: true, completion: nil)
        
        
        
    }
    
    //MARK: - File Stroge
    private func uploadAvatar(_ image : UIImage, completion :  @escaping(_ avatarLink : String?) -> Void) {
        
        ProgressHUD.show()
        
        let fileDirectory = "Avatars/_" + User.currentId() + ".jpeg"
        
        FileStorage.uploadImage(image, directry: fileDirectory) { (avatarLink) in
            ProgressHUD.dismiss()
            /// sve file locally
            FileStorage.saveImageLocally(imageData: image.jpegData(compressionQuality: 0.1)! as NSData, fileName: User.currentId())
            completion(avatarLink)
        }
        
        
    }
    
    private func uploadImage(images : [UIImage?]) {
        
        ProgressHUD.show()
        
        /// uploadIMages
        
        FileStorage.uploadMultipleImages(images) { (imageLinks) in
            
            ProgressHUD.dismiss()
            
            self.user.imageLinks = imageLinks
            self.saveUserData(user: self.user)

        }

    }
    
    
    
}
extension SettingsViewController : GalleryControllerDelegate {
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        if images.count > 0 {
            
            if uploadingAvatar {
                /// only one
                images.first!.resolve { (icon) in
                    
                    guard icon != nil else { return }
                    self.editingMode = true
                    self.showSaveButton()
                    self.contentCell.userImageView.image = icon
                    self.avatarImage = icon
                }
            } else {
                
                /// only 10
                Image.resolve(images: images) { (resolvedImages) in
                    ///upload
                    self.uploadImage(images: resolvedImages)
                }
                
            }
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
