
//
//  File.swift
//  Tindents
//
//  Created by Andre Chang on 2/17/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import Foundation

class requests {
    
    func loginRequest(email:String, password:String, completionBlock: @escaping ([String:AnyObject]?) -> () ) -> Void {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/login")! as URL)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        var params = ["email":email, "password":password] as! Dictionary<String, String>
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            print(request.httpBody)
        } catch {
            print("???")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            //print("Response: \(response)")
            var strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //print("Body: \(strData)")
            //print("Value: \(strData["message"])")
            
            if let error = error {
                // handle the transport error
                completionBlock(nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // handle the server error
                completionBlock(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                completionBlock(json)
                
            } catch {
                completionBlock(nil)
            }
            
        })
        
        
        task.resume()
    }
    
    func signupRequest(email:String, username:String, password:String, name:String, completionBlock: @escaping ([String:AnyObject]?) -> () ) -> Void {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/createAccount")! as URL)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        var params = ["email":email, "username":username, "password":password, "name":name, "account_type":"student"] as! Dictionary<String, String>
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            print(request.httpBody)
        } catch {
            print("???")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            var strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //print("Body: \(strData)")
            //print("Value: \(strData["message"])")
            
            if let error = error {
                // handle the transport error
                completionBlock(nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // handle the server error
                completionBlock(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                completionBlock(json)
                
            } catch {
                completionBlock(nil)
            }
            
        })
        
        task.resume()
    }
    
    func updateSettingsRequest(dict:Dictionary<String,Int>, completionBlock: @escaping ([String:AnyObject]?) -> () ) -> Void {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/settings")! as URL)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: dict, options: [])
            print(request.httpBody)
        } catch {
            print("???")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            var strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("Body: \(strData)")
            //print("Value: \(strData["message"])")
            
            if let error = error {
                // handle the transport error
                completionBlock(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // handle the server error
                completionBlock(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                completionBlock(json)
                
            } catch {
                completionBlock(nil)
            }
            
        })
        
        task.resume()
        
    }
    
    func feedRequest(completionBlock: @escaping ([String:AnyObject]?) -> () ) -> Void {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/feed")! as URL)
        let session = URLSession.shared
        request.httpMethod = "POST"
    
        request.addValue("application/json", forHTTPHeaderField: "Accept")
 
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in

            if let error = error {
                // handle the transport error
                print("transport error")
                completionBlock(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // handle the server error
                print("server error")
                completionBlock(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                completionBlock(json)
                
            } catch {
                print("json error")
                completionBlock(nil)
            }
            
        })
        
        task.resume()
        
    }
    
    func rightSwipe(swipedUserId:Int, completionBlock: @escaping ([String:AnyObject]?) -> () ) -> Void {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/rightSwipe")! as URL)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        var params = ["swipedId":swipedUserId] as! Dictionary<String, Int>
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            print(request.httpBody)
        } catch {
            print("???")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            var strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //print("Body: \(strData)")
            //print("Value: \(strData["message"])")
            
            if let error = error {
                // handle the transport error
                print("transport error")
                completionBlock(nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // handle the server error
                print("server error")
                completionBlock(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                completionBlock(json)
                
            } catch {
                print("json error")
                completionBlock(nil)
            }
            
        })
        
        task.resume()
    }
    
    func leftSwipe(swipedUserId:Int, completionBlock: @escaping ([String:AnyObject]?) -> () ) -> Void {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/leftSwipe")! as URL)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        var params = ["swipedId":swipedUserId] as! Dictionary<String, Int>
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            print(request.httpBody)
        } catch {
            print("???")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            var strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //print("Body: \(strData)")
            //print("Value: \(strData["message"])")
            
            if let error = error {
                // handle the transport error
                print("transport error")
                completionBlock(nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // handle the server error
                print("server error")
                completionBlock(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                completionBlock(json)
                
            } catch {
                print("json error")
                completionBlock(nil)
            }
            
        })
        
        task.resume()
    }
    
    func schedulerRequest(schedulerString:String, completionBlock: @escaping ([String:AnyObject]?) -> () ) -> Void {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/schedule")! as URL)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        var params = ["schedule":schedulerString] as! Dictionary<String, String>
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            print(request.httpBody)
        } catch {
            print("???")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            var strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //print("Body: \(strData)")
            //print("Value: \(strData["message"])")
            
            if let error = error {
                // handle the transport error
                print("transport error")
                completionBlock(nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // handle the server error
                print("server error")
                completionBlock(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                completionBlock(json)
                
            } catch {
                print("json error")
                completionBlock(nil)
            }
            
        })
        
        task.resume()
    }
    
    func logoutRequest(username:String, completionBlock: @escaping ([String:AnyObject]?) -> () ) -> Void {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/logout")! as URL)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        var params = ["username":username] as! Dictionary<String, Int>
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            print(request.httpBody)
        } catch {
            print("???")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            var strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //print("Body: \(strData)")
            //print("Value: \(strData["message"])")
            
            if let error = error {
                // handle the transport error
                print("transport error")
                completionBlock(nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // handle the server error
                print("server error")
                completionBlock(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                completionBlock(json)
                
            } catch {
                print("json error")
                completionBlock(nil)
            }
            
        })
        
        task.resume()
    }
    
   func getMatches(completionBlock: @escaping ([String:AnyObject]?) -> () ) -> Void {
        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/matchesPage")! as URL)
        let session = URLSession.shared
        request.httpMethod = "POST"
    
        request.addValue("application/json", forHTTPHeaderField: "Accept")
    
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
    
            if let error = error {
                // handle the transport error
                print("transport error")
                completionBlock(nil)
                return
            }
    
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // handle the server error
                print("server error")
                completionBlock(nil)
                return
            }
    
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                completionBlock(json)
    
            } catch {
                print("json error")
                completionBlock(nil)
            }
    
        })
    
        task.resume()
    }
    
    func setRating(ratedId: Int, rating: Double, completionBlock: @escaping ([String:AnyObject]?) -> () ) -> Void {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/rateUser")! as URL)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        print("in requests(): ratedId = \(ratedId)")
        print("in requests(): rating = \(rating)")
        var params = ["ratedId":ratedId, "rating":rating] as! Dictionary<String, Any>
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            print(request.httpBody)
        } catch {
            print("???")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            var strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //print("Body: \(strData)")
            //print("Value: \(strData["message"])")
            
            if let error = error {
                // handle the transport error
                completionBlock(nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // handle the server error
                completionBlock(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
                completionBlock(json)
                
            } catch {
                completionBlock(nil)
            }
            
        })
        
        task.resume()
    }
}

//func feedRequest(completionBlock: @escaping ([String:AnyObject]?) -> () ) -> Void {
//
//    let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/feed")! as URL)
//    let session = URLSession.shared
//    request.httpMethod = "POST"
//
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
//
//        if let error = error {
//            // handle the transport error
//            print("transport error")
//            completionBlock(nil)
//            return
//        }
//
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            // handle the server error
//            print("server error")
//            completionBlock(nil)
//            return
//        }
//
//        do {
//            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:AnyObject]
//            completionBlock(json)
//
//        } catch {
//            print("json error")
//            completionBlock(nil)
//        }
//
//    })
//
//    task.resume()
//
//}
