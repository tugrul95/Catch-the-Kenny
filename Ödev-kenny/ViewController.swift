//
//  ViewController.swift
//  Ödev-kenny
//
//  Created by Macbook on 28.12.2021.
//

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    let imageViewWidth = CGFloat(100)
    let imageViewHeight = CGFloat(100)
    var highScore = 0
    var score = 0
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SchedulingMethod()
        scoreLabel.text = "Score: \(score)"
        
}
    func SchedulingMethod() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updatePosition), userInfo: nil, repeats: true)
       }
       @objc func updatePosition() {

           let maxX = view.frame.maxX - imageViewWidth
           let maxY = view.frame.maxY - imageViewHeight
           let xCoord = CGFloat.random(in: 0...maxX)
           let yCoord = CGFloat.random(in: 0...maxY)

           UIView.animate(withDuration: 0.3) {
               self.imageView.transform = CGAffineTransform(translationX: xCoord, y: yCoord)
           }

}
}
