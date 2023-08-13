////
////  SelectedFoodView.swift
////  FitTRAK
////
////  Created by Alex Diaz on 5/9/23.
////
//
//import SwiftUI
//
//struct SelectedFoodView: View {
//    @ObservedObject var foodFactsVM: FoodFactsViewModel
//    var isBarcode: () -> Bool?
//    let barcode: String? = nil
//    
//    var body: some View {
//        
//
//            return VStack {
//                Text("\(foodFactsVM.barcodeData?.productData.productName ?? "")")
//            }
//            .task {
//                await foodFactsVM.getData(userInput: barcode, isBarcode: isBarcode())
//            }
//        }
//
//}
//
//
//struct SelectedFoodView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedFoodView()
//    }
//}
