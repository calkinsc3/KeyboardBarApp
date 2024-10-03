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
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    var body: some View {
        VStack {
            TextField("Enter a number", text: Binding(
              get: {
                return numberInput
            },
              set: { newValue in
                let justDigits = newValue.justDigits
                if justDigits.count <= 10 {
                  numberInput = newValue.asCurrencyString
                } else {
                    numberInput.removeLast()
                }
            }))
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
            Text("Number: \(numberInput)")
                .font(.caption)
            Spacer()
            if isKeyboardVisible {
                SearchButtonView {
                    print("Clicked Me!")
                    UIApplication.shared.hideKeyboard()
                    //successfulCompletion()
                }
                //.transition(.move(edge: .bottom)) // Transition effect
            }
        }
        .padding()
        .background(Color.gray.opacity(0.5))
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
                SearchButtonView {
                    print("Clicked Me!")
                    UIApplication.shared.hideKeyboard()
                    successfulCompletion()
                }
            }
        }
        .frame(height: 38)
        .padding()
        .cornerRadius(8) // Optional: To match the corner radius of the overlay
        .background(Color.gray)
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
extension String {
    var justDigits: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
  
  var asCurrencyString: String {
    let numberFormatter = NumberFormatter()

    numberFormatter.numberStyle = .currency
    numberFormatter.minimumFractionDigits = 2
    numberFormatter.maximumFractionDigits = 2
    numberFormatter.currencySymbol = "$"
    // Round towards the nearest integer, or away from zero if equidistant. See EC-361 for details.
    // This was chosen due to the interger rounding that is done in POS
    //numberFormatter.roundingMode = .halfUp
    numberFormatter.locale = Locale(identifier: "en_US")
    
    let numberValue = Double(self.justDigits) ?? 0
    return numberFormatter.string(from: numberValue as NSNumber) ?? "?"
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
