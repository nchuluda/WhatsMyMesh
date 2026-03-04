//
//  MeshGradientView.swift
//  WhatsMyMesh
//
//  Created by Nicholas Gordon on 3/3/26.
//

import SwiftUI

struct MeshGradientView: View {
    var hexAsColor: [Color]
    var meshManager: FoundationManager
    
    var body: some View {
        VStack {
            if meshManager.hexAsColor.isEmpty {
                ProgressView()
            } else {
                TimelineView(.animation) { timeline in
                    let x = (sin(timeline.date.timeIntervalSince1970) + 1) / 2
                    
                    MeshGradient(width: 3, height: 3,
                        points: [
                        [0, 0], [0.5, 0], [1, 0],
                        [0, 0.5], [Float(x), 0.5], [1, 0.5],
                        [0, 1], [0.5, 1], [1, 1]
                        ],
                        colors: hexAsColor
                    )
                }
            }
        }
    }
}

#Preview {
    MeshGradientView(hexAsColor: [.red, .blue, .yellow], meshManager: FoundationManager())
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
