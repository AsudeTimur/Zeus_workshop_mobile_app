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
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
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
        guard let user = Auth.auth().currentUser else {
                    // Kullanıcı oturumu açık değil
                    print("No authenticated user")
                    return
                }

                let uid = user.uid
                let db = Firestore.firestore()
                
                // Firestore'dan kullanıcı bilgilerini al
                let docRef = db.collection("users").document(uid)
                docRef.getDocument { (document, error) in
                    if let error = error {
                        print("Error fetching document: \(error)")
                        self.displayDefaultProfile()
                        return
                    }
                    
                    if let document = document, document.exists {
                        let data = document.data()
                        let username = data?["username"] as? String ?? "Kullanıcı Adı Yok"
                        let bio = data?["bio"] as? String ?? ""
                        let fullName = data?["fullName"] as? String ?? ""
                        let followersCount = data?["followersCount"] as? Int ?? 0
                        let followingCount = data?["followingCount"] as? Int ?? 0
                        let workshopsCount = data?["workshopsCount"] as? Int ?? 0
                        
                        // Kullanıcı bilgilerini UI elemanlarına yerleştir
                        self.usernameLabel.text = username
                        self.bioLabel.text = bio
                        self.fullNameLabel.text = fullName
                        self.followersCountLabel.text = "\(followersCount)"
                        self.followingCountLabel.text = "\(followingCount)"
                        self.workshopsCountLabel.text = "\(workshopsCount)"
                        
                        // Profil fotoğrafını yükleme
                        if let photoURL = user.photoURL {
                            self.loadProfileImage(from: photoURL)
                        } else {
                            self.profileImageView.image = UIImage(named: "defaultProfilePhoto")
                        }
                    } else {
                        print("Document does not exist")
                        self.displayDefaultProfile()
                    }
                }
            }

            func loadProfileImage(from url: URL) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.profileImageView.image = UIImage(data: data)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.profileImageView.image = UIImage(named: "defaultProfilePhoto")
                        }
                    }
                }
            }
            
            func displayDefaultProfile() {
                self.usernameLabel.text = "Kullanıcı Adı Yok"
                self.bioLabel.text = ""
                self.fullNameLabel.text = "Tam Ad Yok"
                self.followersCountLabel.text = "0"
                self.followingCountLabel.text = "0"
                self.workshopsCountLabel.text = "0"
                self.profileImageView.image = UIImage(named: "defaultProfilePhoto")
            }
        }
    

