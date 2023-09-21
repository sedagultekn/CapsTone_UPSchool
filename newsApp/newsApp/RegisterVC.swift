//
//  RegisterVC.swift
//  newsApp
//
//  Created by Seda Gültekin on 11.09.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterVC: UIViewController {

    @IBOutlet weak var eMailTextField: UITextField!

    @IBOutlet weak var passwordAgainTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK: Register
    @IBAction func registerButton(_ sender: Any) {
        if eMailTextField.text != " " && passwordTextField.text != " " && passwordTextField.text == passwordAgainTextField.text {
            
            Auth.auth().createUser(withEmail : eMailTextField.text!, password : passwordTextField.text!) { (authdata, error) in
                if error != nil {
                    print(error?.localizedDescription)

                } else {
                    let storyboard: UIStoryboard = UIStoryboard(name: "tabBarController", bundle: nil)
                    let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "NewsList") as UIViewController
                    self.performSegue(withIdentifier: "NewsList", sender: nil)
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
               
                }
            }
            
        }
        else {
            print("bos")

        }
    }
    
    




}
