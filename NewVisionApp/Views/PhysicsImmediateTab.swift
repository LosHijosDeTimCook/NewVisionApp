//
//  PhysicsImmediateTab.swift
//  NewVisionApp
//
//  Created by Rigoberto Said Soto Quiroga on 07/06/25.
//

import SwiftUI

struct PhysicsImmediateTab: View {
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        VStack(spacing: 20) {
            Text("Para comenzar con la simulación de caída libre, pulsa iniciar")
                .font(.title)
                .padding()

            Button(action: {
                Task {
                    // Cierra la ventana actual
                    dismissWindow()

                    // Espera 2 segundos
                    try await Task.sleep(nanoseconds: 2_000_000_000)
                    openWindow(id: "PhysicsBowlingTab")

                    // Espera 1 segundo más (total 6 segundos)
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    openWindow(id: "PhysicsBeachTab")
                }
            }) {
                Text("Iniciar")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
    }
}

struct PhysicsImmediateTab_Previews: PreviewProvider {
    static var previews: some View {
        PhysicsImmediateTab()
    }
}
