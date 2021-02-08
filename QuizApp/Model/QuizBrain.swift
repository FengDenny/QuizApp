//
//  QuizBrain.swift
//  QuizApp
//
//  Created by Denny Feng on 2/7/21. All Rights Reserved.
//

import Foundation

struct QuizBrain {
    
    var questions: [Question] = [
      FlashCardQuestion(q: "Structs are Value Types"),
      TrueOrFalseQuestion(q: "Classes are Reference Types", a: true),
      TrueOrFalseQuestion(q: "Auto layout constraints get created automatically", a: false),
      TrueOrFalseQuestion(q: "Android is better than IOS", a: false),
      TrueOrFalseQuestion(q: "JS is the worst", a: false),
      FreeTextQuestion(q: "Dogs are cats" , a: "False"),
      FreeTextQuestion(q: "IOS is better than Andriod" , a: "True"),
     FreeTextQuestion(q: "Struct are Value Types" , a: "True")
  
    ]

    
    var currentIndex: Int = 0
    var score: Int = 0
    
// MARK: Get text from the questions array
// start in postion 0 of the array
    func getQuestionText() -> String {
        let userQuestion = questions[currentIndex].question
        return userQuestion
    }
    
// MARK: Initialized Next Question
    
   mutating func advanceIndex() {
        
        if currentIndex + 1 < questions.count
        {
            currentIndex += 1
            
        }else{
            questions.shuffle()
            currentIndex = 0;
            score = 0;
        }
    }
    
    mutating func checkAnswer(_ userAnswer: Bool) -> Bool {
        let question: Question = questions[currentIndex]
        switch question {
        case let trueOrFalseQuestion as TrueOrFalseQuestion:
            let isSelectionCorrect = trueOrFalseQuestion.isTrue
        
            if(userAnswer == isSelectionCorrect){
                score += 1
                return true
            }else {
                return false
            }
        case is FlashCardQuestion:
            ()
            return true
        default:
            print("Could not cast to existing type")
          return false
        }

    }
    
    mutating func checkTextFieldAnswer(_ userAnswer:String) -> Bool {
        let question: Question = questions[currentIndex]
        switch question {
        case let freeTextQuestion as FreeTextQuestion:
            let isSelectionCorrect = freeTextQuestion.answer
            
            if(userAnswer == isSelectionCorrect)
            {
                score += 1
                return true
            }else{
                return false
            }
        default:
            print("Could not cast to existing type")
          return false
        }
    }
    

    func getScore() -> Int{
        return score
    }


}

