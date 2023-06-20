//
//  RecipeHighlights.swift
//  Recipe List App
//
//  Created by tom montgomery on 11/23/22.
//

import SwiftUI

struct RecipeHighlights: View {
    
    var allHighlights = ""
    
    // pass in a var called highlights which is an array of strings
    init(highlights: [String]) {
        // Loop through the Highlights array and build the string
        for index in 0..<highlights.count {
            
            // If it's the last item, don't add a comma
            if index == highlights.count - 1 {
                allHighlights += highlights[index]
            }
            else {
                allHighlights += highlights[index] + ", "
            }
        }
    }
    
    
    
    var body: some View {
        Text(allHighlights)
    }
}

struct RecipeHighlights_Previews: PreviewProvider {
    static var previews: some View {
        // in order to QA / Preview, gotta pass it some data
        RecipeHighlights(highlights: ["test1","test2"])
    }
}
