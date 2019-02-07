//
//  signupViewController.swift
//  Tindents
//
//  Created by csuser on 2/3/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit

class signupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/")! as URL)
        var session = URLSession.shared
        request.httpMethod = "POST"
        
        var params = ["username":"jameson", "password":"password"] as Dictionary<String, String>
        
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

            /*
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var success = parseJSON["success"] as? Int
                    println("Succes: \(success)")
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }*/
        })
        
        task.resume()
 
        // Do any additional setup after loading the view.
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
