//
//  AboutView.swift
//  Bullseye
//
//  Created by Simanta Deb Turja on 27/7/20.
//  Copyright © 2020 Simanta. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    let peach = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    struct AboutHeadingViewStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .foregroundColor(Color.black)
                .padding(.top, 20)
                .padding(.bottom, 20)
        }
    }
    struct AboutTextViewStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .foregroundColor(Color.black)
                .padding(.leading, 60)
                .padding(.trailing, 20)
                .padding(.bottom, 20)
        }
    }
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯").modifier(AboutHeadingViewStyle())
                Text("This is bullseye, the game where you can win points and earn fame by draggin a slider.").modifier(AboutTextViewStyle())
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.")
                    .modifier(AboutTextViewStyle())
                    .lineLimit(2)
                Text("Enjoy!").modifier(AboutTextViewStyle())
            }
            .navigationBarTitle("🎯 BullsEye 🎯")
            .background(peach)
        }
    .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
