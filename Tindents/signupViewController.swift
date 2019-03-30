//
//  signupViewController.swift
//  Tindents
//
//  Created by csuser on 2/3/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit

class signupViewController: UIViewController {

    @IBOutlet var emailLbl: UITextField!
    @IBOutlet var userLbl: UITextField!
    @IBOutlet var nameLbl: UITextField!
    @IBOutlet var passLbl: UITextField!
    @IBOutlet var copyPassLbl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createBtnPressed(_ sender: Any) {
        
        if (emailLbl.text == "") {
//
//            let alertController = UIAlertController(title: "Invalid Email", message: "Please enter a valid email", preferredStyle: .alert)
//            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alertController.addAction(alertAction)
//            self.present(alertController, animated: true, completion: nil)
            
        } else if (emailLbl.text != "") {
            
//            let charset = CharacterSet(charactersIn: "@")
//            let s = emailLbl.text as String!
//
//            if s!.rangeOfCharacter(from: charset) == nil{
//                let alertController = UIAlertController(title: "Invalid Email", message: "Please enter a valid email", preferredStyle: .alert)
//                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alertController.addAction(alertAction)
//                self.present(alertController, animated: true, completion: nil)
//            }

        }
        
        if (userLbl.text == "") {
//
//            let alertController = UIAlertController(title: "Invalid Username", message: "Please enter a non-empty username", preferredStyle: .alert)
//            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alertController.addAction(alertAction)
//            self.present(alertController, animated: true, completion: nil)
            
        } else if (nameLbl.text == "") {
            
//            let alertController = UIAlertController(title: "Invalid Name", message: "Please enter a non-empty name", preferredStyle: .alert)
//            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alertController.addAction(alertAction)
//            self.present(alertController, animated: true, completion: nil)
            
        } else if (passLbl.text == "") {
            
//            let alertController = UIAlertController(title: "Invalid password", message: "Please enter a non-empty password", preferredStyle: .alert)
//            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alertController.addAction(alertAction)
//            self.present(alertController, animated: true, completion: nil)
            
        } else if (copyPassLbl.text == "") {
            
//            let alertController = UIAlertController(title: "Invalid password", message: "Please retype your password", preferredStyle: .alert)
//            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alertController.addAction(alertAction)
//            self.present(alertController, animated: true, completion: nil)
            
        } else if (passLbl.text != copyPassLbl.text) {
            
//            let alertController = UIAlertController(title: "Passwords do not match", message: "Please enter same passwords in both fields", preferredStyle: .alert)
//            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alertController.addAction(alertAction)
//            self.present(alertController, animated: true, completion: nil)
            
        } else {
            var request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/createAccount")! as URL)
            var session = URLSession.shared
            request.httpMethod = "POST"
            
            var params = ["email":emailLbl.text, "username":userLbl.text, "password":passLbl.text, "name":nameLbl.text] as! Dictionary<String, String>
            params["account_type"] = "student"
            
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
                print(request.httpBody)
            } catch {
                print("???")
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            var task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                print("Response: \(response)")
                var strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Body: \(strData)")
                //print("Value: \(strData["message"])")
                var err: NSError?
                
                do {
                    var json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                    
                    var success = json?["success"] as? Int
                    if success == 1 {
                        print("Succes: \(success)")
                        
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "createSuccess", sender: self)
                        }
                    } else if success == 2 {
                        
//                        let alertController = UIAlertController(title: "Invalid username", message: "The username you entered already exists", preferredStyle: .alert)
//                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                        alertController.addAction(alertAction)
//
//                        DispatchQueue.main.async {
//                           self.present(alertController, animated: true, completion: nil)
//                        }
//                        self.present(alertController, animated: true, completion: nil)
                        
                    } else if success == 3 {
                        
//                        let alertController = UIAlertController(title: "Invalid email", message: "The email you entered already exists", preferredStyle: .alert)
//                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                        alertController.addAction(alertAction)
//                        DispatchQueue.main.async {
//                            self.present(alertController, animated: true, completion: nil)
//                        }
                        //self.present(alertController, animated: true, completion: nil)
                    }
                    
                } catch {
                    print("???")
                }
                
            })
            
            task.resume()
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //let viewController = segue.destination
    }
 

}
