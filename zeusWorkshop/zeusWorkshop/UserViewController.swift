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
    @IBOutlet weak var workshopsCountLabel: UILabel!
    
    

    
    var workshopInstructorArray = [String]()
    var workshopNameArray = [String]()
    var workshopImageArray = [String]()
    var workshopDateTimeArray = [String]()
    var workshopLocationArray = [String]()
    var workshopDescriptionArray = [String]()
    var workshopCategoryArray = [String]()
    var workshopFeeArray = [String]()
    var workshopAddressArray = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        
        // Kullanıcı bilgilerini Firebase'den al ve göster
        fetchUserProfile()
        
        /*tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.register(UINib(nibName: "WorkshopsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell2")
        
        getDataFromFirebase()*/
    }
    
    /*func getDataFromFirebase() {
            let fireStoreDatabase = Firestore.firestore()
            
            fireStoreDatabase.collection("Workshops").addSnapshotListener { (snapshot, error) in
                if let error = error {
                    print("Belgeleri getirirken hata oluştu: \(error.localizedDescription)")
                    return
                }
                
                guard let snapshot = snapshot else {
                    print("Snapshot is nil")
                    return
                }
                
                self.clearWorkshopData()
                
                for document in snapshot.documents {
                    let documentID = document.documentID
                    
                    if let wsEgitmen = document.get("wsEgitmen") as? String {
                        self.workshopInstructorArray.append(wsEgitmen)
                    }
                    
                    if let wsAdi = document.get("wsAdi") as? String {
                        self.workshopNameArray.append(wsAdi)
                    }
                    
                    if let wsTarihSaat = document.get("wsTarihSaat") as? String {
                        self.workshopDateTimeArray.append(wsTarihSaat)
                    }
                    if let imageUrl = document.get("imageUrl") as? String {
                        self.workshopImageArray.append(imageUrl)
                    }
                                    
                    if let wsAciklama = document.get("wsAciklama") as? String {
                        self.workshopDescriptionArray.append(wsAciklama)
                    }
                         
                    if let wsKategori = document.get("wsKategori") as? String {
                        self.workshopCategoryArray.append(wsKategori)
                    }
                    
                    if let wsUcret = document.get("wsUcret") as? String {
                        self.workshopFeeArray.append(wsUcret)
                    }
                    if let wsAdres = document.get("wsAdres") as? String {
                        self.workshopAddressArray.append(wsAdres)
                    }
                    if let wsSehir = document.get("wsSehir") as? String {
                        self.workshopLocationArray.append(wsSehir)
                    } else {
                        self.workshopLocationArray.append("Bilgi Yok")
                    }
                }
                self.tableView2.reloadData()
            }
        }

        func clearWorkshopData() {
            // Tüm workshop verilerini temizle
            self.workshopInstructorArray.removeAll()
            self.workshopNameArray.removeAll()
            self.workshopDateTimeArray.removeAll()
            self.workshopImageArray.removeAll()
            self.workshopDescriptionArray.removeAll()
            self.workshopLocationArray.removeAll()
            self.workshopCategoryArray.removeAll()
            self.workshopFeeArray.removeAll()
            self.workshopAddressArray.removeAll()

        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.workshopInstructorArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! HomePageCell
            cell.workshopByLabel.attributedText = createAttributedText(boldText: "Eğitmen: ", normalText: self.workshopInstructorArray[indexPath.row])
            cell.workshopNameLabel.text = self.workshopNameArray[indexPath.row]
            cell.workshopDateTimeLabel.text = self.workshopDateTimeArray[indexPath.row]
            cell.workshopLocationLabel.attributedText = createAttributedText(boldText: "", normalText: self.workshopLocationArray[indexPath.row])
            cell.workshopExplanationLabel.attributedText = createAttributedText(boldText: "Açıklama: ", normalText: self.workshopDescriptionArray[indexPath.row])
            cell.workshopCategoryLabel.attributedText = createAttributedText(boldText: "Kategori: ", normalText: self.workshopCategoryArray[indexPath.row])
            cell.workshopFeeLabel.attributedText = createAttributedText(boldText: "Ücret: ", normalText: self.workshopFeeArray[indexPath.row])
            cell.workshopAddressLabel.attributedText = createAttributedText(boldText: "Adres: ", normalText: self.workshopAddressArray[indexPath.row])
            cell.workshopImageView.image = UIImage(named: "zeusLogo.png")
            
            // Burada imageUrl'den image yükleme işlemi yapılabilir. Örneğin, bir kütüphane kullanılarak.
            // cell.workshopImageView.loadImage(from: self.workshopImageArray[indexPath.row])
            
            return cell
        }

        func createAttributedText(boldText: String, normalText: String) -> NSAttributedString {
            let boldAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 17)]
            let normalAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17)]
            
            let boldString = NSMutableAttributedString(string: boldText, attributes: boldAttributes)
            let normalString = NSAttributedString(string: normalText, attributes: normalAttributes)
            
            boldString.append(normalString)
            return boldString
        } */

        @IBAction func editProfileClicked(_ sender: Any) {
            self.performSegue(withIdentifier: "toEditProfileViewController", sender: nil)
        }
        
        func fetchUserProfile() {
            guard let user = Auth.auth().currentUser else {
                // Kullanıcı oturumu açık değil
                print("Kimliği doğrulanmış kullanıcı yok")
                return
            }
            
            let uid = user.uid
            let db = Firestore.firestore()
            
            // Firestore'dan kullanıcı bilgilerini al
            let docRef = db.collection("users").document(uid)
            docRef.getDocument { (document, error) in
                if let error = error {
                    print("Belge getirilirken hata oluştu: \(error.localizedDescription)")
                    self.displayDefaultProfile()
                    return
                }
                
                if let document = document, document.exists {
                    let data = document.data()
                    let username = data?["username"] as? String ?? "Kullanıcı Adı Yok"
                    let bio = data?["bio"] as? String ?? ""
                    let fullName = data?["fullName"] as? String ?? ""
                    
                    // Kullanıcı bilgilerini UI elemanlarına yerleştir
                    self.usernameLabel.text = username
                    self.bioLabel.text = bio
                    self.fullNameLabel.text = fullName
                    
                    // Kullanıcının workshop sayısını al
                    self.fetchUserWorkshopsCount(for: uid)
                    
                    // Profil fotoğrafını yükleme
                    if let photoURL = user.photoURL {
                        self.loadProfileImage(from: photoURL)
                    } else {
                        self.profileImageView.image = UIImage(named: "defaultProfilePhoto")
                    }
                } else {
                    print("Belge mevcut değil")
                    self.displayDefaultProfile()
                }
            }
        }
        
        func fetchUserWorkshopsCount(for uid: String) {
            let db = Firestore.firestore()
            db.collection("workshops").whereField("userId", isEqualTo: uid).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Workshop sayısı getirilirken hata oluştu: \(error.localizedDescription)")
                    self.workshopsCountLabel.text = "0"
                    return
                }
                
                if let querySnapshot = querySnapshot {
                    let workshopCount = querySnapshot.documents.count
                    print("Workshop sayısı: \(workshopCount)") // Workshop sayısını kontrol etmek için
                    self.workshopsCountLabel.text = "\(workshopCount)"
                } else {
                    self.workshopsCountLabel.text = "0"
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
            self.workshopsCountLabel.text = "0"
            self.profileImageView.image = UIImage(named: "defaultProfilePhoto")
        }
    }
