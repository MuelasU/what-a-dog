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
    var dogList = [SCNNode]()

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
        arView.autoenablesDefaultLighting = true
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

    override func motionEnded(_: UIEvent.EventSubtype, with _: UIEvent?) {
        arView.scene.removeAllParticleSystems()
        for dog in dogList { dog.removeFromParentNode() }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: arView)
            let results = arView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
            if let hitResult = results.first {
                let vector = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
                placeDog(position: vector)
            }
        }
    }

    func placeDog(position: SCNVector3) {
        let dogScene = SCNScene(named: "Doguinho.scn")

        if let dogNode = dogScene?.rootNode.childNode(withName: "Doguinho_low_poly", recursively: true) {
            dogNode.scale = SCNVector3(0.02, 0.02, 0.02)
            dogList.append(dogNode)
            dogNode.position = SCNVector3(position.x, position.y + dogNode.boundingSphere.radius / 100, position.z)
            arView.scene.rootNode.addChildNode(dogNode)
            AudioManager.shared.playBark()
            dogNode.runAction(SCNAction.rotateBy(x: CGFloat(Float.pi * 10), y: 0, z: 0, duration: 0.5))
        }
    }

    func renderer(_: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            let planeAnchor = (anchor as? ARPlaneAnchor)!
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))

            let planeNode = SCNNode()
            planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)

            let clearMaterial = SCNMaterial()
            clearMaterial.diffuse.contents = UIColor.clear
            plane.materials = [clearMaterial]

            planeNode.geometry = plane
            node.addChildNode(planeNode)
        } else {
            return
        }
    }
}

struct ARViewIndicator: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARView

    func makeUIViewController(context _: Context) -> ARView {
        return ARView()
    }

    func updateUIViewController(_: ARView, context _: Context) {}
}
