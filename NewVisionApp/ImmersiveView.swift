import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @Environment(\.openWindow) private var openWindow
    @State private var immersiveEntity: Entity?

    var body: some View {
        RealityView { content in
            // Si la entidad está cargada, la agregamos
            if let entity = immersiveEntity {
                content.add(entity)
            }
        }
        .task {
            // Cargar la entidad asíncronamente en background
            do {
                immersiveEntity = try await Entity(named: "Immersive", in: realityKitContentBundle)
            } catch {
                print("Error cargando entidad: \(error)")
            }
        }
        .onAppear {
            // Abrir ventana inmediata justo al entrar a la escena
            openWindow(id: "PhysicsImmediateTab")
        }
    }
}
