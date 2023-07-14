//
//  ContentView.swift
//  Recipe List App
//
//  Created by Christopher Ching on 2021-01-14.
//

import SwiftUI

struct RecipeListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // coredata refactor - no longer need the RecipeModel, getting it from FetchRequest
    //@EnvironmentObject var model:RecipeModel
    
    // get all of them, sorted in alpha by name
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) private var recipes: FetchedResults<Recipe>
    
    // TextField() must always have a State property to bind to
    @State private var filterBy = ""
    
    // How do we apply the filter???  one easy way is a computed property
    private var filteredRecipes: [Recipe] {
        
        // must trim out leading/trailing spaces & newlines
        if filterBy.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            // If there is no filter text then just return everything... cast as an array
            return Array(recipes)
        }
        else {
            // filter by the search term
            return recipes.filter { r in
                return r.name.contains(filterBy)
                // equivalent to:  if r.name contains filterBy return true, else return false
            }
        }
    }
    
    var body: some View {
        // TODO: fix the issue where Phad Thai becomes unclickable after navigating around (and dismissing the keyboard).  Is it resigned like the keyboard???
        NavigationView {
            
            VStack (alignment: .leading) {
                Text("All Recipes")
                    .bold()
                    .padding(.top, 40)
                    .font(Font.custom("Avenir Heavy", size: 24))
                //must be bound to State prop
                //TextField("Filter by...", text: $filterBy)
                SearchBarView(filterBy: $filterBy)
                    .padding([.trailing, .bottom])
                
                ScrollView {
                    LazyVStack (alignment: .leading) {
                        // instead of looping through recipes, loop through filteredRecipes
                        ForEach(filteredRecipes) { r in
                            
                            NavigationLink(
                                destination: RecipeDetailView(recipe:r),
                                label: {
                                    
                                    // MARK: Row item
                                    HStack(spacing: 20.0) {
                                        let image = UIImage(data: r.image ?? Data()) ?? UIImage()
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50, alignment: .center)
                                            .clipped()
                                            .cornerRadius(5)
                                        
                                        VStack (alignment: .leading) {
                                            Text(r.name)
                                                .foregroundColor(.black)
                                                .font(Font.custom("Avenir Heavy", size: 16))
                                            
                                            RecipeHighlights(highlights: r.highlights)
                                                .foregroundColor(.black)
                                        }
                                    }
                                    
                                })
                        }
                    }
                }
                
                
            }
            .navigationBarHidden(true)
            .padding(.leading)
            .onTapGesture {
                // Dismiss the keyboard (Resign first responder)
                // add to VStack, not Navigation View or else it can interfere with Back nav
                // may not longer be an issue in ios 15+?
                // https://developer.apple.com/forums/thread/650844
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
