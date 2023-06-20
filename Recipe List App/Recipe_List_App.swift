//
//  Recipe_List_App.swift
//  Recipe List App
//
//  Created by tom montgomery on 5/8/22.
//

import SwiftUI

@main
// entry point into the app

struct Recipe_List_AppApp: App {
    var body: some Scene {
        WindowGroup {
            // changed the entry point from the ListView to the TabView
            RecipeTabView()
            //    .environmentObject(RecipeModel())
            // if we wanted to, we could put the .environmentObject modifier further up the view heirarchy HERE, all the way up at the true entry point
        }
    }
}
