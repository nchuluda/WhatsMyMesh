//
//  SkeletonGemstoneView.swift
//  WhatsMyMesh
//

import SwiftUI

/// A shimmer-animated skeleton gemstone shown during loading.
struct SkeletonGemstoneView: View {
    @State private var shimmerOffset: CGFloat = -1

    var body: some View {
        ZStack {
            // Base skeleton fill
            GemstoneShape()
                .fill(Color.gray.opacity(0.25))

            // Shimmer sweep across the gem
            GemstoneShape()
                .fill(
                    LinearGradient(
                        colors: [
                            .clear,
                            .white.opacity(0.15),
                            .white.opacity(0.3),
                            .white.opacity(0.15),
                            .clear
                        ],
                        startPoint: UnitPoint(x: shimmerOffset - 0.3, y: 0.5),
                        endPoint: UnitPoint(x: shimmerOffset + 0.3, y: 0.5)
                    )
                )

            // Faded facet lines
            GemstoneFacets()
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)

            // Faded outline
            GemstoneShape()
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
        }
        .aspectRatio(5/6, contentMode: .fit)
        .padding()
        .onAppear {
            withAnimation(
                .easeInOut(duration: 1.5)
                .repeatForever(autoreverses: false)
            ) {
                shimmerOffset = 2
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black
        SkeletonGemstoneView()
    }
    .ignoresSafeArea()
}
