//
//  Questions.swift
//  QuizApp
//
//  Created by Denny Feng on 2/7/21. All Rights Reserved.
//

import Foundation

protocol Question {
    var question: String {get};
   
}

struct FlashCardQuestion: Question {
    let question: String;
    init(q:String ){
        question = q;
      
    }
}

struct TrueOrFalseQuestion: Question {
    let question: String;
    let isTrue:Bool
        
    init(q:String, a: Bool){
        question = q;
        isTrue = a;
    }
}

struct FreeTextQuestion: Question {
    let question: String;
    let answer:String
    
    init(q:String, a:String){
        question = q;
        answer = a;
    }
    
}

