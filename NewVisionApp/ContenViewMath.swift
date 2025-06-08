import SwiftUI
import RealityKit
 
struct ContentViewMath: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var closeWindow
    
    @State private var selectedShape: ShapeType?
    @State private var showInfo = false
    @State private var selectedEntity: Entity?
 
    var body: some View {
        VStack(spacing: 30) {

            Text("Geometry Explorer")
                .font(.custom("Candy Beans", size: 120) )
                .offset(x:0,y:300)
 
            // 3D Shape display
            RealityView { content in
                // Add shape entities in a row
                let shapes = ShapeType.allCases
                let spacing: Float = 0.3
                let totalWidth = Float(shapes.count - 1) * spacing
                let startX = -totalWidth / 2
 
                for (index, shape) in shapes.enumerated() {
                    let entity = shape.createEntity()
                    let x = startX + (Float(index) * spacing)
                    entity.position = [x, 1.6, -1.5] // Move a bit further back
                    entity.name = shape.rawValue
                    content.add(entity)
 
                    print("Added \(shape.rawValue) at position \([x, 0, -1.5])")
                }
            } update: { _ in }
            .frame(height: 300)
            .gesture(
                SpatialTapGesture()
                    .targetedToAnyEntity()
                    .onEnded { value in
                        print("Tapped: \(value.entity.name)")
                        if let shape = ShapeType(rawValue: value.entity.name) {
                            selectedShape = shape
                            showInfo = true
                        }
                    }
            )
 
 
 
            Spacer()
            Button{
            Task{
                closeWindow(id:"ContentViewMath")
                openWindow(id:"MathView")
                await dismissImmersiveSpace()
                
            }
            }label:{
                Text("Back")
            }
            Button("Enter Immersive Experience") {
                Task { @MainActor in
                    guard appModel.immersiveSpaceState == .closed else {
                        print("Immersive space is not closed, current state: \(appModel.immersiveSpaceState)")
                        return
                    }
 
                    appModel.immersiveSpaceState = .opening
                    print("Attempting to open immersive space...")
 
                    let result = await openImmersiveSpace(id: appModel.immersiveSpaceID)
                    print("Open immersive space result: \(result)")
 
                    switch result {
                    case .opened:
                        appModel.immersiveSpaceState = .open
                        appModel.showImmersiveSpace = true
                        print("Successfully opened immersive space")
                    case .userCancelled:
                        appModel.immersiveSpaceState = .closed
                        appModel.showImmersiveSpace = false
                        print("User cancelled immersive space")
                    case .error:
                        appModel.immersiveSpaceState = .closed
                        appModel.showImmersiveSpace = false
                        print("Error opening immersive space")
                    @unknown default:
                        appModel.immersiveSpaceState = .closed
                        appModel.showImmersiveSpace = false
                        print("Unknown result opening immersive space")
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(appModel.immersiveSpaceState != .closed)
            .padding(.bottom, 30)
        }
        .onAppear {
            // Reset app model state when view appears
            //  openWindow(id:"immersiveSpace")
            appModel.reset()
            print("ContentView appeared, reset app model state")
            closeWindow(id:"Physicsview")
            closeWindow(id:"ChemistryView")
            closeWindow(id:"MathView")
        }
        .sheet(isPresented: $showInfo) {
            if let shape = selectedShape {
                NavigationView {
                    ShapeInfoView(shape: shape)
                        .navigationTitle(shape.rawValue.capitalized)
                        .navigationBarTitleDisplayMode(.large)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    showInfo = false
                                }
                            }
                        }
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
}
 
struct ShapeInfoView: View {
    let shape: ShapeType
 
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Formulas")
                        .font(.headline)
                        .foregroundColor(.blue)
 
                    Text(shape.formulas)
                        .font(.system(.body, design: .monospaced))
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
 
                VStack(alignment: .leading, spacing: 10) {
                    Text("Properties")
                        .font(.headline)
                        .foregroundColor(.blue)
 
                    Group {
                        switch shape {
                        case .cube:
                            Text("• 6 square faces\n• 12 edges\n• 8 vertices")
                        case .pyramid:
                            Text("• Polygonal base\n• Triangular sides\n• Apex vertex")
                        case .cone:
                            Text("• Circular base\n• Curved surface\n• Apex vertex")
                        case .sphere:
                            Text("• Perfectly symmetrical\n• No edges/vertices\n• Constant curvature")
                        case .cylinder:
                            Text("• Two parallel bases\n• Curved lateral surface\n• Constant cross-section")
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
 
                Spacer()
            }
            .padding()
        }
    }
}
 
