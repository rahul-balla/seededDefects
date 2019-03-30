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
    
    var userid: Int!
    var name: String!
    var age: Int!
    var subjects: [String]!
    var tutorEmail: String!
    var rating: Double!
    var picture: UIImage?
    var description: String?
    var id: Int!
    var charge: Double!
    var schedule: String!
    var numRatings: Int!
    
    init (dictionary: [String: Any]) {
        userid = dictionary["userid"] as? Int ?? nil
        name = dictionary["name"] as? String ?? "Creepy Tutor"
        age = dictionary["age"] as? Int ?? nil
        subjects = dictionary["subjects"] as? [String] ?? []
        tutorEmail = dictionary["tutorEmail"] as? String ?? "No email"
        rating = dictionary["rating"] as? Double
        picture = dictionary["picture"] as? UIImage ?? nil
        description = dictionary["description"] as? String ?? "No Description"
        id = dictionary["userId"] as? Int ?? nil
        charge = dictionary["charge"] as? Double
        schedule = dictionary["schedule"] as? String ?? "No schedule posted by user"
        numRatings = dictionary["numRatings"] as? Int
    }
}
