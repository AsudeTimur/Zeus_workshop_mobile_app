//
//  ChangePasswordViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 5.06.2024.
//

import UIKit
import FirebaseAuth

class ChangePasswordViewController: UIViewController {

    
    @IBOutlet weak var availablePasswordText: UITextField!
    @IBOutlet weak var newPasswordText: UITextField!
    @IBOutlet weak var newPasswordAgainText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changePasswordClicked(_ sender: Any) {
        guard let currentPassword = availablePasswordText.text,
                      let newPassword = newPasswordText.text,
                      let newPasswordAgain = newPasswordAgainText.text,
                      !currentPassword.isEmpty,
                      !newPassword.isEmpty,
                      !newPasswordAgain.isEmpty else {
                    makeAlert(titleInput: "Hata", messageInput: "Tüm alanlar zorunludur.")
                    return
                }
                
                if newPassword != newPasswordAgain {
                    makeAlert(titleInput: "Hata", messageInput: "Şifreler eşleşmiyor.")
                    return
                }
                
                guard let user = Auth.auth().currentUser, let email = user.email else {
                    makeAlert(titleInput: "Hata", messageInput: "Kullanıcı bulunamadı.")
                    return
                }
                
                let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
                
                user.reauthenticate(with: credential) { authResult, error in
                    if let error = error {
                        self.makeAlert(titleInput: "Hata", messageInput: "Mevcut şifre yanlış.")
                    } else {
                        user.updatePassword(to: newPassword) { error in
                            if let error = error {
                                self.makeAlert(titleInput: "Hata", messageInput: "Şifre değiştirelemedi.)")
                            } else {
                                self.makeAlert(titleInput: "Başarılı", messageInput: "Şifre değiştirildi.")
                            }
                        }
                    }
                }
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toCloseChangePassVC", sender: nil)
    }
    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButon = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButon)
        self.present(alert, animated: true, completion: nil)
    }

}
