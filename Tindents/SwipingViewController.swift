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
    var i = 0
    var divisor: CGFloat!
    var firstName : [String: Any] = [
        "name" : "Ryan Gosling",
        "subjects" : ["CS"],
        "tutorEmail" : "hello@hello.com",
        "rating" : "4.5/5",
        "description" : "hello",
        "picture" : UIImage(named: "ryan")!
    ]
    
    var secondName : [String: Any] = [
        "name" : "Tom Cruise",
        "subjects" : ["CS"],
        "tutorEmail" : "hello@hello.com",
        "rating" : "4.5/5",
        "description" : "hello",
        "picture" : UIImage(named: "tomCruise")!
    ]
    
    var thirdName : [String: Any] = [
        "name" : "Will Smith",
        "subjects" : ["CS"],
        "tutorEmail" : "hello@hello.com",
        "rating" : "4.5/5",
        "description" : "hello",
        "picture" : UIImage(named: "willSmith")!
    ]

    
    var tutors: [Tutor] = []
    //        = Tutor(dictionary: dictionary1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.card.frame.size.width = self.view.bounds.width * 0.8
        self.card.frame.size.height = self.view.bounds.height * 0.6
        self.card.layer.cornerRadius = 10
        self.card.backgroundColor = UIColor(patternImage: UIImage (named: "ryan")!)
        self.card.center.x = self.view.center.x
        self.card.center.y = self.view.center.y - 20
        
        card.alpha = 1
        divisor = view.frame.width / 2 / 0.61
        
        let tutor1 = Tutor(dictionary: firstName)
        let tutor2 = Tutor(dictionary: secondName)
        let tutor3 = Tutor(dictionary: thirdName)
        
        self.tutors.append(tutor1)
        self.tutors.append(tutor2)
        self.tutors.append(tutor3)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSwipe(_ sender: UIPanGestureRecognizer) {
        if i < tutors.count - 1 {
            
            let card = sender.view!
            let translation = sender.translation(in: view)
            let xFromCenter = card.center.x - view.center.x
            
            card.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
            card.backgroundColor = UIColor(patternImage: tutors[i].picture!)
            
            if sender.state == .ended {
                
                if (card.center.x < 75) {
                    UIView.animate(withDuration: 0.3) {
                        card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                        card.alpha = 0
                    }
                    i = i + 1
                    UIView.animate(withDuration: 1) {
                        self.card.center = self.view.center
                        self.card.transform = .identity
                        card.alpha = 1
                        card.backgroundColor = UIColor(patternImage: self.tutors[self.i].picture!)
                    }
                    print(i)
                    return
                }
                else if (card.center.x > (view.frame.width - 75)) {
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
                        card.backgroundColor = UIColor(patternImage: self.tutors[self.i].picture!)
                    }
                    print(i)
                    return
                }
                
                UIView.animate(withDuration: 0.2) {
                    card.center = self.view.center
                    self.card.transform = .identity
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
            self.card.backgroundColor = UIColor(patternImage: UIImage (named: "ryan")!)
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
