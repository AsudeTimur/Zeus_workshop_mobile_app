//
//  UserSettingsViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 14.05.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class UserSettingsViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func changePasswordClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toChangePassViewController", sender: nil)
    }
    
    @IBAction func deleteAccountClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toDeleteAccountViewController", sender: nil)
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
    
    @IBAction func backClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toUserViewController", sender: nil)
    }
    
   
    
}
