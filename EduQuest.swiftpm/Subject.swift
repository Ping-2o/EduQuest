//
//  Subject.swift
//  EduQuest
//
//  Created by Yedil on 18.02.2025.
//


import SwiftUI

struct Subject: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
    let color: Color
    let background: String?

    static let allSubjects: [Subject] = [
        Subject(name: "Math", iconName: "plusminus", color: .blue, background: "mathBackground"),
        Subject(name: "History", iconName: "book", color: .brown, background: "historyBackground"),
        Subject(name: "Physics", iconName: "atom", color: .purple, background: "physicsBackground"),
        Subject(name: "Astronomy", iconName: "globe.americas.fill", color: .yellow, background: "astronomyBackground"),
        Subject(name: "Chemistry", iconName: "flask", color: .green, background: "chemistryBackground")
    ]
}
