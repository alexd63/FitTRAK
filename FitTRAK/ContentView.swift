//
//  ContentView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/16/23.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        TabView {
            TRAKView()
                .tabItem{
                    Text("TRAK")
                        
                }
            FitnessView()
                .tabItem{
                    Text("Fitness")
                }
        }        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
