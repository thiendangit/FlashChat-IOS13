
import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = ""
        var chartIndex = 0.0
        let titles = "⚡️FlashChat"
        for title in titles {
            print(title);
            print(chartIndex );
            Timer.scheduledTimer(withTimeInterval: 0.1 * chartIndex, repeats: false){
                (timer) in
                self.titleLabel.text?.append(title)
            }
            chartIndex += 1
        }
    }
}
