import SwiftUI
import RealityKit
 
struct ImmersiveViewMath: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.dismissWindow) var closeWindow
    @Environment(\.openWindow) var openWindow
  
    @State private var selectedShape: ShapeType?
    @State private var showInfo = false
 
    var body: some View {
        RealityView { content in
            // Add all shapes in a horizontal line at a better position
            let shapes = ShapeType.allCases
            let spacing: Float = 0.5
            let totalWidth = Float(shapes.count - 1) * spacing
            let startX = -totalWidth / 2
            
            for (index, shape) in shapes.enumerated() {
                let entity = shape.createEntity()
                let x = startX + (Float(index) * spacing)
                // Position shapes at a comfortable viewing height and distance
                entity.position = [x, 1.6, -1.0] // At eye level (0), comfortable distance
                entity.name = shape.rawValue
                
                // Enable interaction - this is crucial for tapping
                entity.components.set(InputTargetComponent())
                
                // Add collision component for tap detection - make it larger for easier tapping
                let collisionShape: ShapeResource
                switch shape {
                case .sphere:
                    collisionShape = .generateSphere(radius: 0.15)
                case .cube:
                    collisionShape = .generateBox(size: [0.3, 0.3, 0.3])
                default:
                    collisionShape = .generateBox(size: [0.3, 0.3, 0.3])
                }
                entity.components.set(CollisionComponent(shapes: [collisionShape]))
                
                content.add(entity)
                
                print("Added \(shape.rawValue) at position \([x, 0.0, -1.0]) with interaction enabled")
            }
            
        } update: { content in
            // Update logic if needed
        }
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    print("Tapped entity: \(value.entity.name)")
 
                    if let shape = ShapeType(rawValue: value.entity.name) {
                        // Handle shape tap
                        print("Tapped shape: \(shape.rawValue)")
 
                        // Start spin animation
                        ShapeManager.shared.startSpin(entity: value.entity)
 
                        // Stop spinning after 4 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                            ShapeManager.shared.stopSpin(entity: value.entity)
                        }
 
                        // Set selected shape and show info with a slight delay
                        // This ensures the sheet presentation happens after the current gesture handling
                        DispatchQueue.main.async {
                            selectedShape = shape
                            showInfo = true
                            print("Setting showInfo to true for shape: \(shape.rawValue)")
                        }
                    }
                }
        )
        .overlay(alignment: .topTrailing) {
            // UI overlay for exit button - much more visible
            Button(action: {
                Task {
                    appModel.immersiveSpaceState = .closing
                    await dismissImmersiveSpace()
                    appModel.immersiveSpaceState = .closed
                    appModel.showImmersiveSpace = false
                }
            }) {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                    Text("Exit")
                }
                .font(.title2)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
            }
            .buttonStyle(.bordered)
            .background(.red.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding(30)
        }
        .overlay(alignment: .bottom) {
            VStack {
                // Show shape info if selected
                if let shape = selectedShape, showInfo {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text(shape.rawValue.capitalized)
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            Button("Close") {
                                showInfo = false
                                selectedShape = nil
                            }
                        }
 
                        Text("Formulas:")
                            .font(.headline)
                        Text(shape.formulas)
                            .font(.system(.caption, design: .monospaced))
 
                        Text("Properties:")
                            .font(.headline)
                        switch shape {
                        case .cube:
                            Text("• 6 square faces • 12 edges • 8 vertices")
                        case .pyramid:
                            Text("• Polygonal base • Triangular sides • Apex vertex")
                        case .cone:
                            Text("• Circular base • Curved surface • Apex vertex")
                        case .sphere:
                            Text("• Perfectly round • No edges/vertices • Constant curvature")
                        case .cylinder:
                            Text("• Two parallel bases • Curved surface • Constant cross-section")
                        }
                    }
                    .padding()
                    .frame(maxWidth: 400)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
                } else {
                    // Instructions overlay
                    VStack {
                        Text("Tap shapes to learn about them")
                            .font(.headline)
                        Text("Shapes will spin when selected")
                            .font(.caption)
                    }
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                }
            }
        }
        // Move the sheet to be directly on the view, not in an overlay
        .sheet(isPresented: $showInfo) {
            if let shape = selectedShape {
                ShapeInfoSheet(shape: shape, isPresented: $showInfo)
            }
        }
        .onChange(of: showInfo) { oldValue, newValue in
            print("showInfo changed from \(oldValue) to \(newValue)")
        }
    }
}
 
// Separate the sheet content into its own view for better organization
struct ShapeInfoSheet: View {
    let shape: ShapeType
    @Binding var isPresented: Bool
 
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    // Shape title
                    HStack {
                        Text(shape.rawValue.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Spacer()
                    }
 
                    // Formulas section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("📐 Mathematical Formulas")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
 
                        Text(shape.formulas)
                            .font(.system(.body, design: .monospaced))
                            .padding(16)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                            )
                    }
 
                    // Properties section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("🔍 Shape Properties")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
 
                        VStack(alignment: .leading, spacing: 8) {
                            switch shape {
                            case .cube:
                                PropertyRow(icon: "⬜", text: "6 square faces")
                                PropertyRow(icon: "📏", text: "12 edges")
                                PropertyRow(icon: "⚫", text: "8 vertices")
                                PropertyRow(icon: "🔄", text: "All sides equal length")
                            case .pyramid:
                                PropertyRow(icon: "🔺", text: "Polygonal base")
                                PropertyRow(icon: "📐", text: "Triangular sides")
                                PropertyRow(icon: "⬆️", text: "Single apex vertex")
                                PropertyRow(icon: "📊", text: "Height from base to apex")
                            case .cone:
                                PropertyRow(icon: "⭕", text: "Circular base")
                                PropertyRow(icon: "🌀", text: "Curved lateral surface")
                                PropertyRow(icon: "⬆️", text: "Single apex vertex")
                                PropertyRow(icon: "📏", text: "Slant height = √(r² + h²)")
                            case .sphere:
                                PropertyRow(icon: "🔵", text: "Perfectly round shape")
                                PropertyRow(icon: "🎯", text: "All points equidistant from center")
                                PropertyRow(icon: "♾️", text: "No edges or vertices")
                                PropertyRow(icon: "🔄", text: "Constant curvature everywhere")
                            case .cylinder:
                                PropertyRow(icon: "⭕", text: "Two parallel circular bases")
                                PropertyRow(icon: "📏", text: "Curved lateral surface")
                                PropertyRow(icon: "⏸️", text: "Constant cross-section")
                                PropertyRow(icon: "📐", text: "Height perpendicular to bases")
                            }
                        }
                        .padding(16)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.green.opacity(0.3), lineWidth: 1)
                        )
                    }
 
                    Spacer(minLength: 50)
                }
                .padding(20)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                    .font(.headline)
                }
            }
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }
}
 
struct PropertyRow: View {
    let icon: String
    let text: String
 
    var body: some View {
        HStack(spacing: 12) {
            Text(icon)
                .font(.title3)
            Text(text)
                .font(.body)
            Spacer()
        }
    }
}
 
