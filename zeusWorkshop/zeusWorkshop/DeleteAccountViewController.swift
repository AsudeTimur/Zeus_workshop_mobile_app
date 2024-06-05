//
//  DeleteAccountViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 4.06.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class DeleteAccountViewController: UIViewController {

    
    @IBOutlet weak var passText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func deleteAccountClicked(_ sender: Any) {
        guard let user = Auth.auth().currentUser,
                      let password = passText.text else {
                    print("User or password is missing")
                    self.makeAlert(titleInput: "Error", messageInput: "Please enter your password.")
                    return
                }
                
                let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: password)
                
                // Kullanıcının kimlik doğrulamasını yenile
                user.reauthenticate(with: credential) { authResult, error in
                    if let error = error {
                        print("Reauthentication failed: \(error.localizedDescription)")
                        self.makeAlert(titleInput: "Error", messageInput: "Incorrect password.")
                    } else {
                        print("Reauthentication successful")
                        
                        // Kullanıcının hesabını sil
                        user.delete { error in
                            if let error = error {
                                print("Account deletion failed: \(error.localizedDescription)")
                                self.makeAlert(titleInput: "Error", messageInput: "Failed to delete account.")
                            } else {
                                print("Account deletion successful")
                                
                                // Firestore'dan kullanıcı verilerini sil
                                let db = Firestore.firestore()
                                db.collection("users").document(user.uid).delete { error in
                                    if let error = error {
                                        print("Firestore deletion failed: \(error.localizedDescription)")
                                        self.makeAlert(titleInput: "Error", messageInput: "Failed to delete user data.")
                                    } else {
                                        print("Firestore deletion successful")
                                        self.makeAlert(titleInput: "Success", messageInput: "Account and data deleted successfully.")
                                        self.performSegue(withIdentifier: "toViewController", sender: nil)
                                    }
                                }
                            }
                        }
                    }
                }
        }
    
    
    
    @IBAction func closeClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toCloseDeleteAccountVC", sender: nil)
    }
    
    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButon = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButon)
        self.present(alert, animated: true, completion: nil)
    }

}
