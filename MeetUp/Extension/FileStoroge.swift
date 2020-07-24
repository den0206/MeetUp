//
//  FileStoroge.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/24.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation
import FirebaseStorage

let storoge = Storage.storage()

class FileStorage {
    
    class func uploadImage(_ image : UIImage, directry : String, completion :  @escaping(_ documentLink : String?) -> Void) {
        
        let storageRef = storoge.reference(forURL: kFILEREREFENCE).child(directry)
        
        guard let imageDate = image.jpegData(compressionQuality: 0.1) else {return}
        
        var task : StorageUploadTask!
        
        task = storageRef.putData(imageDate, metadata: nil, completion: { (metadata, error) in
            
            task.removeAllObservers()
            
            guard error == nil else {print("Error uploading image"); return }
            
            storageRef.downloadURL { (url, error) in
                
                guard let downloadUrl = url else {
                    completion(nil)
                    return
                }
                
                completion(downloadUrl.absoluteString)
       
            }
            
        })
    }
    
    class func uploadMultipleImages(_ images : [UIImage?], completion :  @escaping(_ imagetLinks : [String]) -> Void) {
        
        var imageLinkArray = [String]()
        var uploadImagesCount = 0
        var nameSuffix = 0
        
        for image in images {
            let fileDirectry  = "UserImages/" + User.currentId() + "/" + "\(nameSuffix)" + ".jpg"
            
            uploadImage(image!, directry: fileDirectry) { (imageLink) in
                
                if imageLink != nil {
                    imageLinkArray.append(imageLink!)
                    uploadImagesCount += 1
                    
                    if uploadImagesCount == images.count {
                        completion(imageLinkArray)
                    }
                }
            }
            
            nameSuffix += 1
        }
        
        
    }
    
    class func downloadImage(imageUrl : String, completion :  @escaping(_ image : UIImage?) -> Void) {
        
        let imageFileName = ((imageUrl.components(separatedBy: "_").last!).components(separatedBy: "?").first)!.components(separatedBy: ".").first!
        
        if fileExistPath(path: imageFileName) {
            
            if let contentsOfFile = UIImage(contentsOfFile: fileInDocumentDirectry(filename: imageFileName)) {
                completion(contentsOfFile)
            } else {
                print("Coudnt generate image local")
                completion(nil)
            }
        } else {
            /// download
            if imageUrl != "" {
                let documentUrl = URL(string: imageUrl)
                let downloadQueue = DispatchQueue(label: "downloadQueue")
                
                downloadQueue.async {
                    let data = NSData(contentsOf: documentUrl!)
                    
                    if data != nil {
                        let imageToReturn = UIImage(data: data! as Data)
                        
                        FileStorage.saveImageLocally(imageData: data!, fileName: imageFileName)
                        completion(imageToReturn)
                    } else {
                        completion(nil)
                    }
                }
            } else {
                completion(nil)
            }
            
        }
        
        
       
        
    }
    
    class func saveImageLocally(imageData : NSData, fileName : String) {
        var docUrl = getDocumentUrl()
        docUrl = docUrl.appendingPathComponent(fileName, isDirectory: false)
        imageData.write(to: docUrl, atomically: true)
    }
}

func getDocumentUrl() -> URL {
    
    let documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    
    return documentUrl!
    
}

func fileInDocumentDirectry(filename : String) -> String {
    let fileUrl = getDocumentUrl().appendingPathComponent(filename)
    return fileUrl.path
}

func fileExistPath(path : String) -> Bool {
    
    var doesExist = false
    
    let filePath = fileInDocumentDirectry(filename: path)
    
    if FileManager.default.fileExists(atPath: filePath) {
        doesExist = true
    } else {
        doesExist = false
    }
    
    return doesExist
}
