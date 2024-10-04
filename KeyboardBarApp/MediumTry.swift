//
//  MediumTry.swift
//  KeyboardBarApp
//
//  Created by Bill Calkins on 10/3/24.
// https://medium.com/@jpmtech/swiftui-format-currency-the-easy-way-ec6c604ca299

// https://medium.com/@21zerixpm/input-currency-format-on-a-uitextfield-35a04bd719c

import SwiftUI

struct MediumTry: View {
  @State var amount: Decimal = 0.0
  
  var body: some View {
    VStack {
      // Default the currency to match the users locale,
      // or fall back to a certain if we can't figure out the locale
      Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
      // Displays "$0.00"
      
      // We can ensure our text to only ever display a certain type
      // of currency by using the following line (instead of the one above)
      Text(amount, format: .currency(code: "GBP"))
      // Displays ￡0.00 (no matter what locale you have choosen)
      
      // Accepting a number as input to a text field
      //TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
      TextField("Amount", value: $amount, format: .number.precision(.fractionLength(2)))
        .keyboardType(.decimalPad)
    }
    .padding()
  }
}

#Preview {
  MediumTry()
}
