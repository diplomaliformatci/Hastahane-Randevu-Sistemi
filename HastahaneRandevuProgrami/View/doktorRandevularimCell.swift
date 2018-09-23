//
//  doktorRandevularimCell.swift
//  HastahaneRandevuProgrami
//
//  Created by Can KINCAL on 29.04.2018.
//  Copyright © 2018 Can KINCAL. All rights reserved.
//

import UIKit

class doktorRandevularimCell: UITableViewCell {
    @IBOutlet weak var randevuDateLabel: UILabel!
    @IBOutlet weak var patientNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureCell(randevu: Randevu) {
        self.randevuDateLabel.text = randevu.randevuDate;
        self.patientNameLabel.text = randevu.patientId;
        print("Cell Configured patientId: \(randevu.patientId)")
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
