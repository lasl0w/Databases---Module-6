//
//  RecipeCategoryView.swift
//  Recipe List App
//
//  Created by tom montgomery on 3/28/23.
//

import SwiftUI

struct RecipeCategoryView: View {
    
    @EnvironmentObject var model: RecipeModel
    
    // Allow selectedTab to be passed in and ensure it's a binding
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Categories")
                .bold()
                .padding(.top, 20)
                .font(Font.custom("Avenir Heavy", size: 24))
            
            GeometryReader { geo in
                
                // create scrollview inside the geometryReady so the Categories title does not scroll
                ScrollView (showsIndicators: false){
                    // showIndicators false so we don't see the scroll bar
                    
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 20, alignment: .top), GridItem(.flexible(), spacing: 20, alignment: .top)], alignment: .center, spacing: 20) {
                        // trailing closure is the contents: property
                        
                        // Can't loop through the Set (as it's unordered), needs to cast it as an array
                        ForEach (Array(model.categories), id: \.self) { cat in
                            //Text(cat)
                            
                            Button {
                                // Switch tabs to list view
                                selectedTab = Constants.listTab
                                
                                // set the selected category to filter on
                                model.selectedCategory = cat
                            } label: {
                                VStack {
                                    // aspect ratio is not 1:1, so we need to change it.  i.e. - the baked potato is more of a rectangle and we want a square
                                    // solve with the geometryReader to set the frame
                                    Image(cat.lowercased())
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: (geo.size.width - 20)/2, height: (geo.size.width - 20)/2)
                                        .cornerRadius(10)
                                        .clipped()
                                    // need to set frame width/height minus 20 to account for the gutter in the middle
                                    Text(cat)
                                        .foregroundColor(.black)
                                }
                            }

                        }
                        
                    }
                    .padding(.bottom)
                    
                    // each column is made up of an array of GridItems
                    // even when you choose FLEXIBLE, you can choose a min/max
                }
                
               
            }
            
           
        }
        .padding()
    }
}

//struct RecipeCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeCategoryView()
//    }
//}
