//
//  matchesTableViewCell.swift
//  Tindents
//
//  Created by Andre Chang on 2/3/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit

class matchesTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    
    var tutor: Tutor! {
        didSet{
            name.text = tutor.name
            userDescription.text = tutor.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
