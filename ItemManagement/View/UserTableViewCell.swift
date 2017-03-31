//
//  UserTableViewCell.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/03/17.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = 8
        profileImageView.layer.masksToBounds = true

        
//        fullnameLabel.font = UIFont(name: "Lato-Bold", size: 17.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
