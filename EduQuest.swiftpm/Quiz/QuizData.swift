//
//  QuizData.swift
//  EduQuest
//
//  Created by Yedil on 18.02.2025.
//

import Foundation

struct QuizData: Codable {
    let questions: [QuizQuestion]
}

struct QuizQuestion: Codable {
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int
}

class LocalDataManager {
    static func loadQuizData(from fileName: String) -> QuizData? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("File \(fileName).json not found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let quizData = try JSONDecoder().decode(QuizData.self, from: data)
            return quizData
        } catch {
            print("Error loading data: \(error)")
            return nil
        }
    }
}
