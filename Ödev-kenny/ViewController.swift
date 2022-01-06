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
    var hideTimer = Timer()
    var counter = 0
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SchedulingMethod()
        scoreLabel.text = "Score: \(score)"
        //Highscore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
            imageView.isUserInteractionEnabled = true
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            imageView.addGestureRecognizer(recognizer)
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(stopAnimating), userInfo: nil, repeats: true)
        
        
}
    func SchedulingMethod() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePosition), userInfo: nil, repeats: true)
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
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    @objc func stopAnimating() {
        self.imageView.layer.removeAllAnimations()
    }
    
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            //HighScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.imageView.layoutIfNeeded()
                self.imageView.subviews.forEach({$0.layer.removeAllAnimations()})
                self.imageView.layer.removeAllAnimations()
            }
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                //replay function
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
}
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)

        }
        
    }
}
