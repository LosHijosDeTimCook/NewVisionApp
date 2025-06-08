//
//  SecondView.swift
//  NewVisionApp
//
//  Created by Rigoberto Said Soto Quiroga on 07/06/25.
//

import SwiftUI

struct PhysicsBowlingTab: View {
    @Environment(\.dismissWindow) var closeWindow
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    var body: some View {
        VStack {
            Text("Al tener un mayor peso, hace que la resistencia de la bola de boliche sea mucho menor, haciendo que consiga una alta velocidad terminal")
                .font(.system(size: 40,design: .rounded))
                .multilineTextAlignment(.center)
            Button{
                Task {
                    await dismissImmersiveSpace()
                    closeWindow(id:"PhysicsBeachTab")
                    closeWindow(id:"PhysicsBowlingTab")
                    openWindow(id: "MathView")
                    
                }
            }label: {
                Text("Back")
                    .font(.largeTitle)
            }
            .padding()
        }.padding()
    }
}



#Preview {
    PhysicsBowlingTab()
}
