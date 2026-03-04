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
    
    private var emotions = ["Peaceful", "Excited", "Anxious", "Aggressive", "Curious", "Embarassed", "Grief", "Sleepy", "Overwhelmed", "Jealous"]
    
    var foundationManager = FoundationManager()
    
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
            
            Button("Create Mesh") {
                Task {
                    try await foundationManager.createRandomMesh(for: selectedEmotion)
                  
                }
                isShowingMeshSheet = true
            }
            .buttonStyle(.bordered)
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
