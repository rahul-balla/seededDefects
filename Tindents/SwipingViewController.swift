//
//  SwipingViewController.swift
//  Tindents
//
//  Created by Rahul Balla on 2/4/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit

class SwipingViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    var divisor: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.card.backgroundColor = UIColor(patternImage: UIImage (named: "ryan")!)
        self.card.center = self.view.center
        card.alpha = 1
        divisor = view.frame.width / 2 / 0.61

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSwipe(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let translation = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        
        card.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
        
        if sender.state == .ended {
            
            if (card.center.x < 75) {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                }
                return
            }
            else if (card.center.x > (view.frame.width - 75)) {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                }
                return
            }
            
            UIView.animate(withDuration: 0.2) {
                card.center = self.view.center
                self.card.transform = .identity
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
