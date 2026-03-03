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
class MeshManager {

    private let model = SystemLanguageModel.default
    
    var isLoading = false
    
    var hexcodes:[String] = []
    
    var hexAsColor: [Color] {
        hexcodes.map{ Color(hex: $0)}
    }
    

    func createRandomMesh(for selectedEmotion: String) async throws {
        
     
        
        isLoading = true
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
        self.isLoading = false
    }
    
    
}



@Generable
struct ColorPalette {
    var hexCodes: [String]
}
