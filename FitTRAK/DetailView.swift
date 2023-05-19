//
//  DetailView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/28/23.
//

import SwiftUI

struct DetailView: View {
    
    var activity: Activity
    var repository: HKRepository
    @ObservedObject var viewModel: DetailViewModel
    
    init(activity: Activity, repository: HKRepository) {
        self.activity = activity
        self.repository = repository

        viewModel = DetailViewModel(activity: activity, repository: repository)
    }
    var body: some View {
        if activity.id != "Macros"{
            ChartView(values: viewModel.stats.map {viewModel.value(from: $0.stat).value}, labels: viewModel.stats.map {viewModel.value(from: $0.stat).desc}, xAxisLabels: viewModel.stats.map {DetailViewModel.dateFormatter.string(from: $0.date)})
            
            List(viewModel.stats) { stat in
                VStack(alignment: .leading) {
                    Text(viewModel.value(from: stat.stat).desc)
                    Text(stat.date, style: .date).opacity(0.5)
                }
            }
        }
        else {
            MacrosChart(activity: activity, repository: repository, viewModel: viewModel)
            
            List(viewModel.stats) { stat in
                VStack(alignment: .leading) {
                    Text(viewModel.value(from: stat.stat).desc)
                    Text(stat.date, style: .date).opacity(0.5)
                }
            }

        }
        

    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(activity: Activity(id: "Steps", name: "Steps", image: "Stepsimage"), repository: HKRepository())
    }
}
