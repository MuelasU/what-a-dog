//
//  NavBackButton.swift
//  what-a-dog
//
//  Created by Fernando Santos on 31/05/22.
//

import SwiftUI
import Foundation

struct NavBackButton: View {
    @Binding var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: { presentationMode.wrappedValue.dismiss() }, label: {
            HStack(spacing: 4) {
                Image(systemName: "chevron.backward").font(Font.body.weight(.bold))
                Text("Back")
            }
        }).foregroundColor(Color.Wad.green2)
    }
}
