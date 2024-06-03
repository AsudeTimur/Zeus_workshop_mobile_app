//
//  UserSettingsViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 14.05.2024.
//

import UIKit
import FirebaseAuth

class UserSettingsViewController: UIViewController {

   
    @IBOutlet weak var epostaText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var fullNameText: UITextField!
    @IBOutlet weak var bioText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func changePasswordClicked(_ sender: Any) {
    }
    
    @IBAction func deleteAccountClicked(_ sender: Any) {
    }
    
    @IBAction func saveClicked(_ sender: Any) {
    }
    
    //Firebase çıkış işlemi
    @IBAction func logOutClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        }catch{
            print("Hata")
        }
    }
}
