//
//  ImagePostCell.swift
//  Birdie-Final
//
//  Created by Emilio Rodriguez on 6/29/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ImagePostCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    @IBOutlet weak var postedImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
