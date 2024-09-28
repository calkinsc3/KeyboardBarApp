//
//  ContentView.swift
//  KeyboardBarApp
//
//  Created by Bill Calkins on 9/28/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberInput: String = ""
    @State private var stringInput: String = ""
    @State private var isKeyboardVisible: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            TextField("Enter a number", text: $numberInput)
                .keyboardType(.numberPad)
                .padding()
                .textFieldStyle(.roundedBorder)
            TextField("Enter a string", text: $stringInput)
                .keyboardType(.default)
                .padding()
                .textFieldStyle(.roundedBorder)
            Text("Keyboard height: \(keyboardHeight)")
                .font(.caption)
            Text("Keyboard is \(isKeyboardVisible ? "visible" : "hidden")")
            Spacer()
            if isKeyboardVisible {
                KeyboardBarView() {
                    print("Completion called")
                }
                .transition(.move(edge: .bottom)) // Transition effect
            }
        }
        .padding()
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                withAnimation {
                    self.isKeyboardVisible = true
                    self.keyboardHeight = keyboardFrame.height
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
            withAnimation {
                self.isKeyboardVisible = false
                self.keyboardHeight = 0
            }
        }
    }
}

struct KeyboardBarView: View {
    var successfulCompletion: () -> Void
    var body: some View {
        HStack {
            Spacer()
            VStack (alignment: .trailing) {
                Button {
                    print("Clicked Me!")
                    UIApplication.shared.hideKeyboard()
                    successfulCompletion()
                } label: {
                    Label("Search", systemImage: "magnifyingglass.circle")
                }
                .padding()
                .cornerRadius(8) // Optional: To match the corner radius of the overlay
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                )
            }
        }
        .frame(height: 38)
        .padding()
        .cornerRadius(8) // Optional: To match the corner radius of the overlay
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.blue, lineWidth: 1)
        )
        
    }
}

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ContentView()
}

#Preview {
    KeyboardBarView() {
        print("Successfully Completed")
    }
}
