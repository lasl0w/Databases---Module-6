//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by tom montgomery on 10/27/22.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    // Instead of making more instances of the model (more fetches and copies), use the EnvironmentObject modifier
    // don't want to manage two sets of data!
    // Move the instance UP the view heirarchy so the top view can pass it down to lower views
    @EnvironmentObject var model:RecipeModel
    @State var isDetailViewShowing = false
    @State var selectedTab = 0
    
    
    var body: some View {
        
        // create an array of just the featured recipes so we can have global access (if we move the .sheet mod to top level vstack
        let featuredRecipes = model.recipes.filter({ $0.featured
        })
        // same as saying >>>
//        let verboseFeaturedRecipes = model.recipes.filter {r in
//        // Condition that must be true to be included in the filter
//            if r.featured == true {
//                return 
//            }
//        }
        
        
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding(.top, 40)
                //.font(.largeTitle)
                .font(Font.custom("Avenir Heavy", size: 32))
            
            // MARK: Geometry reader
            GeometryReader { geo in
                // use the geometryreader to size our image rectangle
                
                // capture Tab selection so we can share it with the prep time & highlights vstack as a STATE var
                // bind with selection:
                // also need to tag the tab with the featured card index
            TabView(selection: $selectedTab) {
                    // Loop through each recipe
                ForEach (0..<model.recipes.count) { index in
                    // Only show those that are featured
                    if model.recipes[index].featured == true {
                            
                        // Recipe Card Button
                        // use action: label: init b/c the label is the card
                        Button(action: {
                                
                            // Show the recipe detail view (sheet)
                            self.isDetailViewShowing = true
                        }, label: {
                            // Display recipe card
                            ZStack {
                                // place in a ZStack as we are going to overlay the image and recipe name
                                // .frame should be on the ZStack, not on the Rectangle so that it affects all of them
                                Rectangle()
                                // set foreground to white to see our text element
                                    .foregroundColor(.white)

                                
                                VStack(spacing: 0) {
                                    // refactor to use UIIMage for core data
                                    // double nil-coalesce!  if this happens to be nil, and then if this happens to be nil
                                    let image = UIImage(data: model.recipes[index].image ?? Data()) ?? UIImage()
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                    Text(model.recipes[index].name)
                                        .padding(5)
                                }
                            }
                        })
                            .tag(index)  // writes to selectedTab state var
                        // sheet shows the view.
                            .sheet(isPresented: $isDetailViewShowing) {
                                // What sheet should we show in this trailing closure
                                RecipeDetailView(recipe: model.recipes[index])
                            }
                            .buttonStyle(PlainButtonStyle())
                            // moved modifiers to apply to the button, so unlink it with PlainStyle
                            .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: .center)
                            // NOTE - when we shift the height, the carousel dots are no longer visible.  need a modifier to make them visible again
                            .cornerRadius(15)
                            // add cornerRadius prior to .shadow to avoid clipping
                            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 5)
                            // RGB - 0,0,0 is black, but opacity 5 cuts it in half - grayish
                            // x: -5 moves it to the left to give the offcenter shadow effect
                       
                        } //  IF Featured
                    } // ForEach
                    
                } //  Tabview
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                // example of a carousel tab, instead of a navigation tab
                // use backgroundDisplayMode to always make the dots visible
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                
            } // Geometry reader
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Preparation Time")
                    //.font(.headline)
                    .font(Font.custom("Avenir Heavy", size: 16))
                // Now available globally here - outside the card Tabs
                Text(model.recipes[selectedTab].prepTime)
                Text("Highlights")
                    //.font(.headline)
                    .font(Font.custom("Avenir Heavy", size: 16))
                RecipeHighlights(highlights: model.recipes[selectedTab].highlights)
            }
            .padding([.leading, .bottom])
        }
        // Add to VStack.  must be in a closure or you'll get a type error
        .onAppear(perform: {
            setFeaturedIndex()
        })
        // best practice may be to put .sheet modifier on root element (this VSTACK).
        
    }
    
    func setFeaturedIndex() {
        // Find the index of first recipe that is featured.  Ensure the prep time and highlights show the right recipe's data
        // Iterates through and basically says "if recipe.features == true, return this index
        let index = model.recipes.firstIndex { (recipe) -> Bool in
            return recipe.featured
        }
        selectedTab = index ?? 0
        // use nil coalescing operator b/c it may find nothing
    }
    
    
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
        // for the sake of the preview, add the modifier directly here
    }
}
