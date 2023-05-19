//
//  ChartView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/28/23.
//

import SwiftUI

struct ChartView: View {
    let values: [Int]
    let labels: [String]
    let xAxisLabels: [String]
    var containsData: Bool
    
    init(values: [Int], labels: [String], xAxisLabels: [String]) {
        self.values = values
        self.labels = labels
        self.xAxisLabels = xAxisLabels
        self.containsData = values.contains(where: { $0 > 0 })
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center){
//                TabView {
//                    RoundedRectangle(cornerRadius: 5)
//                    RoundedRectangle(cornerRadius: 5)
//                    RoundedRectangle(cornerRadius: 5)
//                }
//                .tabViewStyle(PageTabViewStyle())
                HStack(alignment: .bottom) {
                    
                    if values.contains(where: {$0 > 0}){ //checks if at least one value is in list
                        ForEach(0..<values.count) {index in
                        
                        
                        ZStack{
                            
                            Rectangle()
                                .frame(maxWidth: geometry.size.width / 10, maxHeight: .infinity)
                            
                            let max = values.max() ?? 0
                            
                            VStack {
                                Text("\(values[index])")
                                    .customFont(size: 15)
                                    .rotationEffect(.degrees(0))
                                    .foregroundColor(Color.white)
                                
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(Color.orange)
                                    .frame(width: 20, height: CGFloat(values[index]) / CGFloat(max) * geometry.size.height * 0.6)
                                    .padding(.top)
                                
                                Text(xAxisLabels[index])
                                    .customFont(size: 12)
                                    .foregroundColor(Color.white)
                                //                                .font(.caption)
                            }
                        }
                        
                    }
                }
                    else{
                        ZStack{
                            Rectangle()
                                .foregroundColor(Color.black)
                                .opacity(0.15)
                                .blur(radius: 40)
                            Text("NO DATA")
                        }
                        
                    }
                    

                        
                }.frame(maxWidth: geometry.size.width * 0.95, maxHeight: .infinity)
                    .background(Color.primary.opacity(0.6))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let values = [213, 343, 3, 3, 344, 435, 342, 30]
        let labels = ["213", "343", "3", "3", "344", "435", "342", "30"]
        let xAxisValues = [ "May 30", "May 31", "June 1", "June 2", "June 3", "June 4", "June 5", "June 6"]
        ChartView(values: values, labels: labels, xAxisLabels: xAxisValues)
    }
}
