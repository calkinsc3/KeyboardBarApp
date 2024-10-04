import SwiftUI

struct SecondTestView: View {
    @State private var inputText: String = ""
    @State private var value: Double? = nil

    var body: some View {
        VStack {
            TextField("Enter a number", text: $inputText)
                .keyboardType(.numberPad) // Use the number pad (no decimal point)
                .onChange(of: inputText) { newValue in
                    // Ensure only numeric input
                    let filtered = newValue.filter { "0123456789".contains($0) }

                    if let number = Double(filtered) {
                        self.value = number / 100 // Convert to cents
                        self.inputText = filtered // Update text field with filtered input
                    } else {
                        self.inputText = "" // Reset if invalid input
                        self.value = nil
                    }
                }
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if let value = value {
                Text("Entered value: \(String(format: "%.2f", value))")
            } else {
                Text("Please enter a valid number")
            }
        }
        .padding()
        .onTapGesture {
          UIApplication.shared.hideKeyboard()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
