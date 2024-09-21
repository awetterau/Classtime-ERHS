//
//  firstTimeView.swift
//  ClassTime
//
//  Created by August Wetterau on 10/21/21.
//

import SwiftUI

struct FirstTimeView: View {
    @AppStorage("isFirstTime") private var isFirstTime = true
    @AppStorage("name") private var name = ""
    @AppStorage("lunchOdd") private var firstLunchOdd = true
    @AppStorage("lunchEven") private var firstLunchEven = true
    
    private let backgroundColor = Color(hex: 0x121212)
    private let cardColor = Color(hex: 0x212121)
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 20) {
                nameInputCard
                lunchSelectionCard(title: "Odd day lunch", isFirstLunch: $firstLunchEven)
                lunchSelectionCard(title: "Even day lunch", isFirstLunch: $firstLunchOdd)
                
                Spacer()
                
                saveButton
                
                Spacer()
            }
            .frame(height: 2 * (UIScreen.main.bounds.height / 3))
        }
    }
    
    private var nameInputCard: some View {
        CardView {
            VStack {
                Text("Please Enter Your Name:")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                TextField("Enter Your Name Here", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
    
    private func lunchSelectionCard(title: String, isFirstLunch: Binding<Bool>) -> some View {
        CardView {
            VStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.vertical)
                
                HStack(spacing: 0) {
                    lunchButton(title: "First", isSelected: isFirstLunch.wrappedValue) {
                        isFirstLunch.wrappedValue = true
                    }
                    lunchButton(title: "Second", isSelected: !isFirstLunch.wrappedValue) {
                        isFirstLunch.wrappedValue = false
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }
    
    private func lunchButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            ZStack {
                if isSelected {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 127, height: 32)
                } else {
                    Rectangle()
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(width: 126, height: 31)
                }
                Text(title)
                    .foregroundColor(.white)
                    .font(.callout)
            }
        }
    }
    
    private var saveButton: some View {
        Button(action: {
            isFirstTime = false
        }) {
            Text("Save")
                .foregroundColor(.black)
                .frame(width: 130, height: 40)
                .background(Color.white)
                .cornerRadius(10)
        }
    }
}

struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color(hex: 0x212121)
                .cornerRadius(20)
            content
        }
        .padding()
    }
}

extension Color {
    init(hex: Int, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct FirstTimeView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTimeView()
    }
}
