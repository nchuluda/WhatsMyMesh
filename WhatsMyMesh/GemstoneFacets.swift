//
//  GemstoneFacets.swift
//  WhatsMyMesh
//

import SwiftUI

/// Internal facet lines that simulate the cuts of a gemstone.
/// Designed to overlay on top of GemstoneShape.
struct GemstoneFacets: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height

        // Outer vertices (matching GemstoneShape exactly)
        let top          = CGPoint(x: w * 0.5,  y: 0)
        let upperRight   = CGPoint(x: w * 0.75, y: h * 0.08)
        let rightUpper   = CGPoint(x: w * 0.92, y: h * 0.25)
        let rightWide    = CGPoint(x: w,         y: h * 0.45)
        let rightLower   = CGPoint(x: w * 0.88, y: h * 0.65)
        let lowerRight   = CGPoint(x: w * 0.7,  y: h * 0.82)
        let bottom       = CGPoint(x: w * 0.5,  y: h)
        let lowerLeft    = CGPoint(x: w * 0.3,  y: h * 0.82)
        let leftLower    = CGPoint(x: w * 0.12, y: h * 0.65)
        let leftWide     = CGPoint(x: 0,         y: h * 0.45)
        let leftUpper    = CGPoint(x: w * 0.08, y: h * 0.25)
        let upperLeft    = CGPoint(x: w * 0.25, y: h * 0.08)

        // Interior points
        // Table (flat top facet) - a horizontal band across the crown
        let tableLeft    = CGPoint(x: w * 0.3,  y: h * 0.18)
        let tableRight   = CGPoint(x: w * 0.7,  y: h * 0.18)

        // Girdle - the widest horizontal band separating crown from pavilion
        let girdleLeft   = CGPoint(x: w * 0.08, y: h * 0.44)
        let girdleRight  = CGPoint(x: w * 0.92, y: h * 0.44)

        // Center point of the table
        let tableCenter  = CGPoint(x: w * 0.5,  y: h * 0.18)

        var path = Path()

        // --- Table edge (horizontal line across the crown) ---
        path.move(to: tableLeft)
        path.addLine(to: tableRight)

        // --- Girdle line (horizontal band at the widest point) ---
        path.move(to: leftWide)
        path.addLine(to: rightWide)

        // --- Crown facets: lines from top point down to table corners ---
        // Top to table left
        path.move(to: top)
        path.addLine(to: tableLeft)

        // Top to table right
        path.move(to: top)
        path.addLine(to: tableRight)

        // --- Crown side facets: table corners to shoulder vertices ---
        // Table left to upper left shoulder
        path.move(to: tableLeft)
        path.addLine(to: upperLeft)

        // Table right to upper right shoulder
        path.move(to: tableRight)
        path.addLine(to: upperRight)

        // --- Crown to girdle: table corners down to girdle ---
        path.move(to: tableLeft)
        path.addLine(to: leftWide)

        path.move(to: tableRight)
        path.addLine(to: rightWide)

        // --- Crown side facets: shoulders to girdle ---
        path.move(to: upperLeft)
        path.addLine(to: leftUpper)

        path.move(to: upperRight)
        path.addLine(to: rightUpper)

        path.move(to: leftUpper)
        path.addLine(to: leftWide)

        path.move(to: rightUpper)
        path.addLine(to: rightWide)

        // --- Pavilion facets: lines from bottom point up to girdle-level vertices ---
        path.move(to: bottom)
        path.addLine(to: leftWide)

        path.move(to: bottom)
        path.addLine(to: rightWide)

        path.move(to: bottom)
        path.addLine(to: leftLower)

        path.move(to: bottom)
        path.addLine(to: rightLower)

        // --- Pavilion cross facets: girdle vertices to lower vertices ---
        path.move(to: leftWide)
        path.addLine(to: lowerLeft)

        path.move(to: rightWide)
        path.addLine(to: lowerRight)

        // --- Center vertical line through the pavilion ---
        path.move(to: tableCenter)
        path.addLine(to: bottom)

        return path
    }
}

#Preview {
    ZStack {
        Color.black
        ZStack {
            GemstoneShape()
                .fill(.blue.gradient)
            GemstoneFacets()
                .stroke(.white.opacity(0.5), lineWidth: 1)
            GemstoneShape()
                .stroke(.white.opacity(0.6), lineWidth: 2)
        }
        .frame(width: 300, height: 360)
    }
    .ignoresSafeArea()
}
