//
//  QuizViewModel.swift
//  EduQuest
//
//  Created by Yedil on 18.02.2025.
//


import SwiftUI

class QuizViewModel: ObservableObject {
    @Published var currentQuestionIndex = 0
    @Published var score = 0
    @Published var showResult = false
    
    let questions: [QuizView.Question]
    
    init(questions: [QuizView.Question]) {
        self.questions = questions
    }
    
    func answerQuestion(with index: Int) {
        let question = questions[currentQuestionIndex]
        if index == question.correctAnswerIndex {
            score += 1
        }
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            showResult = true
        }
    }
    
    func resetQuiz() {
        currentQuestionIndex = 0
        score = 0
        showResult = false
    }
}