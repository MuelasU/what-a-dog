//
//  CameraView.swift
//  what-a-dog
//
//  Created by Larissa Gomes de Stefano Escaliante on 17/05/22.
//

import SwiftUI

struct CameraView: View {
    @StateObject var camera = CameraViewModel()

    var body: some View {
        ZStack {
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                Spacer()
                if camera.isTaken {
                    HStack {
                        Spacer()
                        Button(action: { camera.reTakePicture() }, label: {
                            Image(systemName: "x.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                        })
                        Spacer()
                        Spacer()
                        Button(action: {}, label: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                        })
                        Spacer()
                    }
                } else {
                    HStack {
                        Spacer()
                        Button(action: {}, label: {
                            Image(systemName: "photo.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        })
                        Spacer()
                        Spacer()
                        Button(action: { camera.takePicture() }, label: {
                            CameraButton()
                        })
                        Spacer()
                        Spacer()
                        Button(action: {}, label: {
                            Image(systemName: "square.grid.2x2.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        })
                        Spacer()
                    }
                }
            }
            .padding()
        }
        .onAppear {
            camera.checkForPermission()
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
