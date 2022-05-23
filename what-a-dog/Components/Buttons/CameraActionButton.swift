//
//  CameraActionButton.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 18/05/22.
//

import SwiftUI

struct CameraActionButton: View {
    let symbol: String
    let action: () -> Void
    let fontSize: CGFloat

    var body: some View {
        Button(action: action, label: {
            Image(systemName: symbol)
                .font(.system(size: fontSize))
                .foregroundColor(.white)
        })
    }
}

struct CameraActionButton_Previews: PreviewProvider {
    static var previews: some View {
        CameraActionButton(
            symbol: "photo.fill",
            action: {},
            fontSize: 40
        )
    }
}
