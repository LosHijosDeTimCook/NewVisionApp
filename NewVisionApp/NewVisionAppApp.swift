//
//  NewVisionAppApp.swift
//  NewVisionApp
//
//  Created by Alumno on 07/06/25.
//

import SwiftUI

@main
struct NewVisionAppApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup(id: "main") {
            ContentView().environment(appModel)
        }
        
        WindowGroup(id: "PhysicsBowlingTab") {
            PhysicsBowlingTab()
        }
        .defaultSize(width: 200, height: 200) // Cambia a lo que necesites
        
        WindowGroup(id: "PhysicsBeachTab") {
            PhysicsBeachTab()
        }
        .defaultSize(width: 200, height: 200) // Cambia a lo que necesites
        
        WindowGroup(id: "PhysicsImmediateTab") {
            PhysicsImmediateTab()
        }
        .defaultSize(width: 400, height: 300) // Ajusta a tu gusto



        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
     }
}
