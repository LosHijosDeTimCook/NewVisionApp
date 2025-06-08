import SwiftUI
import Observation
 
@Observable class AppModel {
    var immersiveSpaceID = "ImmersiveSpace"
    var immersiveSpaceState: ImmersiveSpaceState = .closed
    var showImmersiveSpace = false
 
 
    enum ImmersiveSpaceState {
        case closed
        case opening
        case open
        case closing
        case inTransition
    }
 
    func reset() {
        immersiveSpaceState = .closed
        showImmersiveSpace = false
    }
}
