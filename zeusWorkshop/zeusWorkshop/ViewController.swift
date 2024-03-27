//
//  ViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 19.03.2024.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var epostaText: UITextField!
    
    @IBOutlet weak var sifreText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func girisYapButon(_ sender: Any) {
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    @IBAction func kaydolButon(_ sender: Any) {
    }
    
    @IBAction func sifreUnuttumButon(_ sender: Any) {
    }
}

