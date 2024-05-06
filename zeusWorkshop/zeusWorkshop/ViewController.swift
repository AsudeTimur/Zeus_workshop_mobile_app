//
//  ViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 19.03.2024.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var epostaText: UITextField!
    
    @IBOutlet weak var sifreText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func girisYapButon(_ sender: Any) {
        if epostaText.text != "" && sifreText.text != ""{
            Auth.auth().signIn(withEmail: epostaText.text!, password: sifreText.text!) { (authdata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            makeAlert(titleInput: "Yanlış e-mail ya da Şifre", messageInput: "E-mail ya da şifre bir hesaba ait değil. Lütfen e-mail ya da şifreni kontrol edip tekrar dene.")
        }
    }
    
    //Kullanıcı girişleri veri tabanı ile yapıldı
    @IBAction func kaydolButon(_ sender: Any) {
        if epostaText.text != "" && sifreText.text != ""{
            Auth.auth().createUser(withEmail: epostaText.text!, password: sifreText.text!) { (authdata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                    
            }
        } else{
            makeAlert(titleInput: "Yanlış e-mail ya da Şifre", messageInput: "E-mail ya da şifre bir hesaba ait değil. Lütfen e-mail ya da şifreni kontrol edip tekrar dene.")
        }
            
        
    }
    
    @IBAction func sifreUnuttumButon(_ sender: Any) {
        self.performSegue(withIdentifier: "toForgotPassSegue", sender: nil)
    }
    
    //Kullanıcı yanlış işlem yaptığında hata mesajı göstermek için fonksiyon oluşturuldu
    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButon = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButon)
        self.present(alert, animated: true, completion: nil)
    }
}

