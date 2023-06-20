//
//  Recipe.swift
//  Recipe List App
//
//  Created by tom montgomery on 5/8/22.
//

import Foundation


// we know it needs an ID b/c it's going to be displayed in a list so just make it a class
class Recipe: Identifiable, Decodable {
    //  Identifiable, b/c instances will be shown in a list
    //  Decodable, b/c recipes.json needs to be parsed
    
    //  Represents a SINGLE recipe
    var id:UUID?  // needs to be an optional b/c it's not set until after we decode from the json
    var name:String
    var category:String
    var featured:Bool
    var image:String
    var description:String
    var prepTime:String
    var cookTime:String
    var servings:Int
    var highlights:[String]
    // instead of an array of strings, the ingredients will be an array of [ingredient]
    var ingredients:[Ingredient]
    var directions:[String]
    // if you don't want a particular field from the JSON file, just don't create the var in the model
    
}

// Each Ingredient will look like this!
class Ingredient: Identifiable, Decodable {
    // must be Identifiable and Decodable like the parent
    //name is required but everything else is optional
    var id:UUID?
    var name:String
    var num:Int?    // numerator
    var denom:Int?
    var unit:String?
}
