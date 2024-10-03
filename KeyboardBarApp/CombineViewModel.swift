//
//  ContentViewModel.swift
//  KeyboardBarApp
//
//  Created by Bill Calkins on 10/3/24.
//

import Foundation
import Combine

final class CombineViewModel: ObservableObject {
  @Published var combineNumberInput: String = ""
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    $combineNumberInput
      .dropFirst()
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .sink {
        if $0.count < 6 {
          print("combineInput: \($0)")
        }
      }
      .store(in: &cancellables)
  }
  
  
  
}
