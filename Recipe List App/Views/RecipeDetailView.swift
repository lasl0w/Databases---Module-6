//
//  RecipeDetailView.swift
//  Recipe List App
//
//  Created by tom montgomery on 9/25/22.
//

import SwiftUI

struct RecipeDetailView: View {
    // RecipeDETAILView is a CHILD of the ListView, SOOO as long as we pass in the below, we can reference the RecipeModel and call getPortion
    //@EnvironmentObject var model:RecipeModel
    // BUT, if you make it a STATIC method, you don't need it.   STATIC is a better approach here.
    
    
    // detail view depends on a reference to a single recipe, but WHAT is it!....
    // unset right now.  it's determined by what the user clicks on
    var recipe:Recipe
    @State var selectedServingSize = 2
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                // use "mark" (all caps) to fill in the Xcode breadcrumbs sub-nav
                // MARK: Recipe Image
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                
                // MARK: Recipe Title
                Text(recipe.name)
                    .bold()
                    //.font(.title)
                    .padding(.top, 20)
                    .padding(.leading)
                    .font(Font.custom("Avenir Heavy", size: 32))
                
                // MARK: Serving Size Picker
                VStack {
                    Text("Select your serving size:")
                        .padding(.leading)
                    // label var is irrelevant on the SegmentedPickerStyle, so it's an empty string
                    // bind to selectedServingSize - two way binding (detect changes)
                    Picker("", selection: $selectedServingSize) {
                        Text("2").tag(2) // tagging with an INT, equivalent to the selection makes life slightly easier
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text("8").tag(8)
                    }
                    // make an instance of the pickerStyle
                    .pickerStyle(SegmentedPickerStyle())
                    // default picker was too wide, so drop it in a frame
                    .frame(width: 160)
                    // can just specify the param we want to change on the frame
                }

                
                
                // MARK: Ingredients
                VStack(alignment: .leading){
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.vertical)
                        .font(Font.custom("Avenir Heavy", size: 16))
                    // googled "unicode dot" to get the bullet symbol
                    // OLD FOREACH - needed to set id:\.self because it did not have one during iteration
                    //  ForEach (recipe.ingredients, id:\.self) { item in
                    //  Text("• " + item)
                    ForEach (recipe.ingredients) { item in
                        // calc the PORTION in the VIEWMODEL so that func can be used elsewhere
                        Text("• " +  RecipeModel.getPortion(ingredient: item, recipeServings: recipe.servings, targetServings: selectedServingSize) + " " +  item.name.lowercased())
                            .font(Font.custom("Avenir", size: 14))
                        
                    }
                            .padding(.bottom, 1.0)

                }
                .padding(.horizontal)
                //MARK: Divider
                Divider()
                // MARK: Directions
                VStack(alignment: .leading) {
                    Text("Directions")
                        .font(.headline)
                        .padding([.bottom, .top], 5)
                        .font(Font.custom("Avenir Heavy", size: 16))
                    // ^^^ same as .padding(.vertical, 5)
                    //ForEach(recipe.directions, id: \.self) { item in
                    ForEach(0..<recipe.directions.count, id: \.self) { index in
                        Text(String(index+1) + ". " + recipe.directions[index])
                            .padding(.bottom, 5)
                            .font(Font.custom("Avenir", size: 14))
                    }
                }
                .padding(.horizontal)
            }
        }
        // remove so we can include the title in our .sheet view on the Featured recipes.  bring it inside the VStack
        //.navigationBarTitle(recipe.name)
        
       
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        // Create a dummy recipe and pass it into the detail view so that we can see a preview
        
        let model = RecipeModel()
        
        RecipeDetailView(recipe: model.recipes[0])
    }
}
