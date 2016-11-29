//
//  CustomTableViewCell.swift
//  quiz_test
//
//  Created by Konada on 11/29/16.
//  Copyright © 2016 Konada. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

	@IBOutlet var quizTitleLabel: UILabel!
	@IBOutlet var quizProgressLabel: UILabel!
	@IBOutlet var quizImage: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
