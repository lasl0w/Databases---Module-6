//
//  RecipeTabView.swift
//  Recipe List App
//
//  Created by Christopher Ching on 2021-02-03.
//

import SwiftUI

struct RecipeTabView: View {
    var body: some View {
        
        
        
        TabView {
            
            RecipeFeaturedView()
                .tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Featured")
                    }
                }
            
            RecipeListView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("List")
                    }
                }
            AddRecipeView()
                .tabItem {
                    VStack {
                        Image(systemName: "plus.circle")
                        Text("Add")
                    }
                }
        }
        .environmentObject(RecipeModel())
        
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
