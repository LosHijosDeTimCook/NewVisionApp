import RealityKit
 
enum ShapeType: String, CaseIterable {
    case cube, pyramid, cone, sphere, cylinder
 
    var defaultMaterial: SimpleMaterial {
        switch self {
        case .cube:
            return SimpleMaterial(color: .blue, isMetallic: true)
        case .pyramid:
            return SimpleMaterial(color: .red, isMetallic: false)
        case .cone:
            return SimpleMaterial(color: .green, isMetallic: true)
        case .sphere:
            return SimpleMaterial(color: .yellow, isMetallic: false)
        case .cylinder:
            return SimpleMaterial(color: .purple, isMetallic: true)
        }
    }
 
    func createEntity() -> ModelEntity {
        switch self {
        case .cube:
            return ModelEntity(
                mesh: .generateBox(size: 0.2),
                materials: [defaultMaterial]
            )
        case .pyramid:
            // Create pyramid using a regular cone as approximation
            // Standard generateCone doesn't support sides parameter
            return ModelEntity(
                mesh: .generateCone(height: 0.2, radius: 0.1),
                materials: [defaultMaterial]
            )
        case .cone:
            return ModelEntity(
                mesh: .generateCone(height: 0.2, radius: 0.1),
                materials: [defaultMaterial]
            )
        case .sphere:
            return ModelEntity(
                mesh: .generateSphere(radius: 0.1),
                materials: [defaultMaterial]
            )
        case .cylinder:
            return ModelEntity(
                mesh: .generateCylinder(height: 0.2, radius: 0.1),
                materials: [defaultMaterial]
            )
        }
    }
 
    var formulas: String {
        switch self {
        case .cube:
            return "Volume: V = s³\nSurface Area: A = 6s²\nPerimeter: P = 12s"
        case .pyramid:
            return "Volume: V = (1/3)Bh\nSurface Area: A = B + (1/2)Pl\n(B = base area, P = base perimeter)"
        case .cone:
            return "Volume: V = (1/3)πr²h\nSurface Area: A = πr(r + l)\nSlant Height: l = √(r² + h²)"
        case .sphere:
            return "Volume: V = (4/3)πr³\nSurface Area: A = 4πr²\n(All points equidistant from center)"
        case .cylinder:
            return "Volume: V = πr²h\nSurface Area: A = 2πr(h + r)\n(Two parallel circular bases)"
        }
    }
}
 
