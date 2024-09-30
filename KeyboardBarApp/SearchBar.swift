//
//  SearchBar.swift
//  KeyboardBarApp
//
//  Created by Bill Calkins on 9/30/24.
//

import SwiftUI

struct SearchButtonView: View {
    var onSearchButtonPress: () -> Void

    var body: some View {
        HStack {
            Spacer() // Flexible space
            
            Button(action: {
                // Trigger search button action
                onSearchButtonPress()
            }) {
                HStack(spacing: 8) { // Padding between text and icon
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.system(size: 16, weight: .bold)) // Image style
                    Text("Search")
                        .font(.system(size: 18, weight: .bold)) // Text style
                }
            }
            .buttonStyle(.borderedProminent) // Tinted button style
            .tint(Color.blue) // Set the tint color
        }
        .padding(.horizontal) // Add horizontal padding
        .frame(height: 48) // Set the toolbar height
        .background(Color(UIColor.systemBackground)) // Background color to match UIKit toolbar
    }
}

#Preview {
  SearchButtonView() {
    
  }
}
