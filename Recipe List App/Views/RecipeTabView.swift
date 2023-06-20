//
//  RecipeTabView.swift
//  Recipe List App
//
//  Created by tom montgomery on 10/15/22.
//

import SwiftUI

struct RecipeTabView: View {
    
    // Add State var and binding so we can control when to go back to Category or List views
    // default to Featured
    @State var selectedTab = Constants.featuredTab
    
    var body: some View {
        // .tag() plus selection: property go hand in hand.  binding it. 2-way relationship
        TabView (selection: $selectedTab) {
            // Create an instance of the RecipeFeaturedView
            RecipeFeaturedView()
                .tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Featured")
                    }
                }
                .tag(Constants.featuredTab)
            
            // create an instance of RecipeCategoryView
            RecipeCategoryView(selectedTab: $selectedTab)
                .tabItem {
                    VStack {
                        Image(systemName: "square.grid.2x2")
                        Text("Categories")
                    }
                }
                .tag(Constants.categoriesTab)
            
            
            // create an instance of recipeListView
            RecipeListView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        // use SF Symbols app to look at
                        Text("List")
                    }
                }
                .tag(Constants.listTab)
        }
        .environmentObject(RecipeModel())
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
