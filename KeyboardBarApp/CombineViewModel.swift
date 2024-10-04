//
//  ContentViewModel.swift
//  KeyboardBarApp
//
//  Created by Bill Calkins on 10/3/24.
//

import Foundation
import Combine

final class CombineViewModel: ObservableObject {
  @Published var inputText: String = ""
  
  private var cancellables = Set<AnyCancellable>()
  
  // Publisher that formats the input to always show two decimal places
  var formattedTextPublisher: AnyPublisher<String, Never> {
    $inputText
      .map { value in
//        let numbersOnly = value.justDigits
//        return String(format: "%.2f", numbersOnly)
        let number = Double(value) ?? 0.0
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: number)) ?? ""
      }
      .eraseToAnyPublisher()
  }
  
  init() {
    formattedTextPublisher
      .receive(on: RunLoop.main)
      .assign(to: &$inputText)
  }
}
