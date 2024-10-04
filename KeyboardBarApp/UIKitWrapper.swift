//
//  UIKitWrapper.swift
//  KeyboardBarApp
//
//  Created by Bill Calkins on 10/4/24.
//

import SwiftUI

struct UIKitWrapper: View {
  
  @State var currencyText: String = ""
    var body: some View {
      VStack {
        CurrencyEntryTextField(text: $currencyText, keyboardType: .numberPad, placeholder: "Enter a Currency")
          .padding()
          .buttonBorderShape(.roundedRectangle)
        Button("Done") {
          UIApplication.shared.hideKeyboard()
        }
        Spacer()
      }
    }
}


#Preview {
    UIKitWrapper()
}
