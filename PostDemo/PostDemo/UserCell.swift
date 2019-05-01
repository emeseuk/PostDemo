//
//  UserTableViewCell.swift
//  PostDemo
//
//  Created by Emese Toth on 30/04/2019.
//  Copyright © 2019 Emese Toth. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet var userName : UILabel!
    @IBOutlet var name : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
