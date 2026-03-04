//
//  ContentView.swift
//  WhatsMyMesh
//
//  Created by Nathan on 3/3/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingMeshSheet = false
    @State private var selectedEmotion: String = "Peaceful"
    @State private var selectedGemstone: String = "Amethyst"

    private let emotions = ["Peaceful", "Excited", "Anxious", "Aggressive", "Curious", "Embarassed", "Grief", "Sleepy", "Overwhelmed", "Jealous"]

    private let gemstones = ["Garnet", "Amethyst", "Aquamarine", "Diamond", "Emerald", "Pearl", "Ruby", "Peridot", "Sapphire", "Topaz"]

    var foundationManager = FoundationManager()

    var body: some View {
        NavigationStack {
            Form {
                // Hero gemstone visual
                Section {
                    HStack {
                        Spacer()
                        SkeletonGemstoneView()
                            .frame(width: 120, height: 144)
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                }

                Section("Gemstone") {
                    Picker("Type", selection: $selectedGemstone) {
                        ForEach(gemstones, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section("Mood") {
                    Picker("Emotion", selection: $selectedEmotion) {
                        ForEach(emotions, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    Button {
                        Task {
                            try await foundationManager.createMeshAndFindSong(for: selectedGemstone)
                            try await foundationManager.generatePoem(emotion: selectedEmotion, gemstone: selectedGemstone)
                            try await foundationManager.playSong()
                        }
                        isShowingMeshSheet = true
                    } label: {
                        Text("Make My Gemstone")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("Gemstone Lapidary")
        }
        .task {
            await foundationManager.requestMusicAuthorization()
        }
        .sheet(isPresented: $isShowingMeshSheet) {
            foundationManager.hexcodes = []
            foundationManager.currentSong = nil
            foundationManager.stopSong()
            foundationManager.poem = nil
            foundationManager.stopSong()
        } content: {
            MeshGradientView(hexAsColor: foundationManager.hexAsColor, meshManager: foundationManager)
        }
    }
}

#Preview {
    ContentView()
}
