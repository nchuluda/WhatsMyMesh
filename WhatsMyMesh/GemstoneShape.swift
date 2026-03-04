//
//  GemstoneShape.swift
//  WhatsMyMesh
//

import SwiftUI

struct GemstoneShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height

        var path = Path()

        // Top facet: a pointed crown
        path.move(to: CGPoint(x: w * 0.5, y: 0))            // top point
        path.addLine(to: CGPoint(x: w * 0.75, y: h * 0.08)) // upper right shoulder
        path.addLine(to: CGPoint(x: w * 0.92, y: h * 0.25)) // right upper angle

        // Right side facets
        path.addLine(to: CGPoint(x: w, y: h * 0.45))         // right wide point
        path.addLine(to: CGPoint(x: w * 0.88, y: h * 0.65))  // right lower angle

        // Bottom facets converging to a point
        path.addLine(to: CGPoint(x: w * 0.7, y: h * 0.82))   // lower right
        path.addLine(to: CGPoint(x: w * 0.5, y: h))           // bottom point
        path.addLine(to: CGPoint(x: w * 0.3, y: h * 0.82))   // lower left

        // Left side facets
        path.addLine(to: CGPoint(x: w * 0.12, y: h * 0.65))  // left lower angle
        path.addLine(to: CGPoint(x: 0, y: h * 0.45))          // left wide point

        path.addLine(to: CGPoint(x: w * 0.08, y: h * 0.25))  // left upper angle
        path.addLine(to: CGPoint(x: w * 0.25, y: h * 0.08))  // upper left shoulder

        path.closeSubpath()

        return path
    }
}

#Preview {
    GemstoneShape()
        .fill(.blue.gradient)
        .frame(width: 300, height: 360)
        .padding()
}
