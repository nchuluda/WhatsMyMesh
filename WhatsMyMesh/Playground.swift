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
        You are a design expert in colors. Please generate a list of hexcodes as strings. I do not want the hashtag included before each color. Each color should ONLY BE 6. Do not number the results or include any conversation in your response.
        ** NEVER INCLUDE # **
        """
    
    let session = LanguageModelSession(instructions: instructions)
    
    let prompt = Prompt {
        "Generate 9 colors to use in a mesh gradient"
    }
    
    let response = try await session.respond(to: prompt)
}


@Generable
struct ColorPalette {
//    @Guide(description: "Hexcodes as strings.")
    var hexCodes: [String]
}
