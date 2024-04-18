//
//  HomePageViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 27.03.2024.
//

import UIKit

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomePageCell
        cell.workshopDateTimeLabel.text = "Tarih - Saat(test)"
        cell.workshopInformationLabel.text = "Bilgi(test)"
        cell.workshopLocationLabel.text = "Konum(test)"
        cell.WorkshopImageView.image = UIImage(named: "zeusLogo.png")
        return cell
    }

}
