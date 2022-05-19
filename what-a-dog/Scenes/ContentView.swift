//
//  ContentView.swift
//  what-a-dog
//
//  Created by Gabriel Muelas on 10/05/22.
//

import SwiftUI

struct ContentView: View {
    @State var image: Image?
    @State var hasSelectedImage = false

    var body: some View {
        if !hasSelectedImage {
            CameraView(hasSelectedImage: $hasSelectedImage, selectedImage: $image)
        } else {
            image!
                .resizable()
                .frame(width: 250, height: 250)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
