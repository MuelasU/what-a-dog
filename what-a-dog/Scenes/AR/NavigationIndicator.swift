//
//  NavigationIndicator.swift
//  what-a-dog
//
//  Created by Fernando Santos on 30/05/22.
//

import SwiftUI
import UIKit

struct NavigationIndicator: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARView

    func makeUIViewController(context _: Context) -> ARView {
        return ARView()
    }

    func updateUIViewController(_: ARView, context _: Context) {}
}
