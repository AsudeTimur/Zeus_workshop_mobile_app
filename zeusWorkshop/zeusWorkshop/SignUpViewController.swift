//
//  SignUpViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 7.05.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let email = emailText.text, !email.isEmpty,
                      let username = usernameText.text, !username.isEmpty,
                      let password = passwordText.text, !password.isEmpty,
                      let confirmPassword = confirmPasswordText.text, !confirmPassword.isEmpty
                else {
                    makeAlert(titleInput: "Hata", messageInput: "Lütfen tüm alanları doldurun")
                    return
                }
                
                // Şifreleri karşılaştır
                if password != confirmPassword {
                    makeAlert(titleInput: "Hata", messageInput: "Parolalar eşleşmiyor")
                    return
                }
                
                // Şifreler eşleşiyorsa kullanıcıyı kaydet
                Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                    if let error = error {
                        self.makeAlert(titleInput: "Hata", messageInput: error.localizedDescription)
                    } else if let user = authResult?.user {
                        // Kullanıcı başarıyla oluşturuldu, Firestore'a kullanıcı adı ve e-posta ekleyin
                        let db = Firestore.firestore()
                        db.collection("users").document(user.uid).setData([
                            "username": username,
                            "email": email
                        ]) { error in
                            if let error = error {
                                self.makeAlert(titleInput: "Hata", messageInput: "Kullanıcı verileri kaydedilemedi")
                            } else {
                                // Veriler başarıyla kaydedildi, ana sayfaya yönlendir
                                self.performSegue(withIdentifier: "toTabBarController", sender: nil)
                            }
                        }
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
