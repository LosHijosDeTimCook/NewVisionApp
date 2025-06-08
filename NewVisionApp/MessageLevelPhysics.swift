//
//  MessageLevelPhysics.swift
//  NewVisionApp
//
//  Created by Alumno on 08/06/25.
//

import SwiftUI

struct MessageLevelPhysics: View {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissWindow) var closeWindow
    @Environment(\.openWindow) var openWindow
    
    
    var body: some View {
        VStack{
            Text("Para iniciar con la simulación, presiona iniciar")
                .multilineTextAlignment(.center)
            Button{
                Task{
                    await openImmersiveSpace(id: "physicSpace")
                    // Espera 1 segundo más (total 6 segundos)
                    try await Task.sleep(nanoseconds: 2_000_000_000)
                    openWindow(id: "PhysicsBowlingTab")
                    
                    try await Task.sleep(nanoseconds: 1_500_000_000)
                    openWindow(id: "PhysicsBeachTab")
                    
                    
                }
                
            }label: {
                Text("Iniciar")
            }
        }.onAppear{
            closeWindow(id: "Physicsview")
            closeWindow(id: "ChemistryView")
            closeWindow(id: "MathView")
        }
        
    }
}

#Preview {
    MessageLevelPhysics()
}
