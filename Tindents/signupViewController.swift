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
        var request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/createAccount")! as URL)
        var session = URLSession.shared
        request.httpMethod = "POST"
        
        var params = ["email":emailLbl.text, "username":userLbl.text, "password":passLbl.text, "name":nameLbl.text] as! Dictionary<String, String>
        
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
            var err: NSError?
            
            do {
                var json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                
                var success = json as? Int
                print("Succes: \(success)")
                
            } catch {
                print("???")
            }
            
        })
        
        task.resume()
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
