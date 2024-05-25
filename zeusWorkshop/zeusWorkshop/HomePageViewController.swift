//
//  HomePageViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 27.03.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import SDWebImage

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var workshopInstructorArray = [String]()
    var workshopNameArray = [String]()
    var workshopImageArray = [String]()
    var workshopDateTimeArray = [String]()
    var workshopLocationArray = [String]()
    var workshopDescriptionArray = [String]()
    var workshopCategoryArray = [String]()
    var workshopFeeArray = [String]()
    var workshopAddressArray = [String]()
    var workshopParticipantsArray = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
                
                tableView.delegate = self
                tableView.dataSource = self
                
                getDataFromFirebase()
            }
    func getDataFromFirebase(){
            let fireStoreDatabase = Firestore.firestore()
            
            fireStoreDatabase.collection("Workshops").addSnapshotListener { (snapshot, error) in
                if let error = error {
                    print("Error fetching documents: \(error.localizedDescription)")
                    return
                }
                
                guard let snapshot = snapshot else {
                    print("Snapshot is nil")
                    return
                }
                
                self.workshopInstructorArray.removeAll()
                self.workshopNameArray.removeAll()
                self.workshopDateTimeArray.removeAll()
                self.workshopImageArray.removeAll()
                self.workshopDescriptionArray.removeAll()
                self.workshopLocationArray.removeAll()
                self.workshopCategoryArray.removeAll()
                self.workshopFeeArray.removeAll()
                self.workshopAddressArray.removeAll()
                self.workshopParticipantsArray.removeAll()
                
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
                    }
                    
                    if let wsKatilimci = document.get("wsKatilimci") as? String {
                        self.workshopParticipantsArray.append(wsKatilimci)
                    } else {
                    // Eğer workshopLocation bilgisi yoksa veya boşsa "Bilgi Yok" olarak ayarla
                        self.workshopLocationArray.append("Bilgi Yok")
                       }
                    }
                        self.tableView.reloadData()
                 }
                }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workshopInstructorArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomePageCell
                cell.workshopByLabel.text = self.workshopInstructorArray[indexPath.row]
                cell.workshopNameLabel.text = self.workshopNameArray[indexPath.row]
                cell.workshopDateTimeLabel.text = self.workshopDateTimeArray[indexPath.row]
                cell.workshopLocationLabel.text = self.workshopLocationArray[indexPath.row]
                cell.workshopExplanationLabel.text = self.workshopDescriptionArray[indexPath.row]
                cell.workshopCategoryLabel.text = self.workshopCategoryArray[indexPath.row]
                cell.workshopFeeLabel.text = self.workshopFeeArray[indexPath.row]
                cell.workshopAddressLabel.text = self.workshopAddressArray[indexPath.row]
                cell.workshopImageView.image = UIImage(named: "zeusLogo.png")

                return cell
        }
    @IBAction func workshopDetailClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toWorkshopContentPage", sender: nil)
    }
}
