//
//  8ballViewController.swift
//  8ball
//
//  Created by Craig Belinfante on 6/27/21.
//

import UIKit

class _ballViewController: UIViewController {
    
    @IBOutlet weak var magicBall: UIImageView!
    @IBOutlet weak var answersLabel: UILabel!
    
    var fortune = "Tap for an Answer"
        var answers = [ "It is certain", "It is decidedly so", "Without a doubt", "Yes definitely", "You may rely on it", "As I see it, yes", "Most likely", "Outlook good", "Yes", "Signs point to yes", "Try again", "Ask again later", "Better not tell you now", "Cannot predict", "Concentrate and ask again", "Don't count on it", "No", "My sources say no", "Very doubtful"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupViews()
            setupLabelTap()
        }
        
        private func setupViews() {
            answersLabel.text = fortune
        }
        
        @objc func actionTapped(_ sender: UITapGestureRecognizer) {
            let results = answers.randomElement()!
            answersLabel.text = results
            animate(answersLabel)
        }
        
        @objc func animate(_ sender: UILabel) {
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform(scaleX: 1.25, y: 1.05)
            }) { (_) in
                sender.transform = .identity
            }
        }
        
        private func setupLabelTap() {
            let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.actionTapped(_:)))
            self.answersLabel.isUserInteractionEnabled = true
            self.answersLabel.addGestureRecognizer(labelTap)
        }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

