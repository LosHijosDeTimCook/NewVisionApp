//
//  QuimicaView.swift
//  NewVisionApp
//
//  Created by Alumno on 07/06/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct QuimicaView: View {
 
    @State var isRotate:Bool = false
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    var body: some View {
        
        VStack{
            Text("Chemistry")
                .font(.custom("Candy Beans", size: 120) )
                .shadow(color:Color.green,radius: 10)
            Model3D(named: "Molecule", bundle: realityKitContentBundle)
                .rotation3DEffect(.degrees(isRotate ? 359:0), axis: (x: 1, y: 1, z: 1))
                .animation(.linear(duration: 3).repeatForever(autoreverses: true), value: isRotate)
                .padding()
            Button{
                Task{
                    await openImmersiveSpace(id: "chemistrySpace")
                }
            }label:{
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 90))
                    .shadow(color:.green,radius: 10)
            }.buttonStyle(.plain)
                .offset(x:0,y:80)
            
        }
        .offset(y:-60)
        .onAppear{
            isRotate = true
            
        }
    }
}

#Preview {
    QuimicaView()
}
