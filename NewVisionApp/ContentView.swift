import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @Environment(\.dismissWindow) var closeWindow
    @Environment(\.openWindow) var openWindow
    @Environment(AppModel.self) private var appModel

    var body: some View {
        VStack {
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)

            Text("Vision Pro demo app")

            ToggleImmersiveSpaceButton()
        }
        .padding()
        .onChange(of: appModel.immersiveSpaceState) { _, newState in
            if newState == .open {
                // Cierra la ventana principal
                closeWindow(id: "main")
            }
        }
    }
}

// Preview con environment
#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
