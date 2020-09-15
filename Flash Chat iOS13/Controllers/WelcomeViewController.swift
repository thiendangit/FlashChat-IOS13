
import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        titleLabel.text = ""
//        var chartIndex = 0.0
        
        titleLabel.text = "⚡️FlashChat"
        let datas = [
            "test" : "1234",
            "test1" : "1234",
            "test2" : "1234"
        ]
        
        datas.forEach {
            print($0.key)
        }
        
//        for title in titles {
//            print(title);
//            print(chartIndex);
//            Timer.scheduledTimer(withTimeInterval: 0.1 * chartIndex, repeats: false){
//                (timer) in
//                self.titleLabel.text?.append(title)
//            }
//            chartIndex += 1
//        }
    }
}
