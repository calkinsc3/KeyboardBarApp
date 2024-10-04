//
//  CashEntryTextField.swift
//  KeyboardBarApp
//
//  Created by Bill Calkins on 10/4/24.
//

import Foundation
import SwiftUI

struct CurrencyEntryTextField: UIViewRepresentable {
  
  @Binding var text: String
  
  let keyboardType: UIKeyboardType
  let placeholder: String
  
  func makeUIView(context: UIViewRepresentableContext<CurrencyEntryTextField>) -> UITextField {
    let textField = UITextField()
    textField.delegate = context.coordinator
    textField.autocapitalizationType = .none
    textField.spellCheckingType = .no
    textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    textField.keyboardType = keyboardType
    return textField
  }
  
  func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CurrencyEntryTextField>) {
    uiView.placeholder = placeholder
    uiView.text = text
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, UITextFieldDelegate {
    var currencyEntryTextField: CurrencyEntryTextField
    let maxCharacterCount: Int = 8
    
    init(_ currencyEntryTextField: CurrencyEntryTextField) {
      self.currencyEntryTextField = currencyEntryTextField
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
      currencyEntryTextField.text = textField.text ?? ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
      print("textFieldDidEndEditing: \(textField.text ?? "")")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let currentText = textField.text ?? ""
      
      guard let stringRange = Range(range, in: currentText) else { return false }
      let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
      
      let formattedCurrency = updatedText.currencyInputFormatting()
      textField.text = formattedCurrency
      
      return false
    }
  }
}

extension Decimal {
  
  var asCurrencyString: String {
    let numberFormatter = NumberFormatter()

    numberFormatter.numberStyle = .currency
    numberFormatter.minimumFractionDigits = 2
    numberFormatter.maximumFractionDigits = 2
    numberFormatter.currencySymbol = "$"
    // Round towards the nearest integer, or away from zero if equidistant. See EC-361 for details.
    // This was chosen due to the interger rounding that is done in POS
    numberFormatter.roundingMode = .halfUp
    numberFormatter.locale = Locale(identifier: "en_US")

    return numberFormatter.string(from: self as NSNumber) ?? "?"
  }
}

extension String {
  
  // formatting text for currency textField
  func currencyInputFormatting() -> String {
    
    // remove from String: "$", ".", ","
    let justDigits = self.justDigits
    let justDigitsDecimal = Decimal(string: justDigits) ?? 0.00
    let currencyValue = justDigitsDecimal / 100
    
    return currencyValue.asCurrencyString

  }
}
