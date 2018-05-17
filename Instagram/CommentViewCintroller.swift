//
//  CommentViewCintroller.swift
//  Instagram
//
//  Created by YUKO IMADA on 2018/05/12.
//  Copyright © 2018年 YUKO IMADA. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class CommentViewCintroller: UIViewController {

    @IBOutlet weak var commentText: UITextField!
    
    var postData: PostData!
    // 投稿ボタンをタップしたときに呼ばれるメソッド
    @IBAction func commentOkButton(_ sender: Any) {
        
        // postDataに必要な情報を取得しておく
        let name = Auth.auth().currentUser?.displayName
        
        // 辞書を作成してFirebaseに保存する
        let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
        let  commentData = ["comments": commentText.text!, "name": name!]
        postData.comments.append(commentData)
        postRef.updateChildValues(["comments":postData.comments])
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        // 全てのモーダルを閉じる
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    // キャンセルボタンをタップしたときに呼ばれるメソッド
    @IBAction func commentCancelButton(_ sender: Any) {
        // 画面を閉じる           comment??
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
