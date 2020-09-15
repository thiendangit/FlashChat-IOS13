

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextfield!.text!, password: passwordTextfield!.text!) { [weak self] authResult, error in
//          guard let strongSelf = self else { return }
            if((error) != nil){
                print("\(error?.localizedDescription ?? "")")
            }else{
                self?.performSegue(withIdentifier: "loginToChat", sender: self)
            }
        }
    }
    
}
