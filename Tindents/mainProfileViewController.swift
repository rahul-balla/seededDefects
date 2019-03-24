//
//  mainProfileViewController.swift
//  Tindents
//
//  Created by Andre Chang on 2/13/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit

extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

class mainProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var fullNameLbl: UILabel!
    @IBOutlet var usernameLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    @IBOutlet var accountTypeLbl: UILabel!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var editImageBtn: UIButton!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var chargeTitleLbl: UILabel!
    @IBOutlet var chargeLbl: UILabel!
    
    @IBOutlet var fullNameTxtField: UITextField!
    @IBOutlet var usernameTxtField: UITextField!
    @IBOutlet var emailTxtField: UITextField!
    @IBOutlet var chargeTxtField: UITextField!
    @IBOutlet var descriptionTxtView: UITextView!
    
    var currUserId = 0
    var editToggle = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide text fields until edit is pressed
        fullNameTxtField.isHidden = true
        usernameTxtField.isHidden = true
        emailTxtField.isHidden = true
        editImageBtn.isHidden = true
        
        chargeTxtField.isHidden = true
        chargeTitleLbl.isHidden = true
        chargeLbl.isHidden = true
        descriptionTxtView.isHidden = true
        
        var request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/profile")! as URL)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            
            do {
                //var strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                //print("BODY: \(strData)")
                var json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                print("JSON: \(json)")
                
                DispatchQueue.main.async {
                    var account_type = json!["account_type"] as? String
                    if (account_type == "tutor") {
                        self.chargeTitleLbl.isHidden = false
                        self.chargeLbl.isHidden = false
                        self.descriptionTxtView.isHidden = false
                    }
                    
                    //Only for tutors
                    let chargeInt: Int = (json!["charge"] as? Int)!
                    self.chargeLbl.text = String(chargeInt) as! String
                    self.chargeTxtField.text = String(chargeInt) as! String
                    self.descriptionTxtView.text = json!["description"] as? String
                    
                    //For everyone
                    self.fullNameLbl.text = json!["fullName"] as? String
                    self.usernameLbl.text = json!["username"] as? String
                    self.emailLbl.text = json!["email"] as? String
                    self.accountTypeLbl.text = json!["account_type"] as? String
                    self.currUserId = json!["userid"] as! Int
                    
                    self.fullNameTxtField.text = json!["fullName"] as? String
                    self.usernameTxtField.text = json!["username"] as? String
                    self.emailTxtField.text = json!["email"] as? String
                }
            
                
            } catch {
                print("???")
            }
        }
        
        task.resume()
    }
    
    func createRequestBodyWith(parameters:[String:String], filePathKey:String, boundary:String) -> NSData{
        
        let body = NSMutableData()
        
        for (key, value) in parameters {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
        }
        
        body.appendString(string: "--\(boundary)\r\n")
        
        var mimetype = "image/jpg"
        
        let defFileName = String(self.currUserId) + ".jpg"
        
        let imageData = profileImage.image?.jpegData(compressionQuality: 0.75)
        //let imageData = UIImageJPEGRepresentation(yourImage, 1)
        
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(defFileName)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageData!)
        body.appendString(string: "\r\n")
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
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
            
            chargeLbl.isHidden = true
            if (accountTypeLbl.text == "tutor") {
                chargeTxtField.isHidden = false
            }
            
            editToggle = 1
        } else {
            //Done with editing
            print("DONE")
            editBtn.setTitle("Edit", for: .normal)
            editBtn.setTitleColor(self.view.tintColor, for: .normal)
            
            fullNameLbl.isHidden = false
            usernameLbl.isHidden = false
            emailLbl.isHidden = false
            fullNameTxtField.isHidden = true
            usernameTxtField.isHidden = true
            emailTxtField.isHidden = true
            editImageBtn.isHidden = true
            
            
            if (accountTypeLbl.text == "tutor") {
                chargeTxtField.isHidden = false
            }
            chargeTxtField.isHidden = true
            
            editToggle = 0
            
            /********** SEND STUFF TO SERVER ************/
            
            let group = DispatchGroup()
            
            group.enter()
            //For updating text information
            requests().updateProfileInfoRequest(email: self.emailTxtField.text!, name: self.fullNameTxtField.text!, username: self.usernameTxtField.text!, charge: Int(self.chargeTxtField!.text!)!, description: self.descriptionTxtView.text) { (response) in
                print("update profile info request response: \(response)")
                group.wait()
            }
            group.leave()
            
            //For updating profile pic
            let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/updateProfile")! as URL)
            let session = URLSession.shared
            
            request.httpMethod = "POST"
            
            let params = ["email":self.emailTxtField.text, "name":self.fullNameTxtField.text, "username:":self.usernameTxtField.text] as! Dictionary<String, String>
            
            let bstring = self.generateBoundaryString()
            do {
                //try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
                try request.httpBody = self.createRequestBodyWith(parameters:params, filePathKey:"file", boundary:bstring) as Data
                request.addValue("multipart/form-data; boundary=" + bstring, forHTTPHeaderField: "Content-Type")
                

                /*try request.httpBody = createBody(parameters: params,
                                              boundary: boundary,
                                              data: profileImage.image!.jpegData(compressionQuality: 0.75)!,
                                              //data: UIImageJPEGRepresentation(profileImage.image!, 0.7)!,
                                              mimeType: "image/jpg",
                                              filename: "hello.jpg")*/
                //print(request.httpBody!)
            } catch {
                print("error with preparing data as json for sending to server")
            }
            
            //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
                //print("Response: \(response)")
                var strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Body: \(strData)")
                
                if let error = error {
                    // handle the transport error
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    // handle the server error
                    print("server error")
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                    
                } catch {
                    
                }
                
            })
            
            task.resume()
        
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
