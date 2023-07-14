//
//  AddListData.swift
//  Recipe List App
//
//  Created by tom montgomery on 7/13/23.
//

import SwiftUI

struct AddListData: View {
    
    @Binding var list: [String]
    // need to initialize to emptry string or else it will make the whole init() method private (private inheritance?).  Alternatively, we could define our own init() method in here
    @State private var item: String = ""
    // title is not a binding since we just pass it in but it's not going to core data to be saved
    var title: String
    var placeholderText: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Text("\(title):")
                    .bold()
                TextField(placeholderText, text: $item)
                Button("Add") {
                    //Add the item to the list - must check for blanks first
                    if item.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                        list.append(item.trimmingCharacters(in: .whitespacesAndNewlines))
                        // Clear the text field
                        item = ""
                    }
                }
            }
            
            // List out the items added so far
            ForEach(list, id: \.self) { item in
                // use a ForEach(), not a List() so that it re-renders the list (bound to $highlights)
                Text(item)
            }
            // we can't set it to conform to the Identifiable protocol like we can with our classes so just use .self
        }
    }
}

//struct AddListData_Previews: PreviewProvider {
//    static var previews: some View {
//        AddListData()
//    }
//}
