//
//  randevularimCell.swift
//  HastahaneRandevuProgrami
//
//  Created by Can KINCAL on 29.04.2018.
//  Copyright © 2018 Can KINCAL. All rights reserved.
//

import UIKit

class randevularimCell: UITableViewCell {
    @IBOutlet weak var randevuDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(randevu: Randevu) {
        randevuDateLabel.text = randevu.randevuDate;
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
