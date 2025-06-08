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
        WindowGroup(id:"contentView") {
            ContentView()
                .environment(appModel)
        }
        
        WindowGroup(id:"MessageView") {
            MessageLevelPhysics()
                .environment(appModel)
        }.defaultSize(width: 100, height: 100)
        
        WindowGroup(id:"PhysicsBeachTab") {
            PhysicsBeachTab()
                .environment(appModel)
        }.defaultWindowPlacement { content, context in
            guard let contentWindow = context.windows.first(where: { $0.id == "PhysicsBowlingTab" }) else { return WindowPlacement(nil)
            }
            return WindowPlacement(.trailing(contentWindow))
        }
        .defaultSize(width: 800, height: 400)
        
        WindowGroup(id:"PhysicsBowlingTab") {
          PhysicsBowlingTab()
                .environment(appModel)
        }.defaultSize(width: 800, height: 400)
        
        
        
        WindowGroup(id:"MathView") {
            MenuView()
                .environment(appModel)
        }
        
        WindowGroup(id:"ContentViewMath") {
            ContentViewMath()
                .environment(appModel)
               
        }

        WindowGroup(id:"Physicsview"){
            PhysicsView()
                .environment(appModel)
        }.defaultWindowPlacement { content, context in
            guard let contentWindow = context.windows.first(where: { $0.id == "MathView" }) else { return WindowPlacement(nil)
            }
            return WindowPlacement(.trailing(contentWindow))
        }
        
        WindowGroup(id:"ChemistryView") {
            QuimicaView()
                .environment(appModel)
        }.defaultWindowPlacement { content, context in
            guard let contentWindow = context.windows.first(where: { $0.id == "MathView" }) else { return WindowPlacement(nil)
            }
            return WindowPlacement(.leading(contentWindow))
        }
        

        ImmersiveSpace(id: appModel.immersiveSpaceID){
           ImmersiveViewMath()
                .environment(appModel)
        }
       
        ImmersiveSpace(id:"physicSpace"){
            ImmersivePhysics()
                .environment(appModel)
        }
        
        ImmersiveSpace(id:"chemistrySpace"){
            ImmersiveChemistry()
                .environment(appModel)
        }
        
        
        
        
     }
}

#Preview (windowStyle:.automatic){
    ContentView()
        .environment(AppModel())
}
