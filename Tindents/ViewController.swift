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
        
        let tabBarControl = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        
        var request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/login")! as URL)
        var session = URLSession.shared
        request.httpMethod = "POST"
        
        var params = ["email":emailTxt.text, "password":passTxt.text] as! Dictionary<String, String>
        
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
                        self.performSegue(withIdentifier: "loginSuccess", sender: self)
                    }
                }
                
            } catch {
                print("???")
            }
            
        })
        
        task.resume()
        
    }
    
}

