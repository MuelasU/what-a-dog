//
//  ImageOptionButton.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 18/05/22.
//

import SwiftUI

struct ImageOptionButton: View {
    let symbol: String
    let action: () -> Void

    var body: some View {
        Button(action: action, label: {
            Image(systemName: symbol)
                .font(.system(size: 60))
                .foregroundColor(.white)
        })
    }
}

struct ImageOptionButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageOptionButton(symbol: "x.circle.fill", action: {})
    }
}
