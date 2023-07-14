//
//  AddRecipeView.swift
//  Recipe List App
//
//  Created by tom montgomery on 7/11/23.
//

import SwiftUI

struct AddRecipeView: View {
    // Reference the core date RECIPE class extension to confirm all the fields, type and optional-ness
    //MARK: FORM CREATION 101
    // 1) declare all your state properties.  every textfield entry needs to be bound to state
    
    // instantiate everything to emptry string
    @State private var name = ""
    @State private var summary = ""
    @State private var prepTime = ""
    @State private var cookTime = ""
    @State private var totalTime = ""
    // OK to instantiate as string.  we can still save as an Int
    @State private var servings = ""
    
    // List type recipe metadata
    @State private var highlights = [String]()
    @State private var directions = [String]()
    
    
    var body: some View {
        
        VStack {
            
            // HStack with form controls at the top
            HStack {
                Button("Clear") {
                    // Clear the form
                }
                Spacer()
                Button("Add") {
                    // Save to core data
                    
                    // then clear the form
                }
            }
            // The entry form - the recipe meta data
            ScrollView {
                VStack{
                    
                    // Collect the recipe meta data
                    AddMetaData(name: $name,
                                summary: $summary,
                                prepTime: $prepTime,
                                cookTime: $cookTime,
                                totalTime: $totalTime,
                                servings: $servings)
                    
                    // List data
                    AddListData(list: $highlights, title: "Highlights", placeholderText: "Vegetarian")
                    
                    AddListData(list: $directions, title: "Directions", placeholderText: "mix all ingedients well")
                }
            }
            
        }
        .padding()
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
