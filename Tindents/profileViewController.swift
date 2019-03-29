//
//  profileViewController.swift
//  Tindents
//
//  Created by Andre Chang on 2/3/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {

    @IBOutlet weak var rating: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var charge: UILabel!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet weak var schedule: UILabel!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet weak var enteredRating: UITextField!
    var tutor: Tutor?
    var rawSchedule: [String] = []
    var parsedSched: String = ""
    var id : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tutor = tutor {
            print("the accessed tutor is")
            print(tutor.userid)
            
            id = tutor.userid
            name.text = tutor.name
            email.text = tutor.tutorEmail
            userDescription.text = tutor.description
            charge.text = String(tutor.charge)
            userRating.text = tutor.rating
            print("the schedule is \(tutor.schedule)")
            
            rawSchedule = tutor.schedule.components(separatedBy: ",")
            
            for i in rawSchedule.indices {
                if (i == rawSchedule.count - 1){
                    parsedSched = parsedSched + rawSchedule[i]
                } else {
                    parsedSched = parsedSched + rawSchedule[i] + "\n"
                }
            }
            
            print("the parsed schedule is " + parsedSched)
            schedule.numberOfLines = rawSchedule.count
            schedule.text = parsedSched
            
            //request for getting matches profile pictures
            let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:5000/retreiveMatchesPic")! as URL)
            let session = URLSession.shared
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                
                if let error = error {
                    // handle the transport error
                    print("transport error")
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    // handle the server error
                    print("server error")
                    return
                }
                
                var destPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                destPath.appendPathComponent("pictures")
                
                var srcPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                srcPath.appendPathComponent("pictures.zip")
                
                //Write the zip file to the Documents folder of simulator
                do {
                    try data?.write(to: srcPath)
                } catch {
                    print("error writing zip file to simulator directory")
                }
                
                let fm = FileManager()
                
                //unzip file
                do {
                    try fm.createDirectory(at: destPath, withIntermediateDirectories: true, attributes: nil)
                    try fm.unzipItem(at: srcPath, to: destPath)
                } catch {
                    print("error unzipping file")
                }
                
                //update all the tutors with profile pics
                do {
                    let directoryContents = try fm.contentsOfDirectory(at: destPath, includingPropertiesForKeys: nil, options: [])
                    print("directorY Contents: \(directoryContents)")
                    for imageurl in directoryContents {
                        
                        var fileName = imageurl.lastPathComponent
                        let index = fileName.index(of: ".")!
                        fileName = String(fileName[..<index])
                        
                        let imagedata = try! Data(contentsOf: imageurl)
                        let thisimage = UIImage(data: imagedata)
                        
                        if (tutor.userid == Int(fileName)) {
                            DispatchQueue.main.async {
                                self.profileImage.image = thisimage
                            }
                        }
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
                
                /*//remove the zip file from that place
                do {
                    try fm.removeItem(at: destPath)
                    try fm.removeItem(at: srcPath)
                } catch let error as NSError {
                    print("error deleting zip file: \(error)")
                }*/
                
            })
            task.resume()
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onRate(_ sender: Any) {
        if (enteredRating.text == "") {
            
            let alertController = UIAlertController(title: "Invalid Rating", message: "Please enter a non-empty rating", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (Int(enteredRating.text!) == nil) {
//            print("the rating is \(rating.text)")
            
            let alertController = UIAlertController(title: "Invalid Rating", message: "Please enter a valid number containing only numbers", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (/*Double(enteredRating.text!)! > 5 || */Double(enteredRating.text!)! < 0) {
            
            let alertController = UIAlertController(title: "Invalid Rating", message: "Please enter a valid rating between 0 and 5", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            print("entered rating is \(enteredRating.text)")
            print("the tutor id is \(id)")
            requests().setRating(ratedId: (tutor?.userid)!, rating: Double(enteredRating.text!)!) { (response) in
                if let response = response {
                    print("the response is \(response)")
                }
                
            }

//            requests().schedulerRequest(schedulerString: availabile) { (response) in
//                if let response = response {
//                    print("scheduler response: \(response)")
//                    /*var success = response["success"] as? Int
//                     if success == 1 {
//                     print("SUCCESS")
//                     } else {
//                     print("FAILURE")
//                     }*/
//                }
//            }
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
