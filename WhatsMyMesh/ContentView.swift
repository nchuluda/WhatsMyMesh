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
    
    var meshManager = MeshManager()
    
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
                    try await meshManager.createMeshAndFindSong(for: selectedEmotion)
                    try await meshManager.playSong()
                }
                isShowingMeshSheet = true
            }
            .buttonStyle(.bordered)
            .tint(.green)
            .padding()
        }
        .task {
            await meshManager.requestMusicAuthorization()
        }
        .sheet(isPresented: $isShowingMeshSheet) {
            // onDismiss
            meshManager.hexcodes = []
            meshManager.currentSong = nil
            meshManager.stopSong()
        } content: {
            MeshGradientView(hexAsColor: meshManager.hexAsColor, meshManager: meshManager)
        }
    }
}

#Preview {
    ContentView()
}
