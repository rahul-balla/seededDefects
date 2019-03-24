//
//  SwipingViewController.swift
//  Tindents
//
//  Created by Rahul Balla on 2/4/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit
import Foundation
import MessageUI

class SwipingViewController: UIViewController, MFMailComposeViewControllerDelegate {


    @IBOutlet weak var card: UIView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var ageNum: UILabel!
    @IBOutlet weak var subjectArray: UILabel!
    
    var i = 0
    var divisor: CGFloat!
    
    var tutors: [Tutor] = []
    //        = Tutor(dictionary: dictionary1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.card.frame.size.width = self.view.bounds.width * 0.8
        self.card.frame.size.height = self.view.bounds.height * 0.6
        self.card.layer.cornerRadius = 10
        //self.card.backgroundColor = UIColor(patternImage: UIImage (named: "ryan")!)
        self.card.center.x = self.view.center.x
        self.card.center.y = self.view.center.y - 20
        
        card.alpha = 1
        divisor = view.frame.width / 2 / 0.61
        
        let group = DispatchGroup()
        
        print("the users are: ")
        group.enter()
        requests().feedRequest { (response) in
            if let response = response {
                //list of users to be added
                
                var user_arr = response["feed"]
                for user in user_arr as! [AnyObject] {
                    
                    var oneUser : [String: Any] = [
                        "name" : user["fullName"],
                        "age" : 69,
                        "subjects" : ["STAT", "CS"],
                        "tutorEmail" : user["email"],
                        "rating" : "4.5/5",
                        "description" : "lets have fun",
                        "picture" : UIImage(named: "Harsha")!,
                        "userid" : user["userid"]
                    ]
                    print(user)
                    let oneTutor = Tutor(dictionary: oneUser)
                    self.tutors.append(oneTutor)
                }
                
                group.leave()
            
            }
        }
        
        group.wait()
        
        print("number of swipable ppls: \(tutors.count)")
        
        if (tutors.count > 0) {
            setImageDetails(index: self.i)
        } else {
            print("No one to swipe on")
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSwipe(_ sender: UIPanGestureRecognizer) {
        if i < tutors.count {
            
            let card = sender.view!
            let translation = sender.translation(in: view)
            let xFromCenter = card.center.x - view.center.x
            
            card.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
            
            setImageDetails(index: i)
            
            if sender.state == .ended {
                
                if (card.center.x < 75) {
                    //left swipe
                    
                    //sending info to server
                    requests().leftSwipe(swipedUserId: self.tutors[i].userid!) { (response) in
                        print("left swipe request response: \(response)")
                    }
                    
                    UIView.animate(withDuration: 0.3) {
                        card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                        card.alpha = 0
                    }
                    i = i + 1
                    UIView.animate(withDuration: 1) {
                        self.card.center = self.view.center
                        self.card.transform = .identity
                        card.alpha = 1
                        
                        if (self.i == self.tutors.count) {
                            //last card
                            self.setDefaultImageDetails()
                        } else {
                            self.setImageDetails(index: self.i)
                        }

                    }
                    print("i = \(i)")
                    return
                }
                else if (card.center.x > (view.frame.width - 75)) {
                    //right swipe
                    
                    //sending info to server
                    print("value of i \(i)")
                    print("id: \(self.tutors[i].userid)")
                    requests().rightSwipe(swipedUserId: self.tutors[i].userid) { (response) in
                        let success = response?["success"] as? Int
                        
                        if (success == 5) {
                            let alertController = UIAlertController(title: "Match!", message: "You have a new match!!", preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(alertAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                        print("right swipe request response: \(response)")
                    }
                    
                    UIView.animate(withDuration: 0.3) {
                        card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                        card.alpha = 0
                    }
                    i = i + 1
                    UIView.animate(withDuration: 1) {
                        self.card.center = self.view.center
                        self.card.transform = .identity
                        card.alpha = 1
    
                        if (self.i == self.tutors.count) {
                            //last card
                            self.setDefaultImageDetails()
                        } else {
                            self.setImageDetails(index: self.i)
                        }
                    }
                    print("i = \(i)")
                    return
                }
                else {
//                    UIView.animate(withDuration: 0.3) {
//                        card.center = self.view.center
//                    }
                    
                }
            }
        }
    }
    
    @IBAction func resetPicture(_ sender: UIButton) {
        print("I commented out the function bc reset is not supposed to exist")
        //resetCard()
    }
    
    func resetCard() {
        UIView.animate(withDuration: 0.3) {
            self.card.center = self.view.center
            self.card.alpha = 1
            self.card.transform = .identity
            self.i = 0
            print(self.i)
            //self.card.backgroundColor = UIColor(patternImage: UIImage (named: "ryan")!)
        }
        setImageDetails(index: i)
    }
    
    func setDefaultImageDetails() {
        nameText.text = ""
        ageNum.text = ""
        subjectArray.text = ""
    }
    
    func setImageDetails(index: Int) {
        //SET PIC HERE!!!!
        //card.backgroundColor = UIColor(patternImage: tutors[i].picture!)
        nameText.text = tutors[index].name
        ageNum.text = String(tutors[index].age)
        let arr : [String] = tutors[index].subjects
        var subString : String = ""
        for j in arr.indices {
            if (j == arr.count - 1) {
                subString += arr[j]
            } else {
                subString += (arr[j] + ", ")
            }
        }
        subjectArray.text = subString
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func sendEmailButtonTapped(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
            
        }
        else{
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([nameText.text!])
        mailComposerVC.setSubject("Intrest in Tutoring Services from Tindents")
        
        return mailComposerVC
        
    }
    
    
    func showSendMailErrorAlert(){
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message:"Your device must have an active email account", preferredStyle: UIAlertController.Style.alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        sendMailErrorAlert.show(self, sender: sendMailErrorAlert)
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
