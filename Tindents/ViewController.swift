//
//  ViewController.swift
//  Tindents
//
//  Created by Rahul Balla on 1/31/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var passTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onLoginPressed(_ sender: Any) {
        
        if emailTxt.text == "" {
            let alertController = UIAlertController(title: "Invalid Username", message: "Please enter a valid username", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if passTxt.text == "" {
            let alertController = UIAlertController(title: "Invalid Password", message: "Please enter a valid password", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let tabBarControl = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
            
            let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/login")! as URL)
            let session = URLSession.shared
            request.httpMethod = "POST"
            
            let params = ["email":emailTxt.text, "password":passTxt.text] as! Dictionary<String, String>
            
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
                print(request.httpBody)
            } catch {
                print("first catch")
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                //print("Response: \(response)")
                //let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                //print("Body: \(strData)")
                //print("Value: \(strData["message"])")
                var err: NSError?
                
                do {
                    var json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                    
                    let success = json?["success"] as? Int
                    if success == 1 {
                        print("Succes: \(success)")
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "loginSuccess", sender: self)
                        }
                    }
                    
                } catch {
                    print("second catch")
                }
                
            })
            
            task.resume()
        }
    }
    
}

