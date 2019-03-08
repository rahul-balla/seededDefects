//
//  SwipingViewController.swift
//  Tindents
//
//  Created by Rahul Balla on 2/4/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit

class SwipingViewController: UIViewController {
    
    //    var name: String!
    //    var subjects: [String]!
    //    var tutorEmail: String!
    //    var rating: String?
    //    var picture: UIImage?
    //    var description: String?
    //
    //

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var ageNum: UILabel!
    @IBOutlet weak var subjectArray: UILabel!
    
    var i = 0
    var divisor: CGFloat!
    /*var firstName : [String: Any] = [
        "name" : "Ryan Gosling",
        "age" : 23,
        "subjects" : ["CS", "MATH"],
        "tutorEmail" : "hello@hello.com",
        "rating" : "4.5/5",
        "description" : "hello",
        "picture" : UIImage(named: "ryan")!
    ]
    
    var secondName : [String: Any] = [
        "name" : "Tom Cruise",
        "age" : 60,
        "subjects" : ["PHIL", "CS"],
        "tutorEmail" : "hello@hello.com",
        "rating" : "4.5/5",
        "description" : "hello",
        "picture" : UIImage(named: "tomCruise")!
    ]
    
    var thirdName : [String: Any] = [
        "name" : "Will Smith",
        "age" : 89,
        "subjects" : ["STAT", "CS"],
        "tutorEmail" : "hello@hello.com",
        "rating" : "4.5/5",
        "description" : "hello",
        "picture" : UIImage(named: "willSmith")!
    ]*/

    
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
        
        var num_user = 0
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
                        "userId" : user["userid"]
                    ]
                    
                    num_user += 1
                    
                    let oneTutor = Tutor(dictionary: oneUser)
                    self.tutors.append(oneTutor)
                }
            }
        }
        
        /*let tutor1 = Tutor(dictionary: firstName)
        let tutor2 = Tutor(dictionary: secondName)
        let tutor3 = Tutor(dictionary: thirdName)
        
        self.tutors.append(tutor1)
        self.tutors.append(tutor2)
        self.tutors.append(tutor3)*/
        print("number of swipable ppls: \(num_user)")
        
        if (num_user > 0) {
            setImageDetails(index: i)
            i = i + 1
        } else {
            print("No one to swipe on")
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSwipe(_ sender: UIPanGestureRecognizer) {
        if i < tutors.count - 1 {
            
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
                    requests().leftSwipe(swipedUserId: self.tutors[i].id!) { (response) in
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
                        self.setImageDetails(index: self.i)
//                        card.backgroundColor = UIColor(patternImage: self.tutors[self.i].picture!)
                    }
                    print(i)
                    return
                }
                else if (card.center.x > (view.frame.width - 75)) {
                    //right swipe
                    
                    //sending info to server
                    requests().rightSwipe(swipedUserId: self.tutors[i].id!) { (response) in
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
                        //                        self.i = self.i + 1
                        self.setImageDetails(index: self.i)
//                        card.backgroundColor = UIColor(patternImage: self.tutors[self.i].picture!)
                    }
                    print(i)
                    return
                }
            }
        }
    }
    
    @IBAction func resetPicture(_ sender: UIButton) {
        resetCard()
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
    
}
