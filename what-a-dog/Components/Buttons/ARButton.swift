//
//  ARButton.swift
//  what-a-dog
//
//  Created by Fernando Santos on 30/05/22.
//

import Foundation
import SwiftUI

struct ARButton: View {
    @Binding var selection: Int?
    var action: () -> Void

    var body: some View {
        NavigationLink(destination: ZStack { NavigationIndicator() },
                       tag: 3,
                       selection: $selection) {
            HStack(spacing: 10) {
                Image("logo-apple-ar")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 2))

                Text("See in AR")
                    .foregroundColor(Color("WADgreen2"))
                    .padding(EdgeInsets(top: 8, leading: 2, bottom: 8, trailing: 16))

            }.onTapGesture {
                action()
            }
            .background(Color("WADgray2"))
            .cornerRadius(10)
        }
    }
}
