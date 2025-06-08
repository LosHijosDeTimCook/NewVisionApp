import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveChemistry: View {
    @Environment(\.dismissWindow) var closeWindow
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    @State private var modelOffset = CGSize.zero
    @State private var modelRotationAngle: Angle = .zero
    @State private var modelScale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Model3D(named: "Molecule", bundle: realityKitContentBundle)
                .scaleEffect(modelScale)
                .rotationEffect(modelRotationAngle)
                .offset(modelOffset)
                .gesture(
                    SimultaneousGesture(
                        // Drag gesture for moving the model
                        DragGesture()
                            .onChanged { value in
                                modelOffset = value.translation
                            }
                            .onEnded { _ in
                                // Keep the final position
                            },
                        
                        // Rotation gesture
                        RotationGesture()
                            .onChanged { angle in
                                modelRotationAngle = angle
                            }
                            .onEnded { _ in
                                // Keep the final rotation
                            }
                    )
                )
                .gesture(
                    // Magnification gesture for scaling
                    MagnifyGesture()
                        .onChanged { value in
                            modelScale = value.magnification
                        }
                        .onEnded { _ in
                            // Keep the final scale
                        }
                )
                .padding(.bottom, 50)
            VStack(spacing: 10) {
                
                Button("Reset Position") {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        modelOffset = .zero
                        modelRotationAngle = .zero
                        modelScale = 1.0
                    }
                }
                .padding(.top, 10)
            }
            
            Button{
                Task{
                    await dismissImmersiveSpace()
                    openWindow(id:"MathView")
                    
                }
            }label: {
                Text("Back")
            }
        }
        .onAppear{
            closeWindow(id:"Physicsview")
            closeWindow(id:"ChemistryView")
            closeWindow(id:"MathView")
        }
        .padding()
    }
}
#Preview(windowStyle: .automatic) {
    ImmersiveChemistry()
        .environment(AppModel())
}
