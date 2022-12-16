//
//  ContentView.swift
//  GuessFlag
//
//  Created by GIORGI's MacPro on 14.12.22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore: Bool = false
    @State private var showTitle: String = ""
    @State private var score: Int = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    // Body Property
    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: [Color.black, Color.green, Color.yellow, Color.red, Color.black, Color.green, Color.yellow, Color.red]), center: .center)
                .ignoresSafeArea()
            
            LinearGradient(gradient: Gradient(colors: [.red, .black, .red]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess The FLAG")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                            .font(.system(.body, design: .rounded, weight: .bold))
                        Text(countries[correctAnswer])
                            .foregroundColor(.black)
                            .font(.system(.largeTitle, design: .monospaced, weight: .heavy))
                            .italic()
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .cornerRadius(40)
                                .symbolRenderingMode(.hierarchical)
    //                            .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                
                Spacer()
                Spacer()
                
                Text("SCORE:  \(score)")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.title)

            }
        }
        .alert(showTitle, isPresented: $showingScore) {
            Button("Cancel", role: .cancel) {}
            Button("Continue", action: newQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    func flagTapped (_ number: Int) {
        if correctAnswer == number {
            showTitle = "You are CORRECT"
            score += 1
        } else {
            showTitle = "You are WRONG"
        }
        
        showingScore = true
    }
    
    func newQuestion () {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
