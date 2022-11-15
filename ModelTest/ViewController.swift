//
//  ViewController.swift
//  ModelTest
//
//  Created by 長政輝 on 2022/11/15.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Load model
        let entity = try! ModelEntity.load(named: "toy_biplane")
        let parentEntity = ModelEntity()
        parentEntity.addChild(entity)

        // 2. Create anchor
        // minimumBounds: 反応するplaneの最小サイズ
        let anchor = AnchorEntity.init(.plane(.horizontal, classification: .any, minimumBounds: [0, 0]))
        
        // 3. Place anchor in the scene
        arView.scene.addAnchor(anchor)
        
        // 4. Add entity to anchor
        anchor.addChild(parentEntity)
        
        // 5. Enable gestures
        // recursive: すべての子孫の衝突形状も生成するかどうか
        parentEntity.generateCollisionShapes(recursive: true)
        arView.installGestures(for: parentEntity)
    }
}
