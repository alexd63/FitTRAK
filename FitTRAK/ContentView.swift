//
//  ContentView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/16/23.
//

import SwiftUI



struct ContentView: View {
    var body: some View {

        ZStack{
            TabView {
                TRAKView()
                    .tabItem{
                        Text("TRAK")
                        Image(systemName: "bolt")
                        
                    }
                FitnessView()
                    .tabItem{
                        Text("Fitness")
                        Image(systemName: "figure.run")
                    }
            }
            .background(Color.green)
            //        .tint(Color.green) //non soon-to-be deprecated version of .accentColor()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
