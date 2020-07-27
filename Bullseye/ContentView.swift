//
//  ContentView.swift
//  Bullseye
//
//  Created by Simanta Deb Turja on 26/7/20.
//  Copyright © 2020 Simanta. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in:1...100)
    @State var scoreValue = 0
    @State var roundNumber = 1
    let midnightBlue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0)
    
    struct LabelStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(Color.white)
            .modifier(Shadow())
        }
    }
    
    struct ValueStyle : ViewModifier {
        func body(content : Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .foregroundColor(Color.yellow)
                .modifier(Shadow())
        }
    }
    
    struct Shadow : ViewModifier {
        func body(content : Content) -> some View {
            return content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
            
        }
    }
    struct ButtonLargeTextStyle : ViewModifier {
        func body(content : Content) -> some View {
            return content
            .font(Font.custom("Arial Rounded MT Bold", size: 16))
            .foregroundColor(Color.black)
        }
    }
    
    struct ButtonSmallTextStyle : ViewModifier {
        func body(content : Content) -> some View {
            return content
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
            .foregroundColor(Color.black)
        }
    }
    var body: some View {
        VStack{
            Spacer()
            HStack {
                Text("Put the bullseye as close as you can to: ").modifier(LabelStyle())
                Text("\(self.target)").modifier(ValueStyle())
            }
            Spacer()
            
            
            //Slider Row
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: self.$sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            
            Spacer()
            //Button Row
            Button(action : {
                print("Button Pressed")
                self.alertIsVisible = true
                
            }) {
                Text("Hit Me!").modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible) {()-> Alert in
                return Alert(title: Text("\(alertTitle())"),
                             message: Text("The slider's value is \(sliderValueRounded()).\n" +
                                "You scored \(self.pointsForCurrentRound()) in this round!"),
                             dismissButton: .default(Text("Awesome!!")) {
                                self.scoreValue = self.scoreValue + self.pointsForCurrentRound()
                                self.target = Int.random(in: 1...100)
                                self.roundNumber = self.roundNumber + 1
                    })
            }
            .background(Image("Button")).modifier(Shadow())
            Spacer()
            //Score Row
            HStack {
                Button(action: {
                    print("You pressed Start over button!")
                    self.startNewGame()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start Over").modifier(ButtonSmallTextStyle())
                    }
                    
                }
                .background(Image("Button")).modifier(Shadow())
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(scoreValue)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(roundNumber)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
            }.padding(.bottom, 25)
            .accentColor(midnightBlue)
            .navigationBarTitle("🎯 BullsEye 🎯")
        }
        .background(Image("Background"), alignment: .center)
    }
    func startNewGame() {
        scoreValue = 0
        roundNumber = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
    
    func amountOff() -> Int {
        return abs(sliderValueRounded() - target)
    }
    
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func pointsForCurrentRound()-> Int {
        let maximumScore = 100
        let difference = amountOff()
        let bonus: Int
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        return maximumScore - difference + bonus
    }
    
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        if difference == 0 {
            title = "Perfect!!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference <= 10 {
            title = "Not bad!"
        } else {
            title = "Are you even trying?"
        }
        return title
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

