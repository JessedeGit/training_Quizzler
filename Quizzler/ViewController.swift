//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import PKHUD

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    let allQuestions = QuestionBank()
    var pickedAnswer = false
    var currentQuestionNo = 0
    var currentScore = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var answerbutton2: UIButton!
    @IBOutlet weak var answerButton1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstQuesiton = allQuestions.list[0]
        questionLabel.text = firstQuesiton.questionText
        
        progressLabel.text = "1/13"
        var frm = progressBar.frame
        frm.size.width = CGFloat(28 * (currentQuestionNo + 1))
        progressBar.frame = frm
        scoreLabel.text = "Score: 0"
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else {
            pickedAnswer = false
        }
        
        updateUI()
        if !nextQuestion(){
            
            let alert = UIAlertController(title: "Awsome!", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
  
    }
    
    func updateUI() {
        
        if checkAnswer(){
            currentScore += 1
        }
        scoreLabel.text = "Score: \(currentScore)"

    }
    
    func nextQuestion()-> Bool {
        currentQuestionNo += 1
        if currentQuestionNo > 12 {
            return false
        }
        questionLabel.text = allQuestions.list[currentQuestionNo].questionText
        progressLabel.text = "\(currentQuestionNo + 1)/13"
        var frm = progressBar.frame
        frm.size.width = CGFloat(28 * (currentQuestionNo + 1))
        progressBar.frame = frm
        return true
    }
    
    func checkAnswer()->Bool {
        
        var res = false
        if pickedAnswer == allQuestions.list[currentQuestionNo].answer {
            res = true
        }
        if res == true {
            HUD.flash(.success, delay: 0.02)
        }
        else {
            HUD.flash(.error, delay: 0.02)
        }

        return res
    }
    
    func startOver() {
        currentScore = 0
        currentQuestionNo = 0
        questionLabel.text = allQuestions.list[currentQuestionNo].questionText
        progressLabel.text = "\(currentQuestionNo + 1)/13"
        scoreLabel.text = "Score: \(currentScore)"
        var frm = progressBar.frame
        frm.size.width = CGFloat(28 * (currentQuestionNo + 1))
        progressBar.frame = frm
    }
    
}
