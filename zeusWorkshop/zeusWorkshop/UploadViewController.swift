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
    @IBOutlet weak var wsAciklama: UITextField!
    @IBOutlet weak var wsEgitmen: UITextField!
    @IBOutlet weak var wsAdres: UITextField!
    @IBOutlet weak var wsSehir: UITextField!
    @IBOutlet weak var wsUcret: UITextField!
    @IBOutlet weak var wsKategori: UITextField!
    @IBOutlet weak var wsTarihSaat: UITextField!
    @IBOutlet weak var paylasButon: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        wsImageView.isUserInteractionEnabled = true //resmi tıklanabilir yapmak
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
        if validateFields() {
                    let storage = Storage.storage()
                    let storageReference = storage.reference()
                    let mediaFolder = storageReference.child("media")
                    
                    if let data = wsImageView.image?.jpegData(compressionQuality: 0.5) {
                        let uuid = UUID().uuidString
                        let imageReference = mediaFolder.child("\(uuid).jpeg")
                        imageReference.putData(data, metadata: nil) { (metadata, error) in
                            if error != nil {
                                self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata")
                            } else {
                                imageReference.downloadURL() { (url, error) in
                                    if error == nil {
                                        let imageUrl = url?.absoluteString
                                        let firestoreDatabase = Firestore.firestore()
                                        let firestoreWorkshop = [
                                            "imageURL": imageUrl!,
                                            "wsEgitmen": self.wsEgitmen.text!,
                                            "wsAdi": self.wsAdi.text!,
                                            "wsUcret": self.wsUcret.text!,
                                            "wsAciklama": self.wsAciklama.text!,
                                            "wsAdres": self.wsAdres.text!,
                                            "wsSehir": self.wsSehir.text!,
                                            "wsKategori": self.wsKategori.text!,
                                            "wsTarihSaat": self.wsTarihSaat.text!
                                        ] as [String: Any]
                                        
                                        firestoreDatabase.collection("Workshops").addDocument(data: firestoreWorkshop) { (error) in
                                            if error != nil {
                                                self.makeAlert(titleInput: "Hata!", messageInput: error?.localizedDescription ?? "Hata")
                                            } else {
                                                self.clearTextFields()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    self.makeAlert(titleInput: "Hata", messageInput: "Lütfen tüm alanları doldurun.")
                }
        
            }

            func validateFields() -> Bool {
                // Check if all text fields are filled
                if wsAdi.text?.isEmpty == true ||
                    wsAciklama.text?.isEmpty == true ||
                    wsEgitmen.text?.isEmpty == true ||
                    wsAdres.text?.isEmpty == true ||
                    wsSehir.text?.isEmpty == true ||
                    wsUcret.text?.isEmpty == true ||
                    wsKategori.text?.isEmpty == true ||
                    wsTarihSaat.text?.isEmpty == true ||
                    wsImageView.image == UIImage(named: "tap and select.png") {
                    return false
                }
                return true
            }

            func clearTextFields() {
                self.wsImageView.image = UIImage(named: "tap and select.png")
                self.wsAdi.text = ""
                self.wsAciklama.text = ""
                self.wsEgitmen.text = ""
                self.wsAdres.text = ""
                self.wsSehir.text = ""
                self.wsUcret.text = ""
                self.wsKategori.text = ""
                self.wsTarihSaat.text = ""
            }

            func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                guard let currentText = textField.text else { return true }
                let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
                
                // Set character limit for wsAciklama and wsAdres fields
                if textField == wsAciklama || textField == wsAdres {
                    return newText.count <= 130
                }
                return true
            }
        }
