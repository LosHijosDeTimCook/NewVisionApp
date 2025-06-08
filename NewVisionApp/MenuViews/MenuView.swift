//
//  MenuView.swift
//  NewVisionApp
//
//  Created by Alumno on 07/06/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct MenuView: View {
    @Environment(\.dismissWindow) var closeWindow
    @Environment(\.openWindow) var openWindow
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(AppModel.self) private var appModel
    
    @State var isRotate:Bool = false
    
    var body: some View {
        VStack{
            Text("Math")
                .font(.custom("Candy Beans", size: 120) )
                .shadow(color:Color.yellow,radius: 10)
            
            Model3D(named: "Math", bundle: realityKitContentBundle)
              //  .rotationEffect(Angle(degrees:isRotate ? 360:0))
                .rotation3DEffect(.degrees(isRotate ? 360:1), axis: (x: 1, y: 1, z: 1))
                
                .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: isRotate)
                .padding()
            Button{
                Task{
                    openWindow(id: "ContentViewMath")
                }
              
            }label:{
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 90))
                    .shadow(color:.yellow,radius: 10)
                
            }.buttonStyle(.plain)
             .offset(x:0,y:80)
            
        }
        .offset(y:-60)
        .onAppear{
            isRotate = true
            openWindow(id:"Physicsview")
            openWindow(id:"ChemistryView")
            closeWindow(id:"contentView")
        }
      
    }
}




#Preview {
    MenuView()
}
