//
//  8ballViewController.swift
//  8ball
//
//  Created by Craig Belinfante on 6/27/21.
//

import UIKit


class _ballViewController: UIViewController {
    
    @IBOutlet weak var magicBall: UIImageView!
    @IBOutlet weak var tapOrShakeLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    
    var fortune = "Tap or Shake for an Answer"
    var answers = [ "It is certain", "It is decidedly so", "Without a doubt", "Yes definitely", "You may rely on it", "As I see it, yes", "Most likely", "Outlook good", "Yes", "Signs point to yes", "Try again", "Ask again later", "Better not tell you now", "Cannot predict", "Concentrate and ask again", "Don't count on it", "No", "My sources say no", "Very doubtful"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupShakeLabelTap()
        setupAnswersLabelTap()
        setupMagicBallImageTap()
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake {
            let results = answers.randomElement()!
            answersLabel.text = results
            animate(answersLabel)
        }
        magicBall.shake(duration: 1)
        answersLabel.shake(duration: 2)
        tapOrShakeLabel.text = "Ask Again"
    }
    
    private func setupViews() {
        tapOrShakeLabel.text = fortune
    }
    
    @objc func actionTapped(_ sender: UITapGestureRecognizer) {
        let results = answers.randomElement()!
        answersLabel.text = results
        animate(answersLabel)
        magicBall.shake(duration: 1)
        answersLabel.shake(duration: 2)
        
        tapOrShakeLabel.text = "Ask Again"
    }//
    
    @objc func animate(_ sender: UILabel) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.25, y: 1.05)
        }) { (_) in
            sender.transform = .identity
        }
    }//
    
    private func setupShakeLabelTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.actionTapped(_:)))
        self.tapOrShakeLabel.isUserInteractionEnabled = true
        self.tapOrShakeLabel.addGestureRecognizer(labelTap)
    }//
    
    private func setupAnswersLabelTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.actionTapped(_:)))
        self.answersLabel.isUserInteractionEnabled = true
        self.answersLabel.addGestureRecognizer(labelTap)
    }//
    
    private func setupMagicBallImageTap() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.actionTapped(_:)))
        self.magicBall.isUserInteractionEnabled = true
        self.magicBall.addGestureRecognizer(imageTap)
    }//
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
}

// MARK: 8 Ball Animation

extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"
 /*
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        // rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
 */
    func shake(duration: CFTimeInterval) {
        let shakeValues = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
        
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: .linear)
        translation.values = shakeValues
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = shakeValues.map { (Int(Double.pi) * $0) / 180 }
        
        let shakeGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = 1.0
        layer.add(shakeGroup, forKey: "shakeIt")
    }
    
}
