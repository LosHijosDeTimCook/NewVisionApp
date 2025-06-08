//
//  PhysicsBeachTab.swift
//  NewVisionApp
//
//  Created by Rigoberto Said Soto Quiroga on 08/06/25.
//

import SwiftUI

struct PhysicsBeachTab: View {
    var body: some View {
        VStack {
            Text("Al tener un menor peso que la bola pasada, la resistencia de la pelota de playa sea mucho menor, haciendo que llegue después que la bola de bolche")
                .font(.system(size: 40,design: .rounded))
                .multilineTextAlignment(.center)
        }.padding()
    }
}



#Preview {
    PhysicsBeachTab()
}
