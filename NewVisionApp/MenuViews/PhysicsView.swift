//
//  PhysicsView.swift
//  NewVisionApp
//
//  Created by Alumno on 07/06/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct PhysicsView: View {
    @State var start_animation:Bool = false
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissWindow) var closeWindow
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        VStack{
            Text("Physics")
                .font(.custom("Candy Beans", size: 120) )
                .shadow(color:Color.blue,radius: 10)
            
            Model3D(named: "Physics", bundle: realityKitContentBundle)
                .rotation3DEffect(.degrees(90), axis: (x: 0.3, y: 1, z:start_animation ? 0.5:0))
                .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: start_animation)
                .offset(x:start_animation ? 260:-260,y:0)
            
                .padding()
            Button{
                Task{
                    openWindow(id:"MessageView")
                    
                }
                
                
            }label:{
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 90))
                    .shadow(color:.blue,radius: 10)
            }.buttonStyle(.plain)
                .offset(x:0,y:80)
            
        }
        .offset(y:-60)
        .onAppear{
            start_animation = true
        }
    }
}

#Preview {
    PhysicsView()
}
