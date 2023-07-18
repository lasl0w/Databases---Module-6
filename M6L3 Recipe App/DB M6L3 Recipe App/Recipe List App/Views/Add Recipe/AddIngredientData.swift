//
//  AddIngredientData.swift
//  Recipe List App
//
//  Created by tom montgomery on 7/13/23.
//

import SwiftUI

struct AddIngredientData: View {
    
    //should really be plural?
    @Binding var ingredients: [IngredientJSON]
    
    // must initialize so that we don't have to pass it in
    @State private var name = ""
    @State private var unit = ""
    @State private var num = ""
    @State private var denom = ""
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            Text("Ingredients")
                .bold()
                .padding(.top, 5)
            
            HStack {
                TextField("Sugar", text: $name)
                // use frame to adjust the gap between the numerator and the slash
                TextField("1", text: $num)
                    .frame(width: 20)
                
                Text("/")
                
                TextField("2", text: $denom)
                    .frame(width: 20)
                
                TextField("cups", text: $unit)
                
                Button("Add") {
                    
                    // Make sure that the fields are populated
                    let cleanedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    let cleanedNum = num.trimmingCharacters(in: .whitespacesAndNewlines)
                    let cleanedDenom = denom.trimmingCharacters(in: .whitespacesAndNewlines)
                    let cleanedUnit = unit.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    // check that all the fields are filled in
                    if cleanedName == "" || cleanedNum == "" || cleanedDenom == "" || cleanedUnit == "" {
                        // TODO: show a red error, feedback to user.  and hide error if subsequent button push is good
                        return
                    }
                    
                    // Create an IngredientJSON object and set its properties
                    let i = IngredientJSON()
                    // bug fix - had to set the UUID.  if you don't, you save the same data every time
                    i.id = UUID()
                    i.name = cleanedName
                    i.unit = cleanedUnit
                    // now is the moment to convert our strings to ints.  might be nil
                    i.num = Int(cleanedNum) ?? 1
                    i.denom = Int(cleanedDenom) ?? 1
                    
                    // Add this ingredient to the list for the view
                    ingredients.append(i)
                    
                    // Clear all text fields
                    name = ""
                    num = ""
                    unit = ""
                    denom = ""
                }
            }
            
            // IngredientJSON conforms to Identifiable, so no need to specify the id of .self
            ForEach(ingredients) { ingredient in
                
                Text("\(ingredient.name), \(ingredient.num ?? 1)/ \(ingredient.denom ?? 1) \(ingredient.unit ?? "")" )
            }
            
            

        }
    }
}

//struct AddIngredientData_Previews: PreviewProvider {
//    static var previews: some View {
//        AddIngredientData()
//    }
//}
