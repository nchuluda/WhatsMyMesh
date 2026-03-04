//
//  ContentView.swift
//  WhatsMyMesh
//
//  Created by Nathan on 3/3/26.
//

import SwiftUI

struct ContentView: View {
    @State var isShowingMeshSheet = false
    @State private var selectedEmotion: String = "Peaceful"
    @State private var selectedGemstone: String = "Amethyst"
    
    private var emotions = ["Peaceful", "Excited", "Anxious", "Aggressive", "Curious", "Embarassed", "Grief", "Sleepy", "Overwhelmed", "Jealous"]
    
    private var gemstones = ["Garnet", "Amethyst", "Aquamarine", "Diamond", "Emerald", "Pearl", "Ruby", "Peridot", "Sapphire", "Topaz"]
    
    var foundationManager = FoundationManager()
    
    var body: some View {
        VStack {
            Text("Gemstone Lapidary")
                .font(.largeTitle)
            HStack {
                Text("Selected Gemstone:")
                Picker(selection: $selectedGemstone, label: Text("Select Gemstone")) {
                    ForEach(gemstones, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
            }
            
            HStack {
                Text("Selected Emotion:")
                Picker(selection: $selectedEmotion, label: Text("Select Emotion")) {
                    ForEach(emotions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
            }
            
            Button("Make My Gemstone") {
                Task {
                    try await foundationManager.createRandomMesh(for: selectedEmotion)
                  
                }
                isShowingMeshSheet = true
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .padding()
        }
        .sheet(isPresented: $isShowingMeshSheet) {
            // onDismiss
            foundationManager.hexcodes = []
        } content: {
            MeshGradientView(hexAsColor: foundationManager.hexAsColor, meshManager: foundationManager)
        }
    }
}

#Preview {
    ContentView()
}
