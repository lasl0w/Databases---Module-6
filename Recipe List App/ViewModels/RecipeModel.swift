//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by tom montgomery on 5/8/22.
//

import Foundation

class RecipeModel: ObservableObject {
    
    // Publish so it can flow to the ObservedObject in the view
    @Published var recipes = [Recipe]()
    
    // Need to keep a list of categories.  SET is unordered and unique - a perfect data structure for this use case
    // parens () creates the brand new set
    @Published var categories = Set<String>()
    // also keep track of the selected Category
    @Published var selectedCategory : String?
    
    // Move to SERVICES class for when you have multiple ViewModels
    init() {
//
//        // create an instance of data service and get the data
        
        // Base Example
        //let service = DataService()
        //self.recipes = service.getLocalData()
        
        
        // 1-liner version
        //self.recipes = DataService().getLocalData()
        
        // ALT version - change to 'static' method
        // if the Service func definition is static, then you don't have to create an instance of the DataService to call the method.  STATIC Method = TYPE Method
        self.recipes = DataService.getLocalData()
        
        // ONE WAY TO MAP IT - THE LONG WAY
//        var categoryStringArray = [String]()
//        for r in recipes {
//            // IF r.category doesn't already exist in the array, then
//            categoryStringArray.append(r.category)
//        }
        // INSTEAD - USE THE MAP FUNCTION
//        var categoryStringArray = self.recipes.map { r in
//            // hit enter on the function stub to open up a closure
//            return r.category
//        }
        
        // INSTEAD PART 2 - FURTHER SHORTHAND
//        self.categories = Set(self.recipes.map({ r in
//            // passing it into a SET automatically filters it to unique - by definition of a SET
//            return r.category
//        }))
//        // Also add an ALL category
//        self.categories.update(with: Constants.defaultListFilter)
        
//
//        // Set the recipes properties
    }
    
    // using static, you can call the method without creating an instance of a model it's in
    static func getPortion(ingredient:Ingredient, recipeServings:Int, targetServings:Int) -> String {
        // returns a STRING for the ingredients list
        
        // REFACTORED - got rid of optionals for when using core data ints
        var portion = ""
        var numerator = ingredient.num // ?? = nil coalescing operator
        // if the num is nil, make it 1
        var denominator = ingredient.denom
        var wholePortions = 0
        
        // check to make sure we need to do ANY math
        //if ingredient.num != nil {
        // Get a single serving size by multiplying denom by the recipe servings
        denominator = denominator * recipeServings
        // EXAMPLE - 1.5 cups of rice = 3 over 2.   multiply 2 * 6, since default servings was 6
        
        // Get target portion by multiplying numerator by target servings
        numerator *= targetServings
        // EXAMPLE - knowing we are about to work with a single serving, multiply numerator * targetServings
        
        // Reduce fraction by greatest common devisor - thanks MICAH!
        let divisor = Rational.greatestCommonDivisor(numerator, denominator)
        print(divisor)
        
        // same same, but shorthand below
        numerator = numerator / divisor
        denominator /= divisor
        
        // Get the whole portion.  Is it more than 1?
        if numerator >= denominator {
            // calc whole portions
            wholePortions = numerator / denominator
            
            // calc the remainder
            numerator = numerator % denominator
            // if it returns zero, then we don't have any fraction to deal with
            
            // assign to portion string
            portion += String(wholePortions)
        }
        // Express the remainder as a fraction
        if numerator > 0 {
            
            // Assign remainder as fraction appended to the portion string
            portion += wholePortions > 0 ? " " : ""
            portion += "\(numerator)/\(denominator)"
        }
    
        // can do an if var, instead of an if let
        if var unit = ingredient.unit {
            // if we need to pluralize
            if wholePortions > 1 {
                // calculate appropriate unit suffix
                if unit.suffix(2) == "ch" {
                    unit += "es"
                }
                else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast())
                    unit += "ves"
                }
                else {
                    unit += "s"
                }
            }
            
            // handle the "salt to taste" scenario
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            return portion + unit
        }
        
        // return targetServings during QA just to test that we are getting the vars and it's running
        //return String(targetServings)
        return portion
    }
    
    
}
