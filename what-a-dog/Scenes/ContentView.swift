//
//  ContentView.swift
//  what-a-dog
//
//  Created by Gabriel Muelas on 10/05/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CameraView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
