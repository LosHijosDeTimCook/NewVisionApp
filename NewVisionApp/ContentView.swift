//
//  ContentView.swift
//  NewVisionApp
//
//  Created by Alumno on 07/06/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

let gradient:[Color] = [
    Color.blue,
    Color.purple
]
struct ContentView: View {

    @Environment(\.dismissWindow) var closeWindow
    @Environment(\.openWindow) var openWindow
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
            ZStack{
                
                Image("logo")
                    .resizable()
                    .frame(width: 700,height: 700)
                    .offset(y:-80)
                    .shadow(color:.black,radius: 1)
            
                Content()
                
            }
        
            
    }
}


struct Content:View {
    @State var star_animation:Bool = false
    @Environment(\.openWindow) var openWindow
    var body: some View {
        
            VStack{
                Text("AcademIQ")
                    .font(.custom("Candy Beans", size: 120) )
                    .offset(x: 0, y: 180)
                    .shadow(color:.black,radius: 15)
                ZStack{
                    
                    Circle()
                        .stroke(lineWidth: 10)
                        .frame(width: 100,height: 100)
                        .scaleEffect(star_animation ? 1.2 : 0.8)
                        .offset(y:110)
                        .animation(.linear(duration: 1.25).repeatForever(autoreverses: true), value: star_animation)

                  //  NavigationLink(destination: MenuView()) {
                      //      Image(systemName: "play.fill")
                     //           .font(.system(size: 60))
                     //
                     //   }.buttonStyle(PlainButtonStyle())
                     //   .offset(y:110)
                    Button{
                        openWindow(id:"MathView")
                    }label:{
                        Image(systemName: "play.fill")
                            .font(.system(size: 50))
                      //           .font(.system(size: 60))
                    }.buttonStyle(PlainButtonStyle())
                      .offset(y:110)

                 //   ToggleImmersiveSpaceButton()
                   
                        
                }
               
                
            }.onAppear {
                star_animation = true
            }
        
        
        
        
    }
    
}


struct MainView:View {
    var body: some View {
        Text("Hello, world!")
    }
}
    
