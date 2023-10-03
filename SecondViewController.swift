
import UIKit

//protocol to pass data to first viewController
protocol SecondViewControllerDelegate: AnyObject {
    func didChangeSlideshowDelay(delay: TimeInterval)
}

class SecondViewController: UIViewController {
    
    @IBOutlet weak var delayLabel: UILabel!
    //delegate for protocol
    weak var delegate: SecondViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //slider action
    @IBAction func sliderMoved(_ sender: UISlider) {
        let sliderValue = lroundf(sender.value)
        delayLabel.text = "\(sliderValue)"
        delegate?.didChangeSlideshowDelay(delay: TimeInterval(sliderValue))
    }
    
    //segue function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as! ViewController
    }

}
