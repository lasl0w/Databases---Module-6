//
//  SearchBarView.swift
//  Recipe List App
//
//  Created by tom montgomery on 7/8/23.
//

import SwiftUI

struct SearchBarView: View {
    
    // Listview will pass in our binding
    @Binding var filterBy: String
    
    var body: some View {
        // Basically going to use a rounded rectangle and drop the text field on top of it
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow(radius: 4)
            HStack {
                // using an HStack so we can horizonatlly display and align the icon plus the textfield
                Image(systemName: "magnifyingglass")
                
                TextField("filter by...", text: $filterBy)
                    // could use .focused() mod in iOS 15+ here
                
                Button {
                    // Clear the text field
                    filterBy = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                }
            }
            .padding()
        }
        .frame(height: 48)
        .foregroundColor(.gray)
        // applies gray to the entire Zstack - consistent grayness instead of blue Image, black Image, etc

    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        // nice way to specify a binding constant for a preview - binding.constant
        SearchBarView(filterBy: Binding.constant("") )
    }
}
