//
//  LogView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 5/5/23.
//

import SwiftUI

struct LogView: View {
    @State var query = ""
    @StateObject var foodFactsVM = FoodFactsViewModel()
    @State var showingSheet = false
    
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                TextField("Search for Food or Enter Barcode #", text: $query)
                    .onSubmit{
                        foodFactsVM.didFail = false
                        if query.rangeOfCharacter(from: .whitespaces) != nil {
                            query = query.replacingOccurrences(of: " ", with: "+")
                        }
                        submitData()
                    }
//                    .onChange(of: query, perform: { _ in
//                        submitData()
//                    })

                    .padding(.top, 7)
                Spacer()
            }
            
                itemSearch()
            
//            returnData() //the barcode data
            
            Spacer()
           
        }
    }
    
    
    func isBarcode(input: String) -> Bool {
        if (input.rangeOfCharacter(from: CharacterSet.letters) == nil){
            return true
        } else {
            return false
        }
    }
    
    func itemSearch() -> some View {

        return VStack{
            if query.isEmpty {
                Text("IS DATA VALID: N/A")
                
            }
            
//            else{
//                Text("IS DATA VALID: \(foodFactsVM.isDataValid?.description ?? "false")")
//            }
//
            
            List() {
                
                if !foodFactsVM.didFail {
                    ForEach(foodFactsVM.nameSearch?.products ?? []){ product in
                    
                        NavigationLink {
                                selectedFood(barcode: product.barcode ?? "")
                                .toolbar {
                                    Button("Log") {
                                        showingSheet.toggle()
                                    }
                                    .sheet(isPresented: $showingSheet, content: {
                                        AddFoodLogView(foodFacts: foodFactsVM)
                                    })

                                    
                                    .foregroundColor(.blue)
                                }
                            } label: {
                                VStack (alignment: .leading){
                                    Text("Name: \(product.productName ?? "not found")")
                                    Text("KCAL (100g): \(product.nutrients.energyKcal100g?.description ?? "N/A")")
                                }

                            }

                    }
                }
                else {
                    Text("ERROR: Invalid or reenter. (Currently more than one word queries not working. Fix))")
                }
            }
        }
    }
    
    func selectedFood(barcode: String) -> some View {

        return VStack {
//            Text("\(foodFactsVM.barcodeData?.productData.productName ?? "")")
            returnData()
        }
        .task {
            await foodFactsVM.getData(userInput: barcode, isBarcode: isBarcode(input: barcode))
        }
    }
    
    func submitData(barcode: String? = nil) {
        var input = query
//        if query.rangeOfCharacter(from: CharacterSet.letters) != nil {
//            input = barcode ?? "test"
//        }

        Task {
            await foodFactsVM.getData(userInput: input, isBarcode: isBarcode(input: barcode ?? query))
        }
    }
    
    func returnData() -> some View {
        let productData = foodFactsVM.barcodeData?.productData
        return List {
            Section{
                Text("Brand: \(productData?.brands ?? "N/A")")
                Text("Product Name: \(productData?.productName ?? "N/A")")
                Text("Generic Name: \(productData?.genericName ?? "N/A")")
                Text("Category: \(productData?.categories ?? "N/A")")
                
            }
            Section("PER 100 Grams/ML") {
                HStack{
                    Text("Calories: \(productData?.nutrients.energyKcal100g?.formatted() ?? "N/A")")
                    Text("\(productData?.nutrients.energyKcalUnit ?? "")")
                }
                HStack{
                    Text("Total Fats: \(productData?.nutrients.fat100g?.formatted() ?? "N/A")")
                    Text("\(productData?.nutrients.fatUnit ?? "")")
                }
                
                HStack{
                    Text("Carbs: \(productData?.nutrients.carbohydrates100g?.formatted() ?? "N/A")")
                    Text("\(productData?.nutrients.carbohydratesUnit ?? "")")
                }
                
                
                HStack {
                    Text("Proteins: \(productData?.nutrients.proteins100g?.formatted() ?? "N/A")")
                    Text("\(productData?.nutrients.proteinsUnit ?? "")")
                }
                
            }
            
            Section("PACKAGE SERVING \(productData?.servingSize ?? "???") | PACKAGE TOTAL \(productData?.quantity ?? "???")") {
                
                HStack {
                    Text("Calories: \(productData?.nutrients.energyKcalServing?.formatted() ?? "N/A")")
                    Text("\(productData?.nutrients.energyKcalUnit ?? "")")
                }

                HStack {
                    Text("Total Fats: \(productData?.nutrients.fatServing?.formatted() ?? "N/A")")
                    Text("\(productData?.nutrients.fatUnit ?? "")")
                }

                HStack {
                    Text("Carbs: \(productData?.nutrients.carbohydratesServing?.formatted() ?? "N/A")")
                    Text("\(productData?.nutrients.carbohydratesUnit ?? "")")
                }

                HStack {
                    Text("Proteins: \(productData?.nutrients.proteinsServing?.formatted() ?? "N/A")")
                    Text("\(productData?.nutrients.proteinsUnit ?? "")")
                }
                
                

                
            }
            Section{
                Text("BARCODE: \(foodFactsVM.barcodeData?.code ?? "UNKNOWN")")
            }
            .navigationTitle("\(productData?.productName ?? "name: not found")")
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
