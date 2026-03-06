//
//  ContentView.swift
//  EduQuest
//
//  Created by Yedil on 18.02.2025.
//

import SwiftUI

struct ContentView: View {
    let subjects = Subject.allSubjects

    var body: some View {
        NavigationView {
            List(subjects) { subject in
                NavigationLink(destination: SubjectDetailView(subject: subject)) {
                    HStack(spacing: 15) {
                        Image(systemName: subject.iconName)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(subject.color)
                        
                        Text(subject.name)
                            .font(.headline)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("EduQuest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
