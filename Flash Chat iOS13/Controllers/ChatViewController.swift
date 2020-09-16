

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import IQKeyboardManagerSwift

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    var messages : [Message] = []
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        navigationItem.hidesBackButton = true
        title = "Chat Screen"
        tableView?.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        loadMessage()
    }
    
    func loadMessage () -> Void {
        db.collection(Constants.FStore.collectionName).order(by: Constants.FStore.dateField).addSnapshotListener {
            (querysnapshot, error) in
            self.messages = []
            if let err = error {
                print("error went query \(err)")
            }else{
                if let querys = querysnapshot?.documents{
                    querys.forEach{
                        print($0.data())
                        if let sender = $0[Constants.FStore.senderField] as? String, let message = $0[Constants.FStore.bodyField] as? String{
                            self.messages.append(Message(sender: sender, body: message))
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }else{
                            print("Something went wrong!")
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    @IBAction func sendPressed(_ sender: UIButton) {
        if Auth.auth().currentUser?.email != nil {
            // User is signed in.
            if let user = Auth.auth().currentUser?.email, let message = messageTextfield.text{
                if(message != ""){
                    db.collection(Constants.FStore.collectionName).addDocument(data: [
                        Constants.FStore.senderField : user,
                        Constants.FStore.bodyField: message,
                        Constants.FStore.dateField : Date().timeIntervalSince1970
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else{
                            self.messageTextfield.text = ""
                        }
                    }
                }
            }
        } else {
            // No user is signed in.
            
        }
    }
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        print(indexPath)
        cell.messageLabel?.text  = message.body
        cell.messageLabel?.textColor = UIColor.white
        cell.containerView.backgroundColor = UIColor(named: Constants.BrandColors.purple)
        if(message.sender == Auth.auth().currentUser?.email){
            cell.leftAvatar.isHidden = true
            cell.rightAvatar.isHidden = false
            cell.containerView.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.messageLabel?.textColor = UIColor.blue
        }else{
            cell.leftAvatar.isHidden = false
            cell.rightAvatar.isHidden = true
        }
        return cell
    }
}

extension ChatViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}
