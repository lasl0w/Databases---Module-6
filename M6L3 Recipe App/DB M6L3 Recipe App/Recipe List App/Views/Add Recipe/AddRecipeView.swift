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
    
    // Ingredient Data - don't use core data version, b/c we only want to save it to core data after they hit the recipe level Add button.  Just need to keep track of it for now - use IngredientJSON
    @State private var ingredients = [IngredientJSON]()
    
    // Recipe Image - the user doesn't have to add an image if they don't want to
    @State private var recipeImage: UIImage?
    
    // Image Picker
    @State private var isShowingImagePicker = false
    @State private var selectedImageSource = UIImagePickerController.SourceType.photoLibrary
    @State private var placeHolderImage = Image("vietnamese sausage")
    
    var body: some View {
        
        VStack {
            
            // HStack with form controls at the top
            HStack {
                Button("Clear") {
                    // Clear the form
                    clear()
                }
                Spacer()
                Button("Add") {
                    // Save to core data
                    addRecipe()
                    
                    // then clear the form
                    clear()
                }
            }
            // The entry form - the recipe meta data
            ScrollView {
                VStack{
                    
                    // Recipe image
                    placeHolderImage
                    // resizable so it doesn't blow out the width and cause other elements to go offscreen
                        .resizable()
                    // scaledToFit to prevent skewing/blur.  effectively reduced height
                        .scaledToFit()
                    
                    HStack {
                        Button("Photo Library") {
                            selectedImageSource = .photoLibrary
                            isShowingImagePicker = true
                            // Photo library shows, BUT we don't just get the photo, we must handle it.....
                        }
                        Text(" | ")
                        Button("Camera") {
                            selectedImageSource = .camera
                            isShowingImagePicker = true
                        }
                    }
                    // also want to update the image in real time, onDismiss, after picking the image
                    .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                        // Now that we've added recipeImage as a binding, need to pass it through
                        ImagePicker(selectedSource: selectedImageSource, recipeImage: $recipeImage)
                    }
                    
                    
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
                    
                    // Ingredient Data
                    AddIngredientData(ingredients: $ingredients)
                }
            }
            
        }
        .padding()
    }
    
    func loadImage() {
        // Check if an image was selected from the library
        if recipeImage != nil {
            placeHolderImage = Image(uiImage: recipeImage!)
        }
        // Set it as the placeholder image
    }
    
    func clear() {
        // clear all the form fields
        name = ""
        summary = ""
        prepTime = ""
        cookTime = ""
        totalTime = ""
        highlights = [String]()
        directions = [String]()
        ingredients = [IngredientJSON]()
    }
    
    func addRecipe() {
        
        // save the recipe to core data
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
