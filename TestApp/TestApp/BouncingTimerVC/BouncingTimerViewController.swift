//
//  BouncingTimerViewController.swift
//  TestApp
//
//  Created by Stanislav Tereshchenko on 26.04.2024.
//

import UIKit

class BouncingTimerViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var animatedBtnImage: UIImageView!
    @IBOutlet weak var startTimerButton: UIView!
    
    var timer: Timer?
    var seconds = 0
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimatedButton()
        setupTimerLabel()
        setupGradientBackground()
    }
    
    func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupTimerLabel() {
        timerLabel.text = "00:00:00"
        timerLabel.textColor = .white
        timerLabel.font = UIFont(name: "Gilroy-Black", size: 50)
    }
    
    func setupAnimatedButton() {
        startTimerButton.layer.borderColor = UIColor.white.cgColor
        startTimerButton.layer.borderWidth = 2
        startTimerButton.layer.cornerRadius = startTimerButton.bounds.size.height / 2
        animatedBtnImage.image = UIImage(systemName: "play")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        setMeldPulseAnimation(to: startTimerButton)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(startTimerButtonTapped(_:)))
        startTimerButton.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    @objc func startTimerButtonTapped(_ sender: Any) {
        if isTimerRunning {
            pauseTimer()
        } else {
            startTimer()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        animatedBtnImage.image = UIImage(systemName: "pause")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        seconds = 0
        removePulseAnimation(from: startTimerButton)
        setMeldPulseAnimation(to: timerLabel)
        updateTimerLabel()
    }
    
    func pauseTimer() {
        timer?.invalidate()
        isTimerRunning = false
        animatedBtnImage.image = UIImage(systemName: "play")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        removePulseAnimation(from: timerLabel)
        setMeldPulseAnimation(to: startTimerButton)
        seconds = 0
        updateTimerLabel()
    }
    
    @objc func updateTimer() {
        seconds += 1
        updateTimerLabel()
    }
    
    func updateTimerLabel() {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func removePulseAnimation(from view: UIView) {
        view.layer.removeAnimation(forKey: "pulse")
    }
    
    func setMeldPulseAnimation(to: UIView){
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 0.7
        pulseAnimation.toValue = 0.95
        pulseAnimation.fromValue = 0.79
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.infinity
        to.layer.add(pulseAnimation, forKey: "pulse")
    }
    
}
