//
//  PostTableViewCell.swift
//  PostDemo
//
//  Created by Emese Toth on 29/04/2019.
//  Copyright © 2019 Emese Toth. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet var titleLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
