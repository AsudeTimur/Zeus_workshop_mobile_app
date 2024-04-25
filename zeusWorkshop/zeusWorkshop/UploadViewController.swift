//
//  UploadViewController.swift
//  zeusWorkshop
//
//  Created by Asude Timur on 27.03.2024.
//

import UIKit
import FirebaseCore
import FirebaseStorage
import FirebaseFirestoreInternal
import FirebaseAuth


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
    
    //kütüphaneden fotoğraf seçme
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
    
    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButon = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButon)
        self.present(alert, animated: true, completion: nil)
    }
    
    //verileri firebase'e kaydetme
    @IBAction func paylasButonClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = wsImageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString //her kullanıldığında unique id'yi stringe çevirir
            let imageReference = mediaFolder.child("\(uuid).jpeg")
            imageReference.putData(data, metadata: nil){
                (metadata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata")
                }else{
                    imageReference.downloadURL(){(url, error) in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            
                            //DataBase
                            
                            let firestoreDatabase = Firestore.firestore()
                            //firebase db'leri okumak, yazmak, değişikleri dinlemek vb.
                            var firestorReference : DocumentReference? = nil
                            let firestoreWorkshop = ["imageURL" : imageUrl!, "workshoppedBy" : Auth.auth().currentUser!.email!, "workshopName" : "name", "date" : "date", "imformation" : "imformation", "location" : "location"] as [String : Any]
                            firestorReference = firestoreDatabase.collection("Workshops").addDocument(data: firestoreWorkshop, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Hata!", messageInput: error?.localizedDescription ?? "Hata")
                                }
                            })
                        }
                    }
                }
            }
        }
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
