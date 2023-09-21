//
//  LoginVCViewController.swift
//  newsApp
//
//  Created by Seda Gültekin on 11.09.2023.
//

import UIKit
import FirebaseAuth
class LoginVC: UIViewController {

    @IBOutlet weak var eMailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func loginButton(_ sender: Any) {
        if eMailTextField.text != " " && passwordTextField.text != " " {
            
            Auth.auth().signIn(withEmail : eMailTextField.text!, password : passwordTextField.text!) { (authdata, error) in
                if error == nil {
                    let storyboard: UIStoryboard = UIStoryboard(name: "tabBarController", bundle: nil)
                    let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "NewsListVC") as UIViewController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
//                    let storyboard = UIStoryboard(name: "tabBarController", bundle: nil)
//                    let hedefViewController = storyboard.instantiateViewController(withIdentifier: "NewsListVC")
//
//                    // View controller'ı görüntüleyin
//                    self.navigationController?.pushViewController(hedefViewController, animated: true)

                } else {
                 print(error)

                }
            }
            
        }
        else {
            print("bos")

        }
        
    }
    

    // MARK: - Navigation

 
}
