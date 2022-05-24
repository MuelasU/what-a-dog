//
//  ArFile.swift
//  ArUi
//
//  Created by Fernando Santos on 20/05/22.
//

import ARKit
import Foundation
import SwiftUI

class ARView: UIViewController, ARSCNViewDelegate {
    var arView: ARSCNView {
        return (self.view as? ARSCNView)!
    }

    override func loadView() {
        view = ARSCNView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        arView.delegate = self
        arView.scene = SCNScene()
        // arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]

        let dogScene = SCNScene(named: "Doguinho.scn")
        let jellyScene = SCNScene(named: "Jellyfish.scn")

        if let jellyNode = jellyScene?.rootNode.childNode(withName: "Sphere", recursively: true) {
            jellyNode.position = SCNVector3(0, 0, -10)
            arView.scene.rootNode.addChildNode(jellyNode)
            arView.autoenablesDefaultLighting = true
        }

        if let dogNode = dogScene?.rootNode.childNode(withName: "Doguinho_low_poly", recursively: true) {
            dogNode.scale = SCNVector3(0.25, 0.25, 0.25)
            dogNode.position = SCNVector3(10, 0, -10)
            arView.scene.rootNode.addChildNode(dogNode)
            arView.autoenablesDefaultLighting = true
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arView.session.run(configuration)
        arView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
}

struct ARViewIndicator: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARView

    func makeUIViewController(context _: Context) -> ARView {
        return ARView()
    }

    func updateUIViewController(_: ARView, context _: Context) {}
}
