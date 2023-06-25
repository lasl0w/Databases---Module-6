//
//  ContentView.swift
//  Recipe List App
//
//  Created by tom montgomery on 5/8/22.
//

import SwiftUI

// you can rename ContentView to RecipeListView with CTRL+Click and it will change refs too
struct RecipeListView: View {
    
    // Reference the view model.  New instance of RecipeModel
    // in order for it to flow here, it has to conform to ObserbvableObject
    //@ObservedObject var model = RecipeModel()
    // wrapped with @OO so we can listen for any changes
    
    // Instead of ObservedO, switch to EnvironmentO so it can flow to sub-views
    @EnvironmentObject var model:RecipeModel
    
    // make TITLE a computed property.  private as it's only needed here
    private var title: String {
        if model.selectedCategory == nil || model.selectedCategory == Constants.defaultListFilter {
            return "All Recipes"
        }
        else {
            return model.selectedCategory!
        }
    }
    
    
    var body: some View {
        
        // since models are Identifiable, we can simply pass in model.recipes
        NavigationView {
            
            VStack (alignment: .leading) {
                // Text(title)
                // consistent title formatting across views
                Text("All Recipes")
                    .bold()
                    .padding(.leading)
                    .padding(.top, 40) // drop it 40 pixels from the top
                    //.font(.largeTitle)
                    //.font(Font.custom("BebasNeue Book", size: 39))
                    .font(Font.custom("Avenir Heavy", size: 32))
                

                
                // Instead of a List, let's switch to a ForEach with a ScrollView
                
                
                ScrollView {
                    LazyVStack(alignment: .leading){
                        ForEach(model.recipes) { r in
                            
                            if model.selectedCategory == nil || model.selectedCategory == Constants.defaultListFilter || model.selectedCategory != nil && r.category == model.selectedCategory {
                                
                                NavigationLink(
                                    destination: RecipeDetailView(recipe: r),
                                    label: {
                                        HStack(spacing: 20.0) {
                                            // changed spacing to separate image and r.name slightly
                                            // Image(r.image) - old string value, changed to UIImage for core data
                                            let image = UIImage(data: r.image ?? Data()) ?? UIImage()
                                            Image(uiImage: image)
                                                .resizable()  // so the text is visible
                                                //.scaledToFit() // to retain aspect ratio
                                                .scaledToFill() // fills the frame, BUT needs .clip
                                                .frame(width: 50, height: 50, alignment: .center)
                                                // .frame to make them sized uniform from one to the next
                                                .clipped() // prevent frame overflow
                                                .cornerRadius(5) // extra style!
                                            VStack (alignment: .leading) {
                                                Text(r.name)
                                                    .foregroundColor(.black) // prevent the default of blue
                                                    .bold()
                                                    .font(Font.custom("Avenir Heavy", size: 16))
                                                RecipeHighlights(highlights: r.highlights)
                                                    .foregroundColor(.black)
                                                    .font(Font.custom("Avenir", size: 14))
                                            }

                                        }
                                    })
                                }
                            }
                            

                    }

                }
                

            }
            // hiding the nav Bar Title so we can keep design consistent across views.  do as Text element heading instead
            //.navigationBarTitle("All Recipes")
            // removing doesn't remove the space though - must make it HIDDEN like below
            .navigationBarHidden(true)
            .environmentObject(RecipeModel())
            .padding(.leading)
            }

       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
        // adding the env object directly here for the purpose of the preview
    }
}
