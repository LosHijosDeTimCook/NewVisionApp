import SwiftUI

struct ToggleImmersiveSpaceButton: View {

    @Environment(AppModel.self) private var appModel

    var body: some View {
        Button {
            // Ya no hace nada relacionado con Immersive Space
            print("El botón fue presionado, pero el espacio inmersivo ya no se abrirá.")
        } label: {
            Text("Mostrar simulación") // Puedes cambiar el texto si lo deseas
        }
        .disabled(appModel.immersiveSpaceState == .inTransition)
        .animation(.none, value: 0)
        .fontWeight(.semibold)
    }
}
