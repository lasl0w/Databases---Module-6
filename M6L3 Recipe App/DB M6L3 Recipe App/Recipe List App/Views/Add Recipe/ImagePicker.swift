//
//  ImagePicker.swift
//  Recipe List App
//
//  Created by tom montgomery on 7/14/23.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    // to conform to this protocol, we need a UIViewController
    
    // Every UIView has properties you can access via @Environment keypath destinations - and functions underneath (i.e. - Dismiss)
    // declare an Environment keypath - reads a specific property of UIViewController
    // in the presentationMode, we can call Dismiss
    // TODO: refactor to use isPresented
    @Environment(\.presentationMode) var presentationMode
    
    var selectedSource: UIImagePickerController.SourceType
    @Binding var recipeImage: UIImage?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        // Create the image picker controller
        let imagePickerController = UIImagePickerController()
        // this will assign a new one or grab the existing coordinator
        imagePickerController.delegate = context.coordinator
        
        // default is already photo library, but let's set it for demo purposes
        //imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        // simpler version
        //imagePickerController.sourceType = .photoLibrary
        // instead, lets pass it in
        imagePickerController.sourceType = selectedSource
        
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update the image
    }
    
    // acts as a delegate to handle any events, like the user selecting an image
    func makeCoordinator() -> Coordinator {
        // Create a coordinator
        Coordinator(parent: self)
        
        // We don't explicitly call makeCoordinator, but it's called when someone accesses context.coordinator if one doesn't already exist.
    }
    
    // NSObject:  conform so it can be set as a Delegate
    // UIImagePickerControllerDelegate: says "I'm going to handle all the methods that handle events from a UIImagePicker
    // : UIImagePicker is a type of UINavigationController
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        // The coordinator's parent is the imagePicker.  We must have a property to access the parent
        var parent: ImagePicker
        
        // Then we make an init method to pass in that parent
        init(parent: ImagePicker){
            print("called makeCoordinator")
            self.parent = parent
        }
        
        // lots of 'did' events.  Let's tackle this one
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // info[] :  it's actually a dictionary that contains a particular key
            
            // Check if we can get the image from the INFO dictionary
            // need to cast it as a UIImage
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                //Yay - we were able to get the UIImage into the image constant, pass this back to the AddRecipeView
                parent.recipeImage = image
            }
            
            // Dismiss the view
            parent.presentationMode.wrappedValue.dismiss()
            // ALT method to dismiss - pass the isShowingImagePicker in as a binding, then >>>
            //parent.isShowingImagePicker == false
        }
    }
    
}
