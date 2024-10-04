//
//  CombineView.swift
//  KeyboardBarApp
//
//  Created by Bill Calkins on 10/3/24.
//

import SwiftUI

struct CombineView: View {
  
  @StateObject private var viewModel = CombineViewModel()
  
  var body: some View {
    VStack {
      TextField("Enter amount", text: $viewModel.inputText)
        .keyboardType(.decimalPad)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      // Display the current formatted value
      Text("Formatted value: \(viewModel.inputText)")
    }
    .padding()
  }
}

#Preview {
  CombineView()
}
