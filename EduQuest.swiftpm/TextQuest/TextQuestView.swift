//
//  TextQuestView.swift
//  EduQuest
//
//  Created by Yedil on 18.02.2025.
//

import SwiftUI

struct MessageBubble: View {
    let text: String
    var body: some View {
        Text(text)
            .padding(10)
            .background(Color.blue.opacity(0.2))
            .cornerRadius(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
}

struct TypingIndicator: View {
    @State private var dot1Opacity: Double = 0.3
    @State private var dot2Opacity: Double = 0.3
    @State private var dot3Opacity: Double = 0.3

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(.gray)
                .opacity(dot1Opacity)
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(.gray)
                .opacity(dot2Opacity)
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(.gray)
                .opacity(dot3Opacity)
        }
        .padding(10)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                dot1Opacity = 1.0
            }
            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.2)) {
                dot2Opacity = 1.0
            }
            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.4)) {
                dot3Opacity = 1.0
            }
        }
    }
}

struct InlineTypingIndicator: View {
    @State private var dot1Opacity: Double = 0.3
    @State private var dot2Opacity: Double = 0.3
    @State private var dot3Opacity: Double = 0.3

    var body: some View {
        HStack(spacing: 3) {
            Circle()
                .frame(width: 6, height: 6)
                .foregroundColor(.gray)
                .opacity(dot1Opacity)
            Circle()
                .frame(width: 6, height: 6)
                .foregroundColor(.gray)
                .opacity(dot2Opacity)
            Circle()
                .frame(width: 6, height: 6)
                .foregroundColor(.gray)
                .opacity(dot3Opacity)
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                dot1Opacity = 1.0
            }
            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.2)) {
                dot2Opacity = 1.0
            }
            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.4)) {
                dot3Opacity = 1.0
            }
        }
    }
}

struct QuestStep: Identifiable {
    let id = UUID()
    let text: String
    let options: [QuestOption]
}

struct QuestOption: Identifiable {
    let id = UUID()
    let text: String
    let nextStep: Int?
}

struct TextQuestView: View {
    let subject: Subject
    @State private var conversation: [String] = []
    @State private var typingMessage: String = ""
    @State private var isTyping: Bool = false
    @State private var currentStepIndex: Int = 0
    
    var questSteps: [QuestStep] {
        switch subject.name {
        case "Math":
            return [
                QuestStep(
                    text: "Welcome to the world of numbers! Before you is a locked door. To open it, solve this equation: 2 + 2 = ?",
                    options: [
                        QuestOption(text: "Answer 4", nextStep: 1),
                        QuestOption(text: "Answer 5", nextStep: 2)
                    ]
                ),
                QuestStep(
                    text: "Correct! The door opens, and you step into a mysterious hall. On the wall, another equation is carved: 5 × 3 = ?",
                    options: [
                        QuestOption(text: "Answer 15", nextStep: 3),
                        QuestOption(text: "Answer 12", nextStep: 2)
                    ]
                ),
                QuestStep(
                    text: "Incorrect. The door remains closed. Try again.",
                    options: [
                        QuestOption(text: "Try again", nextStep: 0)
                    ]
                ),
                QuestStep(
                    text: "Excellent! In the center of the hall, a glowing cube appears with an inscription: 'To proceed, solve this equation: x + 7 = 10. Find x'.",
                    options: [
                        QuestOption(text: "Answer 3", nextStep: 4),
                        QuestOption(text: "Answer 5", nextStep: 2)
                    ]
                ),
                QuestStep(
                    text: "You are correct! The cube disappears, revealing a new corridor. At the end, your final challenge awaits: 144 ÷ 12 = ?",
                    options: [
                        QuestOption(text: "Answer 12", nextStep: 5),
                        QuestOption(text: "Answer 10", nextStep: 2)
                    ]
                ),
                QuestStep(
                    text: "Congratulations! You have successfully completed the math quest! At the end of the room, a treasure chest filled with the riches of knowledge awaits you!",
                    options: [
                        QuestOption(text: "Start again", nextStep: 0)
                    ]
                )
            ]
        case "History":
            return [
                QuestStep(
                    text: "You have arrived in an ancient city buried beneath the sands. Time seems to have stopped, and the streets are deserted. You must find clues to uncover the mystery of this lost civilization.",
                    options: [
                        QuestOption(text: "Search the ruins", nextStep: 1),
                        QuestOption(text: "Examine the town square", nextStep: 2)
                    ]
                ),
                QuestStep(
                    text: "In the ruins, you find an old parchment with strange symbols. Nearby, there is an engraving of a temple. Could this be a clue?",
                    options: [
                        QuestOption(text: "Head to the temple", nextStep: 3),
                        QuestOption(text: "Try to decipher the text", nextStep: 4)
                    ]
                ),
                QuestStep(
                    text: "In the town square, you see a mysterious obelisk covered in inscriptions. As you touch it, you feel a faint vibration.",
                    options: [
                        QuestOption(text: "Read the inscriptions", nextStep: 4),
                        QuestOption(text: "Search for other clues", nextStep: 1)
                    ]
                ),
                QuestStep(
                    text: "You enter the temple. Darkness fills the room, but strange patterns can be seen on the floor. In the center, a stone altar with a mechanism stands before you.",
                    options: [
                        QuestOption(text: "Examine the mechanism", nextStep: 5),
                        QuestOption(text: "Study the patterns", nextStep: 6)
                    ]
                ),
                QuestStep(
                    text: "After much effort, you manage to decipher the text. It is a map of the city! It marks the location of a hidden ancient relic.",
                    options: [
                        QuestOption(text: "Follow the map", nextStep: 7)
                    ]
                ),
                QuestStep(
                    text: "The mechanism is a puzzle. You must arrange the symbols correctly. One wrong move, and the floor starts to shake!",
                    options: [
                        QuestOption(text: "Keep solving the puzzle", nextStep: 8),
                        QuestOption(text: "Step back", nextStep: 3)
                    ]
                ),
                QuestStep(
                    text: "The patterns on the floor form an ancient calendar. It reveals important dates, but what do they mean?",
                    options: [
                        QuestOption(text: "Compare with the parchment", nextStep: 4),
                        QuestOption(text: "Ignore and go back", nextStep: 3)
                    ]
                ),
                QuestStep(
                    text: "Following the map, you discover a hidden underground passage. It leads to an ancient chamber where your final challenge awaits.",
                    options: [
                        QuestOption(text: "Enter the chamber", nextStep: 9)
                    ]
                ),
                QuestStep(
                    text: "You solve the puzzle correctly, and the mechanism activates! A hidden door in the wall swings open.",
                    options: [
                        QuestOption(text: "Enter the secret hall", nextStep: 9)
                    ]
                ),
                QuestStep(
                    text: "You find yourself in the Hall of Time. Before you are three artifacts: a glowing stone, an ancient clock, and a golden mask.",
                    options: [
                        QuestOption(text: "Take the glowing stone", nextStep: 10),
                        QuestOption(text: "Examine the ancient clock", nextStep: 11),
                        QuestOption(text: "Put on the golden mask", nextStep: 12)
                    ]
                ),
                QuestStep(
                    text: "As soon as you take the stone, the space around you warps, revealing the past of this city. You become the guardian of its secrets.",
                    options: [
                        QuestOption(text: "Finish the quest", nextStep: nil)
                    ]
                ),
                QuestStep(
                    text: "The clock starts ticking backward, and suddenly, you find yourself in the golden age of this ancient civilization! You now have a chance to change history.",
                    options: [
                        QuestOption(text: "Finish the quest", nextStep: nil)
                    ]
                ),
                QuestStep(
                    text: "As you put on the mask, the spirit of the city's ruler appears before you. He thanks you for your discovery and grants you ancient wisdom.",
                    options: [
                        QuestOption(text: "Finish the quest", nextStep: nil)
                    ]
                )
            ]
        case "Physics":
            return [
                QuestStep(
                    text: "Welcome to the laboratory of natural laws! Here, you can conduct experiments and uncover the mysteries of physics. To begin, find an experimental device for testing acceleration.",
                    options: [
                        QuestOption(text: "Examine the table with instruments", nextStep: 1),
                        QuestOption(text: "Search in the equipment cabinet", nextStep: 2)
                    ]
                ),
                QuestStep(
                    text: "You find a strange metallic sphere on a stand. Nearby, there are scales and a stopwatch. Could this be part of an experiment?",
                    options: [
                        QuestOption(text: "Examine the device", nextStep: 3),
                        QuestOption(text: "Keep searching", nextStep: 2)
                    ]
                ),
                QuestStep(
                    text: "In the cabinet, you find old books on mechanics. Among them is a blueprint of a device that measures the acceleration of falling objects.",
                    options: [
                        QuestOption(text: "Carefully study the blueprint", nextStep: 4),
                        QuestOption(text: "Return to the table", nextStep: 1)
                    ]
                ),
                QuestStep(
                    text: "The device is designed to measure the acceleration of free fall. You need to drop the metallic sphere from different heights and measure the fall time.",
                    options: [
                        QuestOption(text: "Start the experiment", nextStep: 5),
                        QuestOption(text: "Verify calculations", nextStep: 6)
                    ]
                ),
                QuestStep(
                    text: "You notice that the blueprint provides parameters for an ideal experiment. Everything is ready for testing!",
                    options: [
                        QuestOption(text: "Start the experiment", nextStep: 5)
                    ]
                ),
                QuestStep(
                    text: "You set the sphere at different heights and record the fall time. It turns out that the acceleration is the same for all heights!",
                    options: [
                        QuestOption(text: "Analyze the results", nextStep: 7)
                    ]
                ),
                QuestStep(
                    text: "You compare the data with the free-fall formula: g = 9.8 m/s². Everything matches! Newton’s law is confirmed once again.",
                    options: [
                        QuestOption(text: "Complete the experiment", nextStep: nil)
                    ]
                )
            ]
        case "Astronomy":
            return [
                QuestStep(
                    text: "While observing the stars, you notice a strange constellation that is not listed in astronomers' catalogs. Could this be the discovery of the century? You need to investigate it!",
                    options: [
                        QuestOption(text: "Use the telescope", nextStep: 1),
                        QuestOption(text: "Request data from the observatory", nextStep: 2)
                    ]
                ),
                QuestStep(
                    text: "You aim the telescope at the mysterious constellation. Among the stars, you notice an object moving at an incredible speed. What could it be?",
                    options: [
                        QuestOption(text: "Analyze the object's spectrum", nextStep: 3),
                        QuestOption(text: "Try to calculate its trajectory", nextStep: 4)
                    ]
                ),
                QuestStep(
                    text: "The observatory confirms your observations. The mysterious object emits unusual radio waves resembling a signal. Could it be a message?",
                    options: [
                        QuestOption(text: "Try to decode the signal", nextStep: 5),
                        QuestOption(text: "Continue observations", nextStep: 3)
                    ]
                ),
                QuestStep(
                    text: "Spectral analysis shows that the object does not resemble any known star or planet. It emits strange radiation—perhaps a neutron star or even an artificial satellite!",
                    options: [
                        QuestOption(text: "Send a request to astronomers", nextStep: 6),
                        QuestOption(text: "Continue observations", nextStep: 4)
                    ]
                ),
                QuestStep(
                    text: "You calculate the object's trajectory and discover that it is heading toward Earth! You must urgently learn more.",
                    options: [
                        QuestOption(text: "Report to NASA", nextStep: 7),
                        QuestOption(text: "Continue observations", nextStep: 3)
                    ]
                ),
                QuestStep(
                    text: "You send a request to the world's leading astronomers. A response arrives quickly: this is an object of extraterrestrial origin!",
                    options: [
                        QuestOption(text: "Try to communicate with the object", nextStep: 8)
                    ]
                ),
                QuestStep(
                    text: "NASA confirms: this is neither an asteroid nor a comet. It appears to be a spacecraft of an unknown civilization...",
                    options: [
                        QuestOption(text: "Attempt to establish contact", nextStep: 7),
                        QuestOption(text: "Hide the information from the public", nextStep: 8)
                    ]
                ),
                QuestStep(
                    text: "You transmit a signal toward the object. A few minutes later, a response arrives! This is the first contact with an extraterrestrial civilization!",
                    options: [
                        QuestOption(text: "Study the received signal", nextStep: 9)
                    ]
                ),
                QuestStep(
                    text: "You decide to hide the information, fearing public panic. Perhaps humanity is not yet ready for this discovery...",
                    options: [
                        QuestOption(text: "Continue research in secret", nextStep: 9)
                    ]
                ),
                QuestStep(
                    text: "This incredible discovery will change the course of history! Humanity has taken its first step toward understanding the Universe. Where will this contact lead?",
                    options: [
                        QuestOption(text: "End of the quest", nextStep: nil)
                    ]
                )
            ]
        case "Chemistry":
            return [
                QuestStep(
                    text: "Welcome to the world of chemical reactions! Your goal is to obtain the mysterious substance X-42. You have several reagents.",
                    options: [
                        QuestOption(text: "Choose reagents", nextStep: 1),
                        QuestOption(text: "Study the chemistry handbook", nextStep: 2)
                    ]
                ),
                QuestStep(
                    text: "In front of you are several flasks with different substances. Which reagents will you choose?",
                    options: [
                        QuestOption(text: "Water and sodium", nextStep: 3),
                        QuestOption(text: "Acid and metal", nextStep: 4),
                        QuestOption(text: "Potassium permanganate and glycerin", nextStep: 5)
                    ]
                ),
                QuestStep(
                    text: "You open the chemistry handbook and find information about possible reactions. This may help you choose the correct reagents.",
                    options: [
                        QuestOption(text: "Return to choosing reagents", nextStep: 1)
                    ]
                ),
                QuestStep(
                    text: "You add sodium to water... Boom! The reaction is too violent, and the flask cracks! Try something else.",
                    options: [
                        QuestOption(text: "Try again", nextStep: 1)
                    ]
                ),
                QuestStep(
                    text: "Acid and metal react, releasing gas. Interesting, but this is not substance X-42.",
                    options: [
                        QuestOption(text: "Try again", nextStep: 1)
                    ]
                ),
                QuestStep(
                    text: "You mix potassium permanganate and glycerin... After a few seconds, the mixture begins to smolder, then bursts into bright flames! You have created a self-igniting compound.",
                    options: [
                        QuestOption(text: "Investigate the substance's properties", nextStep: 6)
                    ]
                ),
                QuestStep(
                    text: "You have made an incredible discovery! The new substance could be used as an energy source. Could this be a breakthrough in science?",
                    options: [
                        QuestOption(text: "Patent the discovery", nextStep: 7),
                        QuestOption(text: "Continue experiments", nextStep: 8)
                    ]
                ),
                QuestStep(
                    text: "Your discovery has attracted the attention of the scientific community. You have become a renowned chemist!",
                    options: [
                        QuestOption(text: "End of the quest", nextStep: nil)
                    ]
                ),
                QuestStep(
                    text: "You continue experiments and discover new properties of the substance. Perhaps you are on the verge of another great discovery!",
                    options: [
                        QuestOption(text: "End of the quest", nextStep: nil)
                    ]
                )
            ]
        default:
            return [
                QuestStep(
                    text: "No text quest is available for this subject.",
                    options: []
                )
            ]
        }
    }
    func typeOutMessage(_ message: String) {
        typingMessage = ""
        isTyping = true
        let characters = Array(message)
        let typingInterval = 0.05
        for index in characters.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + (Double(index) * typingInterval)) {
                self.typingMessage.append(characters[index])
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (Double(characters.count) * typingInterval)) {
            self.conversation.append(self.typingMessage)
            self.typingMessage = ""
            self.isTyping = false
        }
    }
    
    func showCurrentStepMessage() {
        guard currentStepIndex < questSteps.count else { return }
        let fullText = questSteps[currentStepIndex].text
        typeOutMessage(fullText)
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(conversation, id: \.self) { message in
                        MessageBubble(text: message)
                    }
                    if isTyping {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(typingMessage)
                                .foregroundColor(.black)
                            InlineTypingIndicator()
                        }
                        .padding(10)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .layoutPriority(1)

            if !isTyping, currentStepIndex < questSteps.count {
                ForEach(questSteps[currentStepIndex].options) { option in
                    Button(action: {
                        self.conversation.append(option.text)
                        if let next = option.nextStep {
                            self.currentStepIndex = next
                        } else {
                            self.conversation.append("Quest completed!")
                            self.currentStepIndex = 0
                            return
                        }
                        showCurrentStepMessage()
                    }) {
                        Text(option.text)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.3))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()
        }
        .navigationTitle("Text Quest by \(subject.name)")
        .padding()
        .onAppear {
            if conversation.isEmpty {
                showCurrentStepMessage()
            }
        }
    }
}

struct TextQuestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TextQuestView(subject: Subject.allSubjects[0])
        }
    }
}
