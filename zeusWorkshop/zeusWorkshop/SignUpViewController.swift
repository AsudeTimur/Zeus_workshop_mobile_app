//
//  SignUpViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 7.05.2024.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if emailText.text != "" && passwordText.text != ""{
                            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                                if error != nil{
                                    self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata")
                                }else{
                                    self.performSegue(withIdentifier: "toTabBarController", sender: nil)
                                }
                                    
                            }
                        } else{
                            makeAlert(titleInput: "Yanlış e-mail ya da Şifre", messageInput: "E-mail ya da şifre bir hesaba ait değil. Lütfen e-mail ya da şifreni kontrol edip tekrar dene.")
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
