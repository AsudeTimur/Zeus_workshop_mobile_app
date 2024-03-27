//
//  UserViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 27.03.2024.
//

import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cikisYapButon(_ sender: Any) {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
}
