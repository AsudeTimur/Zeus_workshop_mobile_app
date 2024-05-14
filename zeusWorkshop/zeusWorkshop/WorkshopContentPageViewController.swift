//
//  WorkshopContentPageViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 14.05.2024.
//

import UIKit

class WorkshopContentPageViewController: UIViewController {


    @IBOutlet weak var workshopImageView: UIImageView!
    @IBOutlet weak var workshopNameLabel: UILabel!
    @IBOutlet weak var workshopDateLabel: UILabel!
    @IBOutlet weak var workshopLocationLabel: UILabel!
    @IBOutlet weak var workshopParticipantsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backToHomePageClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toUserSettingsViewController", sender: nil)
    }
    
}
