//
//  CombineView.swift
//  KeyboardBarApp
//
//  Created by Bill Calkins on 10/3/24.
//

import SwiftUI

struct CombineView: View {
  
  @StateObject var combineViewModel = CombineViewModel()
  
  @State var numberInput: Double = 0
  
  var body: some View {
    VStack {
      TextField("Enter Numbers", value: $combineViewModel.combineNumberInput, formatter: NumberFormatter.currency)
        .keyboardType(.decimalPad)
        .padding()
        .textFieldStyle(.roundedBorder)
    }
    
  }
}

#Preview {
  CombineView()
}
