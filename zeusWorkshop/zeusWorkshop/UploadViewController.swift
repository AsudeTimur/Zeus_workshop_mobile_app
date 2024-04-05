//
//  UploadViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 27.03.2024.
//

import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var wsImageView: UIImageView!
    @IBOutlet weak var wsAdi: UITextField!
    @IBOutlet weak var wsTarih: UITextField!
    @IBOutlet weak var wsKonum: UITextField!
    @IBOutlet weak var wsDetay: UITextField!
    @IBOutlet weak var paylasButon: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        wsImageView.isUserInteractionEnabled = true
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
                wsImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage(){
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            wsImageView.image = info[.originalImage] as? UIImage
            self.dismiss(animated: true, completion: nil)
        }
    
    @IBAction func paylasButonClicked(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
