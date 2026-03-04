//
//  GemstoneFacets.swift
//  WhatsMyMesh
//

import SwiftUI

/// Internal facet lines that simulate the cuts of a gemstone.
/// Designed to overlay on top of GemstoneShape.
struct GemstoneFacets: Shape {

    /// Helper to draw a line segment
    private func line(_ path: inout Path, from a: CGPoint, to b: CGPoint) {
        path.move(to: a)
        path.addLine(to: b)
    }

    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height

        // === Outer vertices (matching GemstoneShape) ===
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

        // === Interior points ===

        // Table vertices (top facet)
        let tL   = CGPoint(x: w * 0.33, y: h * 0.14)
        let tR   = CGPoint(x: w * 0.67, y: h * 0.14)

        // Crown ring (between table and girdle)
        let cL   = CGPoint(x: w * 0.14, y: h * 0.28)
        let cCL  = CGPoint(x: w * 0.35, y: h * 0.26)
        let cC   = CGPoint(x: w * 0.50, y: h * 0.24)
        let cCR  = CGPoint(x: w * 0.65, y: h * 0.26)
        let cR   = CGPoint(x: w * 0.86, y: h * 0.28)

        // Girdle interior ring
        let gL   = CGPoint(x: w * 0.06, y: h * 0.40)
        let gCL  = CGPoint(x: w * 0.30, y: h * 0.39)
        let gC   = CGPoint(x: w * 0.50, y: h * 0.37)
        let gCR  = CGPoint(x: w * 0.70, y: h * 0.39)
        let gR   = CGPoint(x: w * 0.94, y: h * 0.40)

        // Upper pavilion ring
        let pL   = CGPoint(x: w * 0.10, y: h * 0.56)
        let pCL  = CGPoint(x: w * 0.32, y: h * 0.54)
        let pC   = CGPoint(x: w * 0.50, y: h * 0.52)
        let pCR  = CGPoint(x: w * 0.68, y: h * 0.54)
        let pR   = CGPoint(x: w * 0.90, y: h * 0.56)

        // Lower pavilion ring
        let lpL  = CGPoint(x: w * 0.22, y: h * 0.72)
        let lpC  = CGPoint(x: w * 0.50, y: h * 0.70)
        let lpR  = CGPoint(x: w * 0.78, y: h * 0.72)

        var path = Path()

        // ============================================================
        // CROWN — Top to table
        // ============================================================
        line(&path, from: top, to: tL)
        line(&path, from: top, to: tR)
        line(&path, from: tL, to: tR)

        // Table corners to shoulders
        line(&path, from: tL, to: upperLeft)
        line(&path, from: tR, to: upperRight)

        // ============================================================
        // CROWN — Table to crown ring
        // ============================================================
        line(&path, from: tL, to: cCL)
        line(&path, from: tL, to: cL)
        line(&path, from: tR, to: cCR)
        line(&path, from: tR, to: cR)

        // Crown ring connections
        line(&path, from: cL, to: cCL)
        line(&path, from: cCL, to: cCR)
        line(&path, from: cCR, to: cR)

        // Break the area between table and crown ring into triangles
        line(&path, from: tL, to: cC)
        line(&path, from: tR, to: cC)
        line(&path, from: cCL, to: cC)
        line(&path, from: cCR, to: cC)

        // Crown ring to outer shoulders
        line(&path, from: upperLeft, to: cL)
        line(&path, from: upperLeft, to: cCL)
        line(&path, from: upperRight, to: cR)
        line(&path, from: upperRight, to: cCR)

        // ============================================================
        // CROWN — Crown ring to outer edges & girdle ring
        // ============================================================
        line(&path, from: cL, to: leftUpper)
        line(&path, from: cL, to: gL)
        line(&path, from: cL, to: gCL)

        line(&path, from: cCL, to: gCL)
        line(&path, from: cCL, to: gC)
        line(&path, from: cCR, to: gC)
        line(&path, from: cCR, to: gCR)

        line(&path, from: cR, to: rightUpper)
        line(&path, from: cR, to: gR)
        line(&path, from: cR, to: gCR)

        // ============================================================
        // GIRDLE — Ring connections
        // ============================================================
        line(&path, from: gL, to: gCL)
        line(&path, from: gCL, to: gC)
        line(&path, from: gC, to: gCR)
        line(&path, from: gCR, to: gR)

        // Girdle to outer edges
        line(&path, from: leftUpper, to: gL)
        line(&path, from: rightUpper, to: gR)

        // ============================================================
        // GIRDLE — To upper pavilion ring
        // ============================================================
        line(&path, from: leftWide, to: pL)
        line(&path, from: gL, to: pL)
        line(&path, from: gCL, to: pCL)
        line(&path, from: gC, to: pCL)
        line(&path, from: gC, to: pC)
        line(&path, from: gC, to: pCR)
        line(&path, from: gCR, to: pCR)
        line(&path, from: gR, to: pR)
        line(&path, from: rightWide, to: pR)

        // ============================================================
        // PAVILION — Upper ring connections
        // ============================================================
        line(&path, from: pL, to: pCL)
        line(&path, from: pCL, to: pC)
        line(&path, from: pC, to: pCR)
        line(&path, from: pCR, to: pR)

        // Upper pavilion to outer edges
        line(&path, from: leftLower, to: pL)
        line(&path, from: rightLower, to: pR)

        // ============================================================
        // PAVILION — Upper ring to lower ring
        // ============================================================
        line(&path, from: pL, to: lpL)
        line(&path, from: pCL, to: lpL)
        line(&path, from: pCL, to: lpC)
        line(&path, from: pC, to: lpC)
        line(&path, from: pCR, to: lpC)
        line(&path, from: pCR, to: lpR)
        line(&path, from: pR, to: lpR)

        // Lower ring connections
        line(&path, from: lpL, to: lpC)
        line(&path, from: lpC, to: lpR)

        // Lower ring to outer edges
        line(&path, from: leftLower, to: lpL)
        line(&path, from: lowerLeft, to: lpL)
        line(&path, from: lowerLeft, to: lpC)
        line(&path, from: lowerRight, to: lpC)
        line(&path, from: lowerRight, to: lpR)
        line(&path, from: rightLower, to: lpR)

        // ============================================================
        // PAVILION — Lower ring to bottom point
        // ============================================================
        line(&path, from: bottom, to: lpL)
        line(&path, from: bottom, to: lpC)
        line(&path, from: bottom, to: lpR)
        line(&path, from: bottom, to: lowerLeft)
        line(&path, from: bottom, to: lowerRight)

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
