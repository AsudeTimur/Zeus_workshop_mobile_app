//
//  UserViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 27.03.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal
import FirebaseFirestore
import FirebaseAnalytics

class UserViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var workshopsCountLabel: UILabel!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        
        // Kullanıcı bilgilerini Firebase'den al ve göster
        fetchUserProfile()
    }
    
    func fetchUserProfile() {
            if let user = Auth.auth().currentUser {
                let uid = user.uid
                let email = user.email
                let photoURL = user.photoURL
                
                // Kullanıcı bilgilerini etiketlere yerleştir
                usernameLabel.text = email
                
                // Profil fotoğrafını yükle
                if let photoURL = photoURL {
                    loadProfileImage(from: photoURL)
                }
                
                // Diğer kullanıcı bilgilerini Firebase Firestore veya Realtime Database'den alabilirsiniz.
                // Burada sadece Firestore örneğini göstereceğim.
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(uid)
                
                userRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let data = document.data()
                        self.fullNameLabel.text = data?["fullName"] as? String ?? "Ad Soyad"
                        self.bioLabel.text = data?["bio"] as? String ?? "Bio"
                        self.followersCountLabel.text = "\(data?["followersCount"] as? Int ?? 0)"
                        self.followingCountLabel.text = "\(data?["followingCount"] as? Int ?? 0)"
                        self.workshopsCountLabel.text = "\(data?["workshopsCount"] as? Int ?? 0)"
                    } else {
                        print("Kullanıcı belgesi bulunamadı")
                    }
                }
            } else {
                print("Kullanıcı oturum açmamış")
            }
        }
        
        func loadProfileImage(from url: URL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.profileImageView.image = UIImage(data: data)
                    }
                }
            }
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
