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
    @State var calories = 0.0
    
    
   
    var body: some View {
        VStack {
            calcServings()
        }
        .onChange(of: servingAmount) { newValue in
            servingAmountNum = Double(newValue)
        }
        .onChange(of: servingSize) { newValue in
            servingSizeNum = Double(newValue)
            calories = (foodFacts.barcodeData?.productData.nutrients.energyKcal100g ?? 0.0) / 100
            calories = calories * (Double(servingAmount) ?? 0.0) * (Double(servingSize) ?? 0.0)

        }
        
    }
    
    enum SelectionChoice: String {
        case package = "Package"
        case custom = "Custom"
    }
    
    func calcServings() -> some View {
        VStack {
            List {
                if foodFacts.barcodeData?.productData.servingSize != nil {
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
                }
                Section{
                    if selection == "Package" {
                        Text("Carbs: \(Int(foodFacts.barcodeData?.productData.nutrients.carbohydratesServing ?? 0) * Int(servingAmountNum ?? 0) )")
                        
                        Text("Fats: \(Int(foodFacts.barcodeData?.productData.nutrients.fatServing ?? 0) * Int(servingAmountNum ?? 0) )")
                        
                        Text("Proteins: \(Int(foodFacts.barcodeData?.productData.nutrients.proteinsServing ?? 0) * Int(servingAmountNum ?? 0) )")
                    }
                    else {
                        Text("Calories: \(calories)")

                        Text("Carbs: \(Int(foodFacts.barcodeData?.productData.nutrients.carbohydrates100g ?? 0) * Int(servingAmountNum ?? 0) )")
                        
                        Text("Fats: \(Int(foodFacts.barcodeData?.productData.nutrients.fat100g ?? 0) * Int(servingAmountNum ?? 0) )")
                        
                        Text("Proteins: \(Int(foodFacts.barcodeData?.productData.nutrients.proteins100g ?? 0) * Int(servingAmountNum ?? 0) )")
                    }
                    
                }
                
                
            }
            Button {
                print("este")
            } label: {
                Circle()
                    .frame(width: 20)
            }
        }
    }
}



struct AddFoodLogView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodLogView(foodFacts: FoodFactsViewModel())
    }
}
