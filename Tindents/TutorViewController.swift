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
    @IBOutlet weak var rate: UITextField!
    
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
