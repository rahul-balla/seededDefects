//
//  TutorViewController.swift
//  Tindents
//
//  Created by Rahul Balla on 2/28/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit



class TutorViewController: UIViewController {
    var frameRect: CGRect!
    
    @IBOutlet weak var tutorEmail: UITextField!
    @IBOutlet weak var tutorDescription: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var retypePassword: UITextField!
    @IBOutlet weak var subjects: UITextField!
<<<<<<< HEAD
    @IBOutlet var username: UITextField!
=======
    @IBOutlet weak var rate: UITextField!
>>>>>>> c8b2cd1e9f77f39dc5d38073028237ce362a3496
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        frameRect = tutorDescription.frame
        frameRect.size.height = 100
        tutorDescription.frame = frameRect
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onCreateTutor(_ sender: Any) {
        
        if (tutorEmail.text == "") {
            
            let alertController = UIAlertController(title: "Invalid Email", message: "Please enter a valid email", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (fullName.text == "") {
            
            let alertController = UIAlertController(title: "Invalid Full Name", message: "Please enter a non-empty name", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (password.text == "") {
            
            let alertController = UIAlertController(title: "Invalid Password", message: "Please enter a non-empty password", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (retypePassword.text == "") {
            
            let alertController = UIAlertController(title: "Invalid Password", message: "Please retype your password", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (tutorDescription.text == "") {
            
            let alertController = UIAlertController(title: "Invalid Description", message: "Please enter a non-empty description", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (subjects.text == "") {
            
            let alertController = UIAlertController(title: "Invalid Subjects", message: "Please enter the subjects you can tutor", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (rate.text == "") {

            let alertController = UIAlertController(title: "Invalid Rate", message: "Please enter a non-empty rate", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)

        } else if (Int(rate.text!)! <= 0) {

            let alertController = UIAlertController(title: "Invalid Rate", message: "Please enter a valid number greater than 0", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)

        } else if (password.text != retypePassword.text) {
            
            let alertController = UIAlertController(title: "Passwords do not match", message: "Please enter the same password in both fields", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            var request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/createAccount")! as URL)
            var session = URLSession.shared
            request.httpMethod = "POST"
            
            var params = ["email":tutorEmail.text, "username":username.text, "password":password.text, "name":fullName.text] as! Dictionary<String, String>
            params["account_type"] = "tutor"
            
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
                    }
                    
                } catch {
                    print("???")
                }
                
            })
            
            task.resume()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
