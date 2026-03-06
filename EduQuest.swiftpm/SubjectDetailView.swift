//
//  QuizData.swift
//  EduQuest
//
//  Created by Yedil on 18.02.2025.
//

import SwiftUI

struct SubjectDetailView: View {
    let subject: Subject

    var subjectImageName: String {
        switch subject.name {
        case "Math": return "mathImage"
        case "History": return "historyImage"
        case "Physics": return "physicsImage"
        case "Astronomy": return "astronomyImage"
        case "Chemistry": return "chemistryImage"
        default: return "defaultSubjectImage"
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Welcome to the section \(subject.name)!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(subject.color)
                    .padding(.horizontal)
                
                Image(subjectImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Text("Designed by Freepik")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                
                HStack(spacing: 10) {
                    NavigationLink(destination: QuizView(subject: subject)) {
                        Text("Quiz")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(subject.color.opacity(0.2))
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: TextQuestView(subject: subject)) {
                        Text("Text Quest")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(subject.color.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                HStack(spacing: 10) {
                    NavigationLink(destination: PuzzleView(subject: subject)) {
                        Text("Puzzle")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(subject.color.opacity(0.2))
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: InteractiveTaskView(subject: subject)) {
                        Text("Interactive Task")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(subject.color.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
        .navigationTitle(subject.name)
    }
}
