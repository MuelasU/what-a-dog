//
//  CameraButton.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 17/05/22.
//

import SwiftUI

struct TakePictureButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action, label: {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 65, height: 65)
                Circle()
                    .stroke(Color.white, lineWidth: 5)
                    .frame(width: 78, height: 78)
            }
        })
    }
}

struct CameraButton_Previews: PreviewProvider {
    static var previews: some View {
        TakePictureButton(action: {})
    }
}
