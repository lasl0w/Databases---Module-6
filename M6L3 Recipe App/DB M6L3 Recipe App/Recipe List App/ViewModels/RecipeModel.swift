//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Christopher Ching on 2021-01-14.
//

import Foundation
import UIKit

class RecipeModel: ObservableObject {
    
    // Reference to the managed object context
    let managedObjectContext = PersistenceController.shared.container.viewContext
    
    @Published var recipes = [Recipe]()
    
    init() {
        
        // use to FORCE preloadLocalData if necessary
        //UserDefaults.standard.setValue(false, forKey: Constants.isDataPreloaded)
        // Check if we have preloaded the data into core data
        checkLoadedData()
    }
    
    func checkLoadedData() {
        
        // Check local storage for the flag
        let status = UserDefaults.standard.bool(forKey: Constants.isDataPreloaded)
        // note this is not an optional.  if the key doesn't exist it just returns false
        print("Status = " + String(status))
        // If it's false, then we should parse the local json and preload into Core Data
        //preloadLocalData()
        if status == false {
            preloadLocalData()
        }
    }
    
    func preloadLocalData() {
        
        // Parse the local JSON file
        let localRecipes = DataService.getLocalData()
        
        // Create Core Data objects
        for r in localRecipes {
            
            // Create a core data object
            let recipe = Recipe(context: managedObjectContext)
            print("Creating recipe core data object for " + r.name)
            // Set its properties
            recipe.cookTime = r.cookTime
            recipe.directions = r.directions
            recipe.featured = r.featured
            recipe.highlights = r.highlights
            recipe.id = UUID()
            // import UIKit or SwiftUI to use UIImage
            // use the UIImage(named: ) function def to grab something from Assets
            recipe.image = UIImage(named: r.image)?.jpegData(compressionQuality: 1.0)
            recipe.name = r.name
            recipe.prepTime = r.prepTime
            recipe.servings = r.servings
            recipe.summary = r.description
            recipe.totalTime = r.totalTime
            
            // Set the ingredients - create core data versions of the ingredients
            for i in r.ingredients {
                
                // Create a core data ingredient object
                let ingredient = Ingredient(context: managedObjectContext)
                
                ingredient.id = UUID()
                ingredient.name = i.name
                ingredient.unit = i.unit
                // these are optional in the model, but not in core data
                ingredient.num = i.num ?? 1
                ingredient.denom = i.denom ?? 1
                
                // Add this ingredient to the recipe
                recipe.addToIngredients(ingredient)
                // core data automatically give us this helper in the Class Properties file, adding it to the set
            }
        }
        
        // Save into Core Data
        do {
            try managedObjectContext.save()
            
            // Set local storage flag
            UserDefaults.standard.setValue(true, forKey: Constants.isDataPreloaded)
        }
        catch {
            // Couldn't save to core data
            print("Couldn't save core data object")
            print(error.localizedDescription)
            
            // Set local storage flag
            UserDefaults.standard.setValue(false, forKey: Constants.isDataPreloaded)
        }
    }
    
    static func getPortion(ingredient:Ingredient, recipeServings:Int, targetServings:Int) -> String {
        
        var portion = ""
        var numerator = ingredient.num
        var denominator = ingredient.denom
        var wholePortions = 0
        
        // Get a single serving size by multiplying denominator by the recipe servings
        denominator *= recipeServings
        
        // Get target portion by multiplying numerator by target servings
        numerator *= targetServings
        
        // Reduce fraction by greatest common divisor
        let divisor = Rational.greatestCommonDivisor(numerator, denominator)
        numerator /= divisor
        denominator /= divisor
        
        // Get the whole portion if numerator > denominator
        if numerator >= denominator {
            
            // Calculated whole portions
            wholePortions = numerator / denominator
            
            // Calculate the remainder
            numerator = numerator % denominator
            
            // Assign to portion string
            portion += String(wholePortions)
        }
        
        // Express the remainder as a fraction
        if numerator > 0 {
            
            // Assign remainder as fraction to the portion string
            portion += wholePortions > 0 ? " " : ""
            portion += "\(numerator)/\(denominator)"
        }
        
        if var unit = ingredient.unit {
            
            // If we need to pluralize
            if wholePortions > 1 {
            
                // Calculate appropriate suffix
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
            
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            
            return portion + unit
        }
        
        return portion
    }
}
