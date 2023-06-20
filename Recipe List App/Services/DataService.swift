//
//  DataService.swift
//  Recipe List App
//
//  Created by tom montgomery on 5/13/22.
//

import Foundation

// By making this a service instead of part of every ViewModel, it can be created once and used by many models
// single point of failure and refactoring
class DataService {
    //if we make it static, you don't have to create an instance in the ViewModel
    static func getLocalData() -> [Recipe]{
        
        // Parse local json file
        
        // Get URL path to json file
        // forResource is the file name
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")

        // main.path returns an optional, soo...
        // Check if pathString is not nil, otherwise...
        guard pathString != nil else {
            // guard ensures it is true, like an "if let"
            return [Recipe]() // return an empty list
        }
        
        // create a URL object
        let url = URL(fileURLWithPath: pathString!)
        // must unwrap the optional

        // create a data object
        do {
            let data = try Data(contentsOf: url)
            
            // decode the data with a json decoder
            let decoder = JSONDecoder()
            do {
               // separate DO CATCH so we can delineate between the two error cases
                // Pass in a type of an array of recipes.
                let recipeData = try decoder.decode([Recipe].self, from: data)
                for r in recipeData {
                    // Add the unique IDs
                    r.id = UUID()
                    
                    // also iterate through each Ingredient to give it a UUID
                    for i in r.ingredients {
                        i.id = UUID()
                    }
                }
                // return the recipes
                return recipeData
            }
            catch {
                print(error)
            }
            
        }
        catch {
            // error getting the data
            print(error)
        }
        // if it happens to skip everything, return an empty array
         return [Recipe]()
    }
}
