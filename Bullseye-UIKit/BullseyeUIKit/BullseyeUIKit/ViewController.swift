//
//  ViewController.swift
//  BullseyeUIKit
//
//  Created by Simanta Deb Turja on 29/7/20.
//  Copyright © 2020 Simanta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sliderValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreValueLabel: UILabel!
    @IBOutlet weak var roundValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scoreValueLabel.text = "0"
        sliderValue = Int(slider.value.rounded())
        startNewRound()
    }
    
    @IBAction func showHitMeAlert() {
        let currentScore = getScore()
        score += currentScore
        scoreValueLabel.text = String(score)
        let message = "You scored \(currentScore)"
        let alert = UIAlertController(title: getUpdatedTitle(), message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesomeee!!", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("The current value of the slider is: \(slider.value)")
        sliderValue = Int(slider.value.rounded())
    }
    
    func getUpdatedTitle() -> String {
        let titleHitMe: String
        let difference = abs(targetValue - sliderValue)
        if difference == 0 {
            titleHitMe = "Perfect! Hurray!!"
        } else if difference == 1 {
            titleHitMe = "You almost had it!"
        } else if difference <= 5 {
            titleHitMe = "Not a bad try!!"
        } else {
            titleHitMe = "Are you even trying?"
        }
        return titleHitMe
    }
    
    func startNewRound() {
        updateTargetValue()
        resetSliderValue()
        updateRound()
    }
    
    func updateRound() {
        round += 1
        roundValueLabel.text = String(round)
    }
    
    func checkBonusPoint() -> Int {
        let bonusPoint: Int
        let difference = abs(sliderValue - targetValue)
        if difference == 0 {
            bonusPoint = 100
        } else if difference == 1 {
            bonusPoint = 50
        } else {
            bonusPoint = 0
        }
        return bonusPoint
    }
    
    func updateTargetValue() {
        targetValue = Int.random(in: 1...100)
        targetLabel.text = String(targetValue)
    }
    
    func resetSliderValue() {
        sliderValue = 50
        slider.value = Float(sliderValue)
    }
    
    func getScore() -> Int {
        return 100 - abs(sliderValue - targetValue) + checkBonusPoint()
    }

}

