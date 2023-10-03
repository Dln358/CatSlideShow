//
//  ViewController.swift
//  CatSlideShow
//
//  Created by Dylan Lindeman

import UIKit

class ViewController: UIViewController, SecondViewControllerDelegate {
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    @IBOutlet weak var playStop: UIButton!
    @IBOutlet weak var ImageLabel: UIImageView!

    //array to hold images
    let images: [UIImage] = [
        UIImage(named: "img1")!, UIImage(named: "img2")!, UIImage(named: "img3")!,
        UIImage(named: "img4")!, UIImage(named: "img5")!, UIImage(named: "img6")!,
        UIImage(named: "img7")!, UIImage(named: "img8")!, UIImage(named: "img9")!,
        UIImage(named: "img10")!
    ]
    //variables for array and make timer default 3 seconds
    var currentImageIndex = 0
    var slideShowTimer: Timer?
    var slideshowDelay: TimeInterval = 3 {
        didSet {
            UserDefaults.standard.set(slideshowDelay, forKey: "slideshowDelay")
            stopSlideshow()
            startSlideshow()
        }
    }

    //image contraints and auto start slide show
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageLabel.contentMode = .scaleAspectFit
        ImageLabel.image = images[currentImageIndex]
        startSlideshow()
    }

    //start slideshow
    func startSlideshow() {
        slideShowTimer = Timer.scheduledTimer(withTimeInterval: slideshowDelay, repeats: true) { [weak self] _ in
            self?.showNextImage()//timer class
        }
    }

    //stop slideshow
    func stopSlideshow() {
        slideShowTimer?.invalidate()
        slideShowTimer = nil
    }

    //cycle through image array function
    func showNextImage() {
        currentImageIndex += 1
        if currentImageIndex >= images.count {
            currentImageIndex = 0
        }
        ImageLabel.image = images[currentImageIndex]
    }

    //left arrow button, also stop timer
    @IBAction func leftArrowPressed(_ sender: Any) {
        currentImageIndex -= 1
        if currentImageIndex < 0 {
            currentImageIndex = images.count - 1
        }
        stopSlideshow()
        ImageLabel.image = images[currentImageIndex]
    }

    //right arrow action, also stop timer
    @IBAction func rightArrowPressed(_ sender: Any) {
        currentImageIndex += 1
        if currentImageIndex >= images.count {
            currentImageIndex = 0
        }
        stopSlideshow()
        ImageLabel.image = images[currentImageIndex]
    }

    //play/stop button action
    @IBAction func playStopPressed(_ sender: Any) {
        if slideShowTimer != nil {
            stopSlideshow()
            playStop.setTitle("Play", for: .normal)
        } else {
            startSlideshow()
            playStop.setTitle("Stop", for: .normal)
        }
    }
    
    //settings button action
    @IBAction func settingsPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowSettings", sender: self)
    }
    
    //function for delay change protocol
    func didChangeSlideshowDelay(delay: TimeInterval) {
            slideshowDelay = delay
        }
    
    //segue function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSettings" {
            if let secondViewController = segue.destination as? SecondViewController {
                secondViewController.delegate = self
            }
        }
    }

    //unwind function to return to first view
    @IBAction func unwindToFirstView(_ sender: UIStoryboardSegue) {
        //no code needed
    }
    
}

