//
//  ChartView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/28/23.
//

import SwiftUI

struct MacrosChart: View {
    var activity: Activity
    var repository: HKRepository
    @ObservedObject var viewModel: DetailViewModel
//    let values: [Int]
//    let labels: [String]
//    let xAxisLabels: [String]
    let macrosNames: [String]
//    @Published var stats = [HealthStat]()

//    var containsData: Bool
    
    init(activity: Activity, repository: HKRepository, viewModel: DetailViewModel) {
//        self.values = values
//        self.labels = labels
//        self.xAxisLabels = xAxisLabels
        self.activity = activity
        self.repository = repository
        self.viewModel = viewModel
        self.macrosNames = ["Fats", "Carbs", "Proteins"]
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center){
//                Text("TEST")
//                Text("\(activity.id)")
                TabView{
                    ForEach(macrosNames.indices, id: \.self){ index in
                        let filteredStats = viewModel.stats.filter({$0.statType == macrosNames[index]})
                        if !filteredStats.isEmpty{ //checks if at least one value is in list
                            
                            ForEach(0..<2, id: \.self) {index in
                                
                                
                                ZStack{
                                    
                                    Rectangle()
                                        .frame(maxWidth: geometry.size.width / 10, maxHeight: .infinity)
                                    
//                                    let max = values.max() ?? 0
                                    
                                    VStack {
//                                        Text("\(values[index])")
////                                            .customFont(size: 15)
////                                            .rotationEffect(.degrees(0))
////                                            .foregroundColor(Color.white)
                                        
                                        
//                                        RoundedRectangle(cornerRadius: 5)
//                                            .foregroundColor(Color.orange)
//                                            .frame(width: 20, height: CGFloat(values[index]) / CGFloat(20) * geometry.size.height * 0.6)
//                                            .padding(.top)
//
//                                        Text(xAxisLabels[index])
//                                            .customFont(size: 12)
//                                            .foregroundColor(Color.white)
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
                    }
                    

                        
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(maxWidth: geometry.size.width * 0.95, maxHeight: .infinity)
                    .background(Color.primary.opacity(0.6))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct MacrosChart_Previews: PreviewProvider {
    static var previews: some View {
        let values = [213, 343, 3, 3, 344, 435, 342, 30]
        let labels = ["213", "343", "3", "3", "344", "435", "342", "30"]
        let xAxisValues = [ "May 30", "May 31", "June 1", "June 2", "June 3", "June 4", "June 5", "June 6"]
        ChartView(values: values, labels: labels, xAxisLabels: xAxisValues)
    }
}
