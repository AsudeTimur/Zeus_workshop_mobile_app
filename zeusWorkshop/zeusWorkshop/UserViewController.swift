//
//  UserViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 27.03.2024.
//

import UIKit
import FirebaseAuth

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Firebase çıkış işlemi
    @IBAction func cikisYapButon(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        }catch{
            print("Hata")
        }
    }
    
    
}
