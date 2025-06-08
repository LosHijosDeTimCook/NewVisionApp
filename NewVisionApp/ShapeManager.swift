import RealityKit
import Foundation
 
class ShapeManager {
    static let shared = ShapeManager()
    private var spinningEntities = [Entity: Timer]()
 
    private init() {}
 
    func startSpin(entity: Entity) {
        print("Starting spin for entity: \(entity.name)")
        stopSpin(entity: entity)
 
        // Store the timer for this entity
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            // Rotate the entity smoothly (60 FPS)
            let rotation = entity.transform.rotation
            let newRotation = simd_mul(rotation, simd_quatf(angle: 0.05, axis: [0, 1, 0]))
            entity.transform.rotation = newRotation
        }
 
        spinningEntities[entity] = timer
 
        // Scale up the entity
        let currentTransform = entity.transform
        entity.transform.scale = [1.3, 1.3, 1.3]
 
        print("Spin started for \(entity.name)")
    }
 
    func stopSpin(entity: Entity) {
        print("Stopping spin for entity: \(entity.name)")
 
        // Stop and remove timer
        if let timer = spinningEntities[entity] {
            timer.invalidate()
            spinningEntities.removeValue(forKey: entity)
        }
 
        // Reset scale and rotation
        entity.transform.scale = [1.0, 1.0, 1.0]
        // Keep current rotation - don't reset to avoid jarring snap
 
        print("Spin stopped for \(entity.name)")
    }
 
    func stopAllSpins() {
        for (entity, timer) in spinningEntities {
            timer.invalidate()
            entity.transform.scale = [1.0, 1.0, 1.0]
        }
        spinningEntities.removeAll()
    }
}
 
