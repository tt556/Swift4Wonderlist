//
//  NextViewController.swift
//  Swift4Wonderlist
//
//  Created by 神崎泰旗 on 2018/10/17.
//  Copyright © 2018年 taiki. All rights reserved.
//

import UIKit

class NextViewController: UIViewController,UITextViewDelegate,UIDocumentInteractionControllerDelegate{
    
    lazy private var documentInteractionController = UIDocumentInteractionController()

    @IBOutlet var textView: UITextView!
    
    var selectedNumber:Int = 0
    
    var screenShotImage:UIImage = UIImage()
    
    //配列
    var titleArray:Array = [String]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //titleArrayをアプリ内から取り出す
        
        if UserDefaults.standard.object(forKey: "array") != nil{
            
            
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
            
            textView.text = titleArray[selectedNumber]
        }
        
    }

    
    //タッチしてキーボードを閉じる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if textView.isFirstResponder {
            
            //閉じる
            textView.resignFirstResponder()
        }
    }
    
    //スクリーンショット
    func takeScreenshot(){
        
        // キャプチャしたい枠を決める
        let rect = CGRect(x: textView.frame.origin.x, y: textView.frame.origin.y, width: textView.frame.width, height: textView.frame.height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        textView.drawHierarchy(in: rect, afterScreenUpdates: true)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        
    }
    
    @IBAction func shareLINE(_ sender: Any) {
        
        takeScreenshot()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            let pastBoard: UIPasteboard = UIPasteboard.general
            
            pastBoard.setData(UIImageJPEGRepresentation(self.screenShotImage, 0.75)!, forPasteboardType: "public.png")
            
            let lineUrlString: String = String(format: "line://msg/image/%@", pastBoard.name as CVarArg)
            
            UIApplication.shared.open(NSURL(string: lineUrlString)! as URL)
        }
        
        
        
        
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
