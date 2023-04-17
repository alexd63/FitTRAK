//
//  TRAKView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/16/23.
//

import Foundation
import SwiftUI

struct TRAKView: View {
    private var cornerSectionsSize = CGSize(width: 15, height: 15)
    private var frameSectionsWidth = CGFloat(350)
    private var frameSectionsHeight = CGFloat(150)
    private var navigationViewDetails = NavigationViewDetails(title: "TRAK", leadingToolbarItem: "gear", trailingToolbarItem: "person.fill")
    
    var body: some View{
        ZStack{
            NavigationView{
                VStack{
                    RoundedRectangle(cornerSize: cornerSectionsSize)
                        .frame(width: frameSectionsWidth, height: frameSectionsHeight)
                    Text("This is the TRAK Page")
                }
                .navigationTitle(navigationViewDetails.title)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Button(action: {
                            print("placeholder print")
                        }, label: {
                            Image(systemName: navigationViewDetails.leadingToolbarItem)
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            print("profile button")
                        }, label: {
                            Image(systemName: navigationViewDetails.trailingToolbarItem)
                        })
                    }
                }
                
            }
            
        }
    }
}

struct TRAKView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
