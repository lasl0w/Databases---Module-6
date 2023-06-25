//
//  Recipe.swift
//  Recipe List App
//
//  Created by tom montgomery on 5/8/22.
//

import Foundation


// we know it needs an ID b/c it's going to be displayed in a list so just make it a class
// CORE DATA - rename to '*JSON' b/c we still need to do the first launch parse and load of core data
class RecipeJSON: Identifiable, Decodable {
    //  Identifiable, b/c instances will be shown in a list
    //  Decodable, b/c recipes.json needs to be parsed
    
    //  Represents a SINGLE recipe
    var id:UUID?  // needs to be an optional b/c it's not set until after we decode from the json
    var name:String
    var category:String
    var featured:Bool
    // OLD - was an image added to our asset library, but with Core Data the image will be type = binary data. and will make it optional.
    // will need to change code throughout the project to handle binary instead of a string asset path
    var image:String
    // 'description' is protected in core date, so renaming to 'summary'
    var description:String
    var prepTime:String
    var cookTime:String
    var servings:Int
    var highlights:[String]
    // instead of an array of strings, the ingredients will be an array of [ingredient]
    var ingredients:[IngredientJSON]
    var directions:[String]
    // if you don't want a particular field from the JSON file, just don't create the var in the model
    
}

// Each Ingredient will look like this!
class IngredientJSON: Identifiable, Decodable {
    // must be Identifiable and Decodable like the parent
    //name is required but everything else is optional
    var id:UUID?
    var name:String
    var num:Int?    // numerator
    var denom:Int?
    var unit:String?
}
