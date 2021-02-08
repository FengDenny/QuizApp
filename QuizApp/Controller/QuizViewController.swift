//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Denny Feng on 2/7/21. All Rights Reserved.
//

import UIKit


class QuizViewController: UIViewController, UITextFieldDelegate {
    
//MARK: Labels
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    

    
//MARK: Model Initializer
var quizBrain = QuizBrain();


//MARK: Display Each Questions
func displayQuestionAtCurrentIndex() {
    
    let question = quizBrain.questions[quizBrain.currentIndex]
    questionLabel.text = question.question
        switch question {
        case is TrueOrFalseQuestion:
            trueButton.setTitle("True", for: UIControl.State.normal)
            falseButton.isHidden = false
            textField.isHidden = true
            scoreLabel.text = "Score: \(quizBrain.getScore())"
        case is FlashCardQuestion:
            trueButton.setTitle("Next", for: UIControl.State.normal)
            falseButton.isHidden = true
            textField.isHidden = true
        case is FreeTextQuestion:
            trueButton.isHidden = true
            falseButton.isHidden = true
            textField.isHidden = false
            scoreLabel.text = "Score: \(quizBrain.getScore())"
        default: ()
            
        }
    }
    

//MARK: True/False button
    @IBAction func submitClicked(_ sender: UIButton) {
    
        let userSelectedTrue  = sender.tag == 0
        let correct = quizBrain.checkAnswer(userSelectedTrue)
        
        if(!correct){
            let alert = UIAlertController(title: "Incorrect!", message: nil, preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        quizBrain.advanceIndex()
     
        // Display question at the current index
      displayQuestionAtCurrentIndex()

    }
   
//MARK: Keyboard Cutomization
    func updateTextFieldUI(){
        textField.returnKeyType = .done
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.becomeFirstResponder()
        textField.delegate = self
    }
    
//MARK: For UITextField Implentation
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//   text field must not be empty
        if let text = textField.text {
            let correct = quizBrain.checkTextFieldAnswer(text)
            // clear textField
            textField.text = nil
            if(!correct){
                let alert = UIAlertController(title: "Incorrect!", message: nil, preferredStyle: UIAlertController.Style.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
               alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            }
        }
        
        quizBrain.advanceIndex()
        
//Display question at the current index
      displayQuestionAtCurrentIndex()
        return true
    }

//MARK: Update UI
    func updateUI(){
        questionLabel.text = quizBrain.getQuestionText()
        
    }
   
// viewDidLoad is a lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateTextFieldUI()
        displayQuestionAtCurrentIndex()
    }


}



