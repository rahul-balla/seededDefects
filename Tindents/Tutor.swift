//
//  Tutor.swift
//  Tindents
//
//  Created by Rahul Balla on 2/6/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import Foundation
import UIKit

class Tutor {
    
    var name: String?
    var subjects: [String]?
    var tutorEmail: String?
    var rating: String?
    var picture: UIImage?
    var description: String?
    
    init (dictionary: [String: Any]) {
        name = dictionary["name"] as? String ?? "Creepy Tutor"
        subjects = dictionary["subjects"] as? [String] ?? nil
        tutorEmail = dictionary["tutorEmail"] as? String ?? "No email"
        rating = dictionary["rating"] as? String ?? "No Rating"
        picture = dictionary["picture"] as? UIImage?? nil
        description = dictionary["description"] as? String ?? "No Description"
    }
}
