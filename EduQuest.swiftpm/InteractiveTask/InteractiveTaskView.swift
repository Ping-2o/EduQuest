//
//  InteractiveTaskView.swift
//  EduQuest
//
//  Created by Yedil on 18.02.2025.
//

import SwiftUI

struct InteractiveTaskView: View {
    let subject: Subject
    
    @State private var mathResult: String? = nil
    @State private var timelineValue: Double = 0.5
    @State private var showStarInfo: Bool = false
    @State private var selectedReaction: Int = 1

    var body: some View {
        VStack(spacing: 20) {
            Text("Interactive task for \(subject.name)")
                .font(.title)
                .padding()
            
            interactiveDescription
                .font(.title2)
                .padding()
            
            interactiveContent
                .padding()
            
            Spacer()
        }
        .navigationTitle("Interactive tasks")
        .padding()
    }
    
    var interactiveDescription: Text {
        switch subject.name {
        case "Math":
            return Text("Use the interactive calculator to solve problems.")
        case "History":
            return Text("Follow the important historical events on the timeline.")
        case "Physics":
            return Text("Adjust the parameters.")
        case "Astronomy":
            return Text("Explore information about the nearest star (other than the Sun).")
        case "Chemistry":
            return Text("")
        default:
            return Text("No interactive task available for this subject.")
        }
    }
    
    @ViewBuilder
    var interactiveContent: some View {
        switch subject.name {
        case "Math":
            InteractiveCalculator()
        case "History":
            VStack(spacing: 10) {
                Text("Drag the slider to view the timeline.")
                    .font(.headline)
                Slider(value: $timelineValue, in: 0...1)
                Text(timelineDescription(for: timelineValue))
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(.top, 5)
                    .animation(.easeInOut, value: timelineValue)
                Image(imageName(for: timelineValue))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding(.top, 10)
                Text("Designed by Freepik")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        case "Physics":
            PhysicsInteractiveView()
        case "Astronomy":
            VStack(spacing: 10) {
                Text("Tap the button to get information about the nearest star.")
                    .font(.headline)
                Button(action: {
                    showStarInfo = true
                }) {
                    Text("Show Star")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(subject.color.opacity(0.2))
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showStarInfo) {
                    StarInfoView()
                }
            }
        case "Chemistry":
            VStack(spacing: 10) {
                Text("Choose the correct reaction from the options below:")
                    .font(.headline)
                Picker("Select reagent", selection: $selectedReaction) {
                    Text("H₂O").tag(1)
                    Text("CO₂").tag(2)
                    Text("O₂").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                Text(chemistryFeedback(for: selectedReaction))
                    .font(.subheadline)
                    .foregroundColor(.purple)
                    .padding(.top, 5)
                    .animation(.easeInOut, value: selectedReaction)
            }
        default:
            Text("No interactive task available for this subject.")
        }
    }
        
    func timelineDescription(for value: Double) -> String {
        if value < 0.2 {
            return "Primitive society-40-35 million years BC. e. - 4 thousand BC. e."
        } else if value < 0.4 {
            return "The ancient world is the end of 4 thousand BC. e. - 476 g. e."
        } else if value < 0.6 {
            return "Middle Ages-476-XV-XVII centuries."
        } else if value < 0.8 {
            return "New time-XV-XVII centuries. - 1914"
        } else {
            return "The latest time - 1914 - to the present day"
        }
    }
    
    func imageName(for value: Double) -> String {
        if value < 0.2 {
            return "prehistoric"
        } else if value < 0.4 {
            return "ancient"
        } else if value < 0.6 {
            return "medieval"
        } else if value < 0.8 {
            return "modern"
        } else {
            return "contemporary"
        }
    }
    
    func chemistryFeedback(for selection: Int) -> String {
        if selection == 3 {
            return "Right! The reaction is completed successfully."
        } else {
            return "Wrong. Try again."
        }
    }
}

struct PhysicsInteractiveView: View {
    @State private var mass: Double = 5.0
    @State private var speed: Double = 10.0
    @State private var volume: Double = 5.0
    @State private var kineticEnergy: Double = 0.5 * 5.0 * pow(10.0, 2)
    
    enum PhysicsVariable { case none, mass, speed, kineticEnergy }
    @State private var lastChanged: PhysicsVariable = .none
    @State private var showInfoAlert: Bool = false
    @State private var infoAlertMessage: String = ""
    var density: Double {
        volume > 0 ? mass / volume : 0
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                HStack(spacing: 4) {
                    Text("E").font(.headline)
                    Text("=").font(.headline)
                    Text("½").font(.headline)
                    Text("×").font(.headline)
                    Button(action: {
                        infoAlertMessage = "Mass is the amount of substance, measured in kilograms (kg)."
                        showInfoAlert = true
                    }) {
                        Text("m").underline()
                    }
                    Text("×").font(.headline)
                    Button(action: {
                        infoAlertMessage = "Speed ​​- a measure of speed of movement, measured in m/s. The construction is shown here."
                        showInfoAlert = true
                    }) {
                        Text("v²").underline()
                    }
                }
                HStack(spacing: 4) {
                    Text("ρ").font(.headline)
                    Text("=").font(.headline)
                    Button(action: {
                        infoAlertMessage = "Mass is the amount of substance, measured in kilograms (kg)."
                        showInfoAlert = true
                    }) {
                        Text("m").underline()
                    }
                    Text("÷").font(.headline)
                    Button(action: {
                        infoAlertMessage = "The volume - the space occupied by the body is measured in cubic meters (m³)."
                        showInfoAlert = true
                    }) {
                        Text("V").underline()
                    }
                }
            }
            
            VStack(spacing: 5) {
                Text(String(format: "Density: %.2f kg/m³", density))
            }
            
            VStack(spacing: 15) {
                VStack(alignment: .leading) {
                    Text(String(format: "Mass: %.2f kg", mass))
                    Slider(value: $mass, in: 1...10, step: 0.1)
                        .onChange(of: mass) { newValue in
                            lastChanged = .mass
                            recalcKineticEnergy()
                        }
                }
                VStack(alignment: .leading) {
                    Text(String(format: "Speed: %.2f m/s", speed))
                    Slider(value: $speed, in: 1...20, step: 0.1)
                        .onChange(of: speed) { newValue in
                            lastChanged = .speed
                            recalcKineticEnergy()
                        }
                }
                VStack(alignment: .leading) {
                    Text(String(format: "Kinetic energy: %.2f J", kineticEnergy))
                    Slider(value: $kineticEnergy, in: 0.5...2000, step: 1)
                        .onChange(of: kineticEnergy) { newValue in
                            lastChanged = .kineticEnergy
                            recalcSpeedFromKE()
                        }
                }
                VStack(alignment: .leading) {
                    Text(String(format: "Volume: %.2f m³", volume))
                    Slider(value: $volume, in: 1...10, step: 0.1)
                }
            }
            .padding()
        }
        .alert(isPresented: $showInfoAlert) {
            Alert(title: Text("Information"), message: Text(infoAlertMessage), dismissButton: .default(Text("ОК")))
        }
    }
    
    private func recalcKineticEnergy() {
        let newKE = 0.5 * mass * pow(speed, 2)
        if lastChanged != .kineticEnergy {
            kineticEnergy = newKE
        }
    }
    
    private func recalcSpeedFromKE() {
        guard mass > 0 else { return }
        let newSpeed = sqrt((2 * kineticEnergy) / mass)
        if abs(newSpeed - speed) > 0.01 {
            speed = newSpeed
        }
    }
}

struct InteractiveCalculator: View {
    @State private var firstNumber: String = ""
    @State private var secondNumber: String = ""
    @State private var selectedOperator: String = "+"
    @State private var result: String? = nil
    
    let operators = ["+", "-", "*", "/"]
    
    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 10) {
                TextField("Number 1", text: $firstNumber)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                Picker("", selection: $selectedOperator) {
                    ForEach(operators, id: \.self) { op in
                        Text(op).tag(op)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 120)
                TextField("Number 2", text: $secondNumber)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Button(action: computeResult) {
                Text("Calculate")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            if let result = result {
                Text("Result: \(result)")
                    .font(.headline)
                    .padding()
                    .transition(.opacity)
            }
        }
    }
    
    func computeResult() {
        guard let num1 = Double(firstNumber),
              let num2 = Double(secondNumber) else {
            result = "Invalid input"
            return
        }
        
        var calcResult: Double = 0.0
        
        switch selectedOperator {
        case "+":
            calcResult = num1 + num2
        case "-":
            calcResult = num1 - num2
        case "*":
            calcResult = num1 * num2
        case "/":
            if num2 != 0 {
                calcResult = num1 / num2
            } else {
                result = "Cannot be divided into 0"
                return
            }
        default:
            break
        }
        
        result = String(format: "%.2f", calcResult)
    }
}

struct StarInfoView: View {
    @Environment(\ .dismiss) var dismiss
    var body: some View {
        VStack(spacing: 20) {
            Text("Information about the star")
                .font(.title)
            Text("Title: Proxima Centaur\nDistance: 4.24 light years\nTemperature: 3042 K")
                .multilineTextAlignment(.center)
                .padding()
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(10)
            Button(action: {
                dismiss()
            }) {
                Text("Закрыть")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

