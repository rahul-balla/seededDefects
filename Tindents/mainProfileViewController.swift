//
//  mainProfileViewController.swift
//  Tindents
//
//  Created by Andre Chang on 2/13/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit

class mainProfileViewController: UIViewController {

    @IBOutlet var fullNameLbl: UILabel!
    @IBOutlet var usernameLbl: UILabel!
    @IBOutlet var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/profile")! as URL)
        request.httpMethod = "GET"
        
        //var params = ["email":emailLbl.text, "username":userLbl.text, "password":passLbl.text, "name":nameLbl.text] as! Dictionary<String, String>
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            
            do {
                var strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Body: \(strData)")
                
                var json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                
                DispatchQueue.main.async {
                    self.fullNameLbl.text = json!["fullName"] as? String
                    self.usernameLbl.text = json!["username"] as? String
                }
            
                print(json)
                
            } catch {
                print("???")
            }
        }
        
        task.resume()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        /*requests().logoutRequest(username:self.usernameLbl.text!) { (response) in
            print("logout btn response: \(response)")
        }*/
        performSegue(withIdentifier: "logoutSegue", sender: nil)
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
