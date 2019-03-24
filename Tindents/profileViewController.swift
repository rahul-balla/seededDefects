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
            
        } else if (Double(enteredRating.text!)! > 5 || Double(enteredRating.text!)! < 0) {
            
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
