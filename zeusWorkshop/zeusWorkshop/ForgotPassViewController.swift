//
//  ForgotPassViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 6.05.2024.
//

import UIKit
import FirebaseAuth



class ForgotPassViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    @IBAction func forgotPassButtonTapped(_ sender: Any) {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: emailText.text!) { (error) in
            if let error = error{
                self.makeAlert(titleInput: "Hata", messageInput: error.localizedDescription)
            }else{
                self.makeAlert(titleInput: "Tamam", messageInput: "Şifre sıfırlama e-postası gönderildi. Lütfen e-posta kutunuzu kontrol edin.")
            }
                
        }
    }
    
    
    @IBAction func backToLoginPageButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButon = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButon)
        self.present(alert, animated: true, completion: nil)
    }
}
