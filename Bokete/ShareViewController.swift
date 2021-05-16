//
//  ShareViewController.swift
//  Bokete
//
//  Created by 生田拓登 on 2021/05/16.
//

import UIKit

class ShareViewController: UIViewController {

    var resultImage = UIImage()
    var commentString = String()
    
    var screenShotImage = UIImage()
    
    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultImageView.image = resultImage
        commentLabel.text = commentString
        commentLabel.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func share(_ sender: Any) {
//        スクリーンショットをとる
        takeScreenShot()
        let items = [screenShotImage] as [Any]
//        アクティビティービューでシェア
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        present(activityVC, animated: true, completion: nil)
    }
    
    func takeScreenShot(){
        
        let width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(UIScreen.main.bounds.size.height/1.3)
        let size = CGSize(width: width, height: height)

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
