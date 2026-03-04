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
    
    func createRandomMesh(for selectedEmotion: String) async throws {
        let instructions = """
            You are a design expert in colors. Please generate a list of hexcodes as strings. I do not want the hashtag included before each color. Each color should ONLY BE 6. Do not number the results or include any conversation in your response.
            ** NEVER INCLUDE # **
            """
        
        let session = LanguageModelSession(instructions: instructions)
        
        let prompt = Prompt {
            "Generate 9 colors to use in a mesh gradient. Choose colors I might see in an amethyst crystal."
        }
        
        let response = try await session.respond(to: prompt, generating: ColorPalette.self)
        
        hexcodes = response.content.hexCodes
        
        print(response.content.hexCodes)
    }
    
    // MARK: Generate a poem
    
    var poem: String = ""
    
    func generatePoem(emotion: String, gemstone: String) async throws {
        let instructions = """
    Write a haiku inspired by the emotion "\(emotion)" and the gemstone "\(gemstone)".
    
    Requirements:
    - 12–16 lines
    - Free verse
    - Vivid sensory imagery
    - Use the gemstone as a central metaphor
    - Do not mention instructions
    - Do not include a title
    - Do not explain the poem
    
    The poem should feel emotionally immersive and cohesive.
    """
        
        
    }
}

@Generable
struct ColorPalette {
    var hexCodes: [String]
}
