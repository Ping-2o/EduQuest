import SwiftUI

struct QuizView: View {
    let subject: Subject
    struct Question {
        let text: String
        let answers: [String]
        let correctAnswerIndex: Int
    }
    
    var questions: [Question] {
        switch subject.name {
        case "Math":
            return [
                Question(
                    text: "What is 2 + 2?",
                    answers: ["3", "4", "5"],
                    correctAnswerIndex: 1
                ),
                Question(
                    text: "What is the area of a square with a side length of 2?",
                    answers: ["4", "2", "8"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "What is 10 ÷ 2?",
                    answers: ["3", "5", "10"],
                    correctAnswerIndex: 1
                ),
                Question(
                    text: "What is the perimeter of a rectangle with sides 3 and 4?",
                    answers: ["7", "12", "14"],
                    correctAnswerIndex: 2
                ),
                Question(
                    text: "What is the value of 3²?",
                    answers: ["6", "9", "12"],
                    correctAnswerIndex: 1
                )
            ]        
        case "History":
            return [
                Question(
                    text: "In what year did World War II begin?",
                    answers: ["1939", "1914", "1945"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "Who was the first President of the United States?",
                    answers: ["George Washington", "Abraham Lincoln", "Thomas Jefferson"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "What was the name of the ship that sank after hitting an iceberg in 1912?",
                    answers: ["Titanic", "Lusitania", "Bismarck"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "Which ancient civilization built the pyramids?",
                    answers: ["Romans", "Greeks", "Egyptians"],
                    correctAnswerIndex: 2
                ),
                Question(
                    text: "What was the Cold War primarily about?",
                    answers: ["A conflict over nuclear weapons", "A political and ideological struggle between the USA and USSR", "A battle in Antarctica"],
                    correctAnswerIndex: 1
                )
            ]        
        case "Physics":
            return [
                Question(
                    text: "What is the force that attracts objects to the Earth called?",
                    answers: ["Magnetic", "Gravity", "Electrostatic"],
                    correctAnswerIndex: 1
                ),
                Question(
                    text: "What device is used to measure temperature?",
                    answers: ["Barometer", "Thermometer", "Hygrometer"],
                    correctAnswerIndex: 1
                ),
                Question(
                    text: "What is the unit of electrical resistance?",
                    answers: ["Ohm", "Watt", "Ampere"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "What does Einstein's famous equation E = mc² describe?",
                    answers: ["Theory of Relativity", "Mass-energy equivalence", "Quantum Mechanics"],
                    correctAnswerIndex: 1
                ),
                Question(
                    text: "What is the speed of light in a vacuum (approx.)?",
                    answers: ["300,000 km/s", "150,000 km/s", "450,000 km/s"],
                    correctAnswerIndex: 0
                )
            ]
        case "Astronomy":
            return [
                Question(
                    text: "Which planet is the largest in the Solar System?",
                    answers: ["Jupiter", "Saturn", "Earth"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "Which star is closest to Earth?",
                    answers: ["Proxima Centauri", "Sirius", "The Sun"],
                    correctAnswerIndex: 2
                ),
                Question(
                    text: "What is the name of the galaxy that contains our Solar System?",
                    answers: ["Andromeda", "Milky Way", "Triangulum"],
                    correctAnswerIndex: 1
                ),
                Question(
                    text: "Which planet is known as the Red Planet?",
                    answers: ["Venus", "Mars", "Mercury"],
                    correctAnswerIndex: 1
                ),
                Question(
                    text: "What celestial body has a gravitational pull so strong that even light cannot escape?",
                    answers: ["Neutron Star", "Black Hole", "White Dwarf"],
                    correctAnswerIndex: 1
                )
            ]        
        case "Chemistry":
            return [
                Question(
                    text: "Which element is represented by the symbol O?",
                    answers: ["Oxygen", "Hydrogen", "Nitrogen"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "What is the process of turning gas into liquid called?",
                    answers: ["Evaporation", "Condensation", "Sublimation"],
                    correctAnswerIndex: 1
                ),
                Question(
                    text: "What is the chemical formula for water?",
                    answers: ["H2O", "CO2", "O2"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "Which subatomic particle carries a positive charge?",
                    answers: ["Proton", "Electron", "Neutron"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "What is the pH value of pure water?",
                    answers: ["7", "5", "9"],
                    correctAnswerIndex: 0
                )
            ]        
        default:
            return []
        }
    }
    
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var showResult = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if questions.isEmpty {
                Text("No available questions for subject \(subject.name).")
                    .font(.title2)
                    .padding()
            } else if showResult {
                VStack {
                    Text("Quiz Completed!")
                        .font(.title)
                        .padding(.bottom, 20)
                    
                    Text("Your score: \(score) out of \(questions.count)")
                        .font(.headline)
                    
                    Button(action: {
                        currentQuestionIndex = 0
                        score = 0
                        showResult = false
                    }) {
                        Text("Restart Quiz")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                .padding()
            } else {
                Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                    .font(.headline)
                
                Text(questions[currentQuestionIndex].text)
                    .font(.title2)
                    .padding(.vertical, 5)
                
                ForEach(0..<questions[currentQuestionIndex].answers.count, id: \ .self) { index in
                    Button(action: {
                        if index == questions[currentQuestionIndex].correctAnswerIndex {
                            score += 1
                        }
                        if currentQuestionIndex < questions.count - 1 {
                            currentQuestionIndex += 1
                        } else {
                            showResult = true
                        }
                    }) {
                        Text(questions[currentQuestionIndex].answers[index])
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Quiz on \(subject.name)")
    }
}

