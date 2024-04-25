//
//  HomePageViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 27.03.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var workshopNameArray = [String]()
    var workshopImageArray = [String]()
    var workshopDateArray = [String]()
    var workshopInformationArray = [String]()
    var workshopLocationArray = [String]()

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
            
            self.userEmailArray.removeAll()
            self.workshopNameArray.removeAll()
            self.workshopDateArray.removeAll()
            self.workshopImageArray.removeAll()
            self.workshopInformationArray.removeAll()
            self.workshopLocationArray.removeAll()
            
            for document in snapshot.documents {
                let documentID = document.documentID
                
                if let workshoppedBy = document.get("workshoppedBy") as? String {
                    self.userEmailArray.append(workshoppedBy)
                }
                
                if let workshopName = document.get("workshopName") as? String {
                    self.workshopNameArray.append(workshopName)
                }
                
                if let date = document.get("date") as? String {
                    self.workshopDateArray.append(date)
                }
                
                if let imageUrl = document.get("imageUrl") as? String {
                    self.workshopImageArray.append(imageUrl)
                }
                
                if let information = document.get("information") as? String {
                    self.workshopInformationArray.append(information)
                }
                
                if let location = document.get("workshopLocation") as? String {
                    self.workshopLocationArray.append(location)
                } else {
                    // Eğer workshopLocation bilgisi yoksa veya boşsa "Bilgi Yok" olarak ayarla
                    self.workshopLocationArray.append("Bilgi Yok")
                }
            }
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomePageCell
        cell.workshoppedByLabel.text = self.userEmailArray[indexPath.row]
        cell.workshopNameLabel.text = self.workshopNameArray[indexPath.row]
        cell.workshopDateTimeLabel.text = self.workshopDateArray[indexPath.row]
        cell.workshopInformationLabel.text = "Bilgi Yok"
        cell.workshopLocationLabel.text = self.workshopLocationArray[indexPath.row]
        cell.workshopImageView.image = UIImage(named: "zeusLogo.png")
        return cell
    }
}
