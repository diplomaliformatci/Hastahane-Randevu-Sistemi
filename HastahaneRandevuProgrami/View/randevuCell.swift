//
//  randevuCell.swift
//  HastahaneRandevuProgrami
//
//  Created by Can KINCAL on 28.04.2018.
//  Copyright © 2018 Can KINCAL. All rights reserved.
//

import UIKit

class randevuCell: UITableViewCell {

   
    @IBOutlet weak var doktorAdiLabel: UILabel!
    
    @IBOutlet weak var randevuTarihiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
    }
    
    
    func configureCell(randevu: Randevu) {
        doktorAdiLabel.text = randevu.doctorId;
        randevuTarihiLabel.text = randevu.randevuDate;
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
