//
//  AddFoodLogView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 5/14/23.
//

import SwiftUI

struct AddFoodLogView: View {
    @ObservedObject var foodFacts: FoodFactsViewModel
    @State private var servingAmount = ""
    @State private var servingSize = ""
    @State var servingAmountNum: Double?
    @State var servingSizeNum: Double?
    @State var selectionList = ["Package", "Custom"]
    var unitMeasure = ["g/ml", "100g/ml"]
    @State private var unitSelection = "g/ml"
    @State var selection = SelectionChoice.package.rawValue

   
    var body: some View {
        VStack {
            calcServings()
                            
        }
        .onChange(of: servingAmount) { newValue in
            servingAmountNum = Double(newValue)
        }
        .onChange(of: servingSize) { newValue in
            servingSizeNum = Double(newValue)
        }
        
    }
    
    enum SelectionChoice: String {
        case package = "Package"
        case custom = "Custom"
    }
    
    func calcServings() -> some View {
        List {
            Section("Serving"){
                Picker("How to calculate serving", selection: $selection) {
                    ForEach(selectionList, id: \.self) { sectionName in
                        Text(sectionName).tag(sectionName)
                    }
                }.pickerStyle(.segmented)
                

                if selection == SelectionChoice.package.rawValue{
                    HStack{
                        Text("No. of Servings:")
                        Spacer()
                        TextField("Enter amount", text: $servingAmount)
                            .keyboardType(.decimalPad)
                        Spacer()
                    }
                }
                else if selection == SelectionChoice.custom.rawValue {
                    HStack{
                        Text("No. of Servings:")
                        Spacer()
                        TextField("Enter amount", text: $servingAmount)
                            .keyboardType(.decimalPad)
                        Spacer()
                    }
                    Picker("Unit Measurement", selection: $unitSelection) {
                        ForEach(unitMeasure, id: \.self) { unit in
                            Text(unit).tag(unit)
                        }
                    }
                    HStack{
                        Text("Serving Size:")
                            .padding(.trailing)
                        TextField("Enter amount", text: $servingSize)
                    }
                }
            }
            Section{
                Text("Calories: \(Int(foodFacts.barcodeData?.productData.nutrients.energyKcalServing ?? 0) * Int(servingAmountNum ?? 0) )")
                Text("Carbs: \(Int(foodFacts.barcodeData?.productData.nutrients.energyKcalServing ?? 0) * Int(servingAmountNum ?? 0) )")

                Text("Fats: \(Int(foodFacts.barcodeData?.productData.nutrients.energyKcalServing ?? 0) * Int(servingAmountNum ?? 0) )")

                Text("Proteins: \(Int(foodFacts.barcodeData?.productData.nutrients.energyKcalServing ?? 0) * Int(servingAmountNum ?? 0) )")

            }
        }
    }
}



struct AddFoodLogView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodLogView(foodFacts: FoodFactsViewModel())
    }
}
