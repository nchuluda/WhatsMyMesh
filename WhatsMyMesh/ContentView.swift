//
//  ContentView.swift
//  WhatsMyMesh
//
//  Created by Nathan on 3/3/26.
//

//
//  ContentView.swift
//  MeshGradientExample
//
//  Created by Nicholas Gordon on 3/3/26.
//

import SwiftUI


struct ContentView: View {
    @State private var selectedEmotion: String? = "Peaceful"
    private var emotions = ["Peaceful", "Excited", "Anxious", "Aggressive", "Curious", "Embarassed", "Grief", "Sleepy", "Overwhelmed", "Jealous"]
    
    var body: some View {
        VStack {
            HStack {
                Text("Selected Emotion:")
                Picker(selection: $selectedEmotion, label: Text("Select Emotion")) {
                    ForEach(emotions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}


extension Color {
  init(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)
    let a, r, g, b: UInt64
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (1, 1, 1, 0)
    }

    self.init(
      .sRGB,
      red: Double(r) / 255,
      green: Double(g) / 255,
      blue:  Double(b) / 255,
      opacity: Double(a) / 255
    )
  }
}
