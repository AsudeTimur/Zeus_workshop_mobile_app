//
//  HomePageCell.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 18.04.2024.
//

import UIKit

class HomePageCell: UITableViewCell {


    @IBOutlet weak var workshopImageView: UIImageView!
    @IBOutlet weak var workshopNameLabel: UILabel!
    @IBOutlet weak var workshopDateTimeLabel: UILabel!
    @IBOutlet weak var workshopLocationLabel: UILabel!
    @IBOutlet weak var workshopInformationLabel: UILabel!
    @IBOutlet weak var workshopByLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
