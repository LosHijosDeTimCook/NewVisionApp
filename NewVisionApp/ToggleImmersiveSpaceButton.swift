import SwiftUI
 
struct ToggleImmersiveSpaceButton: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @State private var isProcessing = false
 
    var body: some View {
        Button {
            guard !isProcessing else { return }
 
            isProcessing = true
            print("Button pressed, current state: \(appModel.immersiveSpaceState)")
 
            Task { @MainActor in
                switch appModel.immersiveSpaceState {
                case .open:
                    appModel.immersiveSpaceState = .inTransition
                    print("Dismissing immersive space...")
                    await dismissImmersiveSpace()
                    appModel.immersiveSpaceState = .closed
                    appModel.showImmersiveSpace = false
 
                case .closed:
                    appModel.immersiveSpaceState = .inTransition
                    appModel.showImmersiveSpace = true
                    print("Opening immersive space...")
                    let result = await openImmersiveSpace(id: appModel.immersiveSpaceID)
                    print("Open result: \(result)")
 
                    switch result {
                    case .opened:
                        appModel.immersiveSpaceState = .open
                    case .userCancelled, .error:
                        appModel.immersiveSpaceState = .closed
                        appModel.showImmersiveSpace = false
                    @unknown default:
                        appModel.immersiveSpaceState = .closed
                        appModel.showImmersiveSpace = false
                    }
 
                case .inTransition:
                    // No action needed during transition
                    break
 
                case .opening, .closing:
                    // Handle transitional states
                    break
                    
          
                }
 
                isProcessing = false
                print("Final state: \(appModel.immersiveSpaceState)")
            }
        } label: {
            Text(
                appModel.immersiveSpaceState == .open ? "Hide Immersive Space" :
                appModel.immersiveSpaceState == .closed ? "Show Immersive Space" :
                "Processing..."
            )
            .font(.system(size: 50))
            .bold()
        }
        .disabled(isProcessing || appModel.immersiveSpaceState != .open && appModel.immersiveSpaceState != .closed)
        .fontWeight(.semibold)
    }
}
