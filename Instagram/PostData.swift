//
//  PostData.swift
//  Instagram
//
//  Created by YUKO IMADA on 2018/05/12.
//  Copyright © 2018年 YUKO IMADA. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostData: NSObject {
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    var comments: [[String:String]] = []
    //[名前:名前] [comment:コメント内容]
    
    init(snapshot: DataSnapshot, myId: String) {
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: Any]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: Data(base64Encoded: imageString!, options: .ignoreUnknownCharacters)!)
        
        self.name = valueDictionary["name"] as? String
        
        self.caption = valueDictionary["caption"] as? String
        
        let time = valueDictionary["time"] as? String
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        for likeId in self.likes {
            if likeId == myId {
                self.isLiked = true
                break
            }
        }
        
        if let comments = valueDictionary["comments"] as? [[String:String]] {
            self.comments = comments
        }
        
    }
}

