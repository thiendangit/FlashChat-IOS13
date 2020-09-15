

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: (emailTextfield?.text)!, password: (passwordTextfield?.text)!) { authResult, error in
            if let err = error {
                print("\(err.localizedDescription)")
            }else{
                self.performSegue(withIdentifier: "registerToChat", sender: self)
            }
        }
    }
    
}
