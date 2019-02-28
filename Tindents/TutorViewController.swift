//
//  TutorViewController.swift
//  Tindents
//
//  Created by Rahul Balla on 2/28/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit



class TutorViewController: UIViewController {
   
    @IBOutlet weak var tutorDescription: UITextField!
    var frameRect: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameRect = tutorDescription.frame
        frameRect.size.height = 100
        tutorDescription.frame = frameRect
        
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
