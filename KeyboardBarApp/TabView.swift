//
//  TabView.swift
//  KeyboardBarApp
//
//  Created by Bill Calkins on 10/3/24.
//

import SwiftUI

enum Tabs: Equatable, Hashable {
  case getSetTab
  case chatGPTTab
  case combineTab
  case mediumTab
  
}

struct KeyboardTabView: View {
  @State var tabSelection: Tabs = .getSetTab
  
    var body: some View {
      TabView(selection: $tabSelection) {
        ContentView()
          .tabItem {
            Label("Home", systemImage: "house.fill")
          }
          .tag(Tabs.getSetTab)

        SecondTestView()
          .tabItem {
            Label("ChatGPT", systemImage: "message.badge.waveform.fill")
          }
          .tag(Tabs.chatGPTTab)

        CombineView()
          .tabItem {
            Label("Combine", systemImage: "scroll.fill")
          }
          .tag(Tabs.combineTab)
        
        MediumTry()
          .tabItem {
            Label("Medium", systemImage: "book.fill")
          }
          .tag(Tabs.mediumTab)
      }
    }
}

#Preview {
  KeyboardTabView()
}
