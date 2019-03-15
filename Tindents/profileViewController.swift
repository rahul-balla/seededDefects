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
    
    var tutor: Tutor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tutor = tutor {
            name.text = tutor.name
            email.text = tutor.tutorEmail
            userDescription.text = tutor.description
            charge.text = String(tutor.charge)
            userRating.text = tutor.rating
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onRate(_ sender: Any) {
        if (rating.text == "") {
            
            let alertController = UIAlertController(title: "Invalid Rating", message: "Please enter a non-empty rating", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (Int(rating.text!) == nil) {
            
            let alertController = UIAlertController(title: "Invalid Rating", message: "Please enter a valid number containing only numbers", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (Int(rating.text!)! > 5 || Int(rating.text!)! < 0) {
            
            let alertController = UIAlertController(title: "Invalid Rating", message: "Please enter a valid rating between 0 and 5", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            
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
