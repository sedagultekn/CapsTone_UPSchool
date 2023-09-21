//
//  ProfileVC.swift
//  newsApp
//
//  Created by Seda Gültekin on 21.09.2023.
//

import UIKit
import FirebaseAuth
class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    @IBAction func logoutButton(_ sender: Any) {
        firebaseLogout()
        
    }
    func firebaseLogout() {
        do {
            try Auth.auth().signOut()
                let storyboard: UIStoryboard = UIStoryboard(name: "login+register", bundle: nil)
                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as UIViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)

            
       
        } catch let error as NSError {
            print("Firebase çıkış hatası: \(error.localizedDescription)")
         
        }
    }
 

}
