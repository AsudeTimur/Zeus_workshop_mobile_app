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

   
    @IBOutlet weak var epostaText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var fullNameText: UITextField!
    @IBOutlet weak var bioText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUserProfile()
    }
    
    func loadUserProfile() {
        guard let user = Auth.auth().currentUser else {
                    // Kullanıcı oturumu açık değil
                    return
                }
                
                let uid = user.uid
                let db = Firestore.firestore()
                
                // Mevcut kullanıcı verilerini al
                let docRef = db.collection("users").document(uid)
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let data = document.data() ?? [:]
                        
                        // Kullanıcı bilgilerini UI elemanlarına yerleştir
                        DispatchQueue.main.async {
                            self.epostaText.text = user.email
                            self.phoneText.text = data["phone"] as? String
                            self.usernameText.text = data["username"] as? String
                            self.fullNameText.text = data["fullName"] as? String
                            self.bioText.text = data["bio"] as? String
                            self.locationText.text = data["location"] as? String
                        }
                    } else {
                        print("Belge mevcut değil")
                    }
                }
        }

    @IBAction func changePasswordClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toChangePassViewController", sender: nil)
    }
    
    @IBAction func deleteAccountClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toDeleteAccountViewController", sender: nil)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        guard let user = Auth.auth().currentUser else {
                    // Kullanıcı oturumu açık değil
                    return
                }
                
                let uid = user.uid
                let db = Firestore.firestore()
                
                // Mevcut kullanıcı verilerini al
                let docRef = db.collection("users").document(uid)
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        var data = document.data() ?? [:]
                        
                        // Yeni verileri ekleyin, mevcut değerler yerine geçebilir
                        data["username"] = self.usernameText.text ?? data["username"]
                        data["phone"] = self.phoneText.text ?? data["phone"]
                        data["fullName"] = self.fullNameText.text ?? data["fullName"]
                        data["bio"] = self.bioText.text ?? data["bio"]
                        data["location"] = self.locationText.text ?? data["location"]
                        
                        // Güncellenmiş verileri kaydet
                        db.collection("users").document(uid).setData(data) { error in
                            if let error = error {
                                print("Belge güncellenirken hata oluştu")
                                self.makeAlert(titleInput: "Error", messageInput: "Kullanıcı verileri kaydedilemedi")
                            } else {
                                print("Belge başarıyla güncellendi")
                                self.makeAlert(titleInput: "Başarılı", messageInput: "Profil başarıyla güncellendi")
                            }
                        }
                    } else {
                        print("Belge mevcut değil")
                        self.makeAlert(titleInput: "Hata", messageInput: "Kullanıcı verileri mevcut değil")
                    }
                }
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
    
   
    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButon = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButon)
        self.present(alert, animated: true, completion: nil)
    }
}
