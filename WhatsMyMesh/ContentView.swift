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
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
