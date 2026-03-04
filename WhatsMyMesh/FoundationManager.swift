//
//  MeshManager.swift
//  WhatsMyMesh
//
//  Created by Nicholas Gordon on 3/3/26.
//

import Foundation
import FoundationModels
import SwiftUI

@Observable
class FoundationManager {
    private let model = SystemLanguageModel.default
    
    // MARK: Generate colors
    
    var hexcodes:[String] = []
    
    var hexAsColor: [Color] {
        hexcodes.map{ Color(hex: $0) }
    }
    
    func createRandomMesh(for selectedGem: String) async throws {
        let instructions = """
            You are a design expert in colors. Please generate a list of hexcodes as strings. I do not want the hashtag included before each color. Each color should ONLY BE 6. Do not number the results or include any conversation in your response.
            ** NEVER INCLUDE # **
            """
        
        let session = LanguageModelSession(instructions: instructions)
        
        let prompt = Prompt {
            "Generate 9 colors to use in a mesh gradient. Choose colors that represent a \(selectedGem)."
        }
        
        let response = try await session.respond(to: prompt, generating: ColorPalette.self)
        
        hexcodes = response.content.hexCodes
        
        print(response.content.hexCodes)
    }
    
    // MARK: Generate a poem
    
    var poem: String?
    
    func generatePoem(emotion: String, gemstone: String) async throws {
        let instructions =
            """
                Compose a traditional 5-7-5 haiku.

                Requirements:
                - Three lines only
                - 5 syllables
                - 7 syllables
                - 5 syllables
                - The gemstone must embody the emotion
                - Use vivid sensory imagery
                - No title
                - No commentary

                Output only the haiku.
                """
        
        let session = LanguageModelSession(instructions: instructions)
        
        let prompt = Prompt {
            """
                Emotion: \(emotion)
                Gemstone: \(gemstone)

                Create the haiku based on these.
                """
        }
        
        let response = try await session.respond(to: prompt)
        
        withAnimation(.easeIn(duration: 0.6)) {
            poem = response.content
        }
        
        
    }
}

@Generable
struct ColorPalette {
    var hexCodes: [String]
}
