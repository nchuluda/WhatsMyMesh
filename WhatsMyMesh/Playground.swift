//
//  Playground.swift
//  WhatsMyMesh
//
//  Created by Nicholas Gordon on 3/3/26.
//

import FoundationModels
import Playgrounds

#Playground {
    
    let instructions = """
        You are a design expert in colors. Always generate as hexcodes
        """
    
    let session = LanguageModelSession(instructions: instructions)
    
    let prompt = Prompt {
       """
       Generate 9 colors to use in a mesh gradient
       """
    }
    
    let response = try await session.respond(to: prompt)
}
