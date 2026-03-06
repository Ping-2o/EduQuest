//
//  PuzzleView.swift
//  EduQuest
//
//  Created by Yedil on 18.02.2025.
//

import SwiftUI

struct PuzzlePiece: Identifiable {
    let id = UUID()
    var label: String
    var offset: CGSize = .zero
}

struct DraggablePiece: View {
    @Binding var piece: PuzzlePiece
    @GestureState private var dragOffset: CGSize = .zero

    var body: some View {
        Text(piece.label)
            .font(.headline)
            .foregroundColor(.black)
            .padding(15)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.2)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 1)
            )
            .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 2, y: 2)
            .offset(x: piece.offset.width + dragOffset.width,
                    y: piece.offset.height + dragOffset.height)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        piece.offset.width += value.translation.width
                        piece.offset.height += value.translation.height
                    }
            )
    }
}

struct PuzzleView: View {
    let subject: Subject
    @State private var puzzleStarted: Bool = false
    @State private var pieces: [PuzzlePiece]
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    init(subject: Subject) {
        self.subject = subject
        _pieces = State(initialValue: PuzzleView.initialPieces(for: subject))
    }
    
    static func initialPieces(for subject: Subject) -> [PuzzlePiece] {
        switch subject.name {
        case "Math":
            return [
                PuzzlePiece(label: "3"),
                PuzzlePiece(label: "+"),
                PuzzlePiece(label: "2"),
                PuzzlePiece(label: "="),
                PuzzlePiece(label: "5")
            ]
        case "History":
            return [
                PuzzlePiece(label: "1914"),
                PuzzlePiece(label: "Start"),
                PuzzlePiece(label: "1939"),
                PuzzlePiece(label: "End"),
                PuzzlePiece(label: "1945")
            ]
        case "Physics":
            return [
                PuzzlePiece(label: "F"),
                PuzzlePiece(label: "="),
                PuzzlePiece(label: "m"),
                PuzzlePiece(label: "×"),
                PuzzlePiece(label: "a")
            ]
        case "Astronomy":
            return [
                PuzzlePiece(label: "Mercury"),
                PuzzlePiece(label: "Venus"),
                PuzzlePiece(label: "Earth"),
                PuzzlePiece(label: "Mars")
            ]
        case "Chemistry":
            return [
                PuzzlePiece(label: "H₂"),
                PuzzlePiece(label: "+"),
                PuzzlePiece(label: "O₂"),
                PuzzlePiece(label: "→"),
                PuzzlePiece(label: "H₂O")
            ]
        default:
            return []
        }
    }
    
    static func initialCorrectOrder(for subject: Subject) -> [String] {
        switch subject.name {
        case "Math":
            return ["3", "+", "2", "=", "5"]
        case "History":
            return ["Start", "1914", "1939", "1945", "End"]
        case "Physics":
            return ["F", "=", "m", "×", "a"]
        case "Astronomy":
            return ["Mercury", "Venus", "Earth", "Mars"]
        case "Chemistry":
            return ["H₂", "+", "O₂", "→", "H₂O"]
        default:
            return []
        }
    }
    
    var puzzleDescription: String {
        switch subject.name {
        case "Math":
            return "Arrange the blocks to form a correct equation. Note: The first number should be greater than the second."
        case "History":
            return "Arrange the events in chronological order."
        case "Physics":
            return "Assemble Newton's law formula."
        case "Astronomy":
            return "Order the planets by their distance from the Sun."
        case "Chemistry":
            return "Construct the correct chemical reaction."
        default:
            return "No puzzle available for this subject."
        }
    }
    
    func checkSolution() {
        let sortedPieces = pieces.sorted { $0.offset.width < $1.offset.width }
        let arrangedLabels = sortedPieces.map { $0.label }
        let correctOrder = Self.initialCorrectOrder(for: subject)
        
        if arrangedLabels == correctOrder {
            alertMessage = "Congratulations! You solved the puzzle correctly."
        } else {
            alertMessage = "The arrangement of blocks is incorrect. Try again."
        }
        showAlert = true
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Puzzle for \(subject.name)")
                .font(.title)
                .padding()
            
            if !puzzleStarted {
                Text(puzzleDescription)
                    .font(.title2)
                    .padding()
                
                Button(action: {
                    withAnimation {
                        puzzleStarted = true
                    }
                }) {
                    Text("Start Puzzle")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(subject.color.opacity(0.2))
                        .cornerRadius(10)
                }
            } else {
                Text("Drag and arrange the blocks to complete the task.")
                    .font(.headline)
                    .padding()
                
                ZStack {
                    ForEach($pieces) { $piece in
                        DraggablePiece(piece: $piece)
                    }
                }
                .frame(width: 300, height: 400)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .border(Color.blue, width: 2)
                
                Button(action: {
                    checkSolution()
                }) {
                    Text("Check Solution")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(10)
                }
                .padding(.top)
            }
            
            Spacer()
        }
        .navigationTitle("Puzzles")
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage))
        }
    }
}

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PuzzleView(subject: Subject.allSubjects[0])
        }
    }
}
