//
//  ContentView.swift
//  WhatsMyMesh
//
//  Created by Nathan on 3/3/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedEmotion: String? = "Peaceful"
    private var emotions = ["Peaceful", "Excited", "Anxious", "Aggressive", "Curious", "Embarassed", "Grief", "Sleepy", "Overwhelmed", "Jealous"]
    
    @State var isShowingMeshSheet = false
    
    var meshManager = MeshManager()
    
    var body: some View {
        VStack {
            if meshManager.isLoading {
                ProgressView()
            }
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
                    try await meshManager.createRandomMesh()
                  
                }
                isShowingMeshSheet = true
            }
            .buttonStyle(.bordered)
            .tint(.green)
            .padding()
        }
        .sheet(isPresented: $isShowingMeshSheet) {
            meshManager.hexcodes = []
        } content: {
            MeshGradientView(hexAsColor: meshManager.hexAsColor, meshManager: meshManager)
        }
        

    }
}

#Preview {
    ContentView()
}
