//
//  mainProfileViewController.swift
//  Tindents
//
//  Created by Andre Chang on 2/13/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit

class mainProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var fullNameLbl: UILabel!
    @IBOutlet var usernameLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    @IBOutlet var accountTypeLbl: UILabel!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var editImageBtn: UIButton!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var fullNameTxtField: UITextField!
    @IBOutlet var usernameTxtField: UITextField!
    @IBOutlet var emailTxtField: UITextField!
    
    var editToggle = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide text fields until edit is pressed
        fullNameTxtField.isHidden = true
        usernameTxtField.isHidden = true
        emailTxtField.isHidden = true
        editImageBtn.isHidden = true
        
        var request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/profile")! as URL)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            
            do {
                //var strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                //print("BODY: \(strData)")
                var json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                
                DispatchQueue.main.async {
                    self.fullNameLbl.text = json!["fullName"] as? String
                    self.usernameLbl.text = json!["username"] as? String
                    self.emailLbl.text = json!["email"] as? String
                    self.accountTypeLbl.text = json!["account_type"] as? String
                    
                    self.fullNameTxtField.text = json!["fullName"] as? String
                    self.usernameTxtField.text = json!["username"] as? String
                    self.emailTxtField.text = json!["email"] as? String
                }
            
                print(json)
                
            } catch {
                print("???")
            }
        }
        
        task.resume()
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        if (editToggle == 0) {
            //edit mode
            editBtn.setTitle("Done", for: .normal)
            editBtn.setTitleColor(UIColor.red, for: .normal)
            
            //fullNameLbl.layer.borderColor = UIColor.black.cgColor
            fullNameLbl.isHidden = true
            usernameLbl.isHidden = true
            emailLbl.isHidden = true
            fullNameTxtField.isHidden = false
            usernameTxtField.isHidden = false
            emailTxtField.isHidden = false
            editImageBtn.isHidden = false
            
            editToggle = 1
        } else {
            //Done with editing
            editBtn.setTitle("Edit", for: .normal)
            editBtn.setTitleColor(self.view.tintColor, for: .normal)
            
            fullNameLbl.isHidden = false
            usernameLbl.isHidden = false
            emailLbl.isHidden = false
            fullNameTxtField.isHidden = true
            usernameTxtField.isHidden = true
            emailTxtField.isHidden = true
            editImageBtn.isHidden = true
            
            editToggle = 0
        }
    }
    
    @IBAction func editImageBtnPressed(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            //after it is complete
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = image
        } else {
            // error message
            print("ERROR with uploading image")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        /*requests().logoutRequest(username:self.usernameLbl.text!) { (response) in
            print("logout btn response: \(response)")
        }*/
        performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
}
