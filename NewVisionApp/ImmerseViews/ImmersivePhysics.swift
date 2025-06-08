//
//  ImmersivePhysics.swift
//  NewVisionApp
//
//  Created by Alumno on 08/06/25.
//


import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersivePhysics: View {
    @Environment(\.dismissWindow) var closeWindow
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)
                
                
                // Put skybox here.  See example in World project available at
                // https://developer.apple.com/
            }
        }.onAppear {
            closeWindow(id: "Physicsview")
            closeWindow(id: "ChemistryView")
            closeWindow(id: "MathView")
            closeWindow(id: "MessageView")
        }
    }
}

#Preview {
    ImmersivePhysics()
}
