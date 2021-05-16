//
//  ViewController.swift
//  Bokete
//
//  Created by 生田拓登 on 2021/05/15.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON

class ViewController: UIViewController {
    
    var checkPermission = CheckPermission()

    @IBOutlet weak var odaiImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.delegate = self
        searchTextField.delegate = self
        
        commentTextView.layer.cornerRadius = 20
        checkPermission.checkCamera()
        getImages(keyword: "funny")
    }

    func getImages(keyword: String) {
//        apikey
        
        let url = "https://pixabay.com/api/?key=20214176-79d8e935bd4d3ceb22b3122a4&q=\(keyword)"
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result{
            
            case.success:
                
                let json: JSON = JSON(response.data as Any)
                var imageString = json["hits"][self.count]["webformatURL"].string
                
                if imageString == nil{
                    imageString = json["hits"][0]["webformatURL"].string
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                }else{
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                }
                
                self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                
            case.failure(let error):
                
                print(error)
            }
        }
    }
    
    @IBAction func nextOdai(_ sender: Any) {
        
        count += 1
        
        if searchTextField.text == "" {
            getImages(keyword: "funny")
        }else{
            getImages(keyword: searchTextField.text!)
        }
        
        
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        count = 0
        
        if searchTextField.text == ""{
            getImages(keyword: "funny")
        }else{
            getImages(keyword: searchTextField.text!)
        }
    }
    
    
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shareVC = segue.destination as? ShareViewController
        shareVC?.commentString = commentTextView.text
        shareVC?.resultImage = odaiImageView.image!
    }
    
}
extension ViewController: UITextFieldDelegate,UITextViewDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        commentTextView.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
}





