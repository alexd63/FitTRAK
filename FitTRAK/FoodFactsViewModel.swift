//
//  FoodFactsViewModel.swift
//  FitTRAK
//
//  Created by Alex Diaz on 5/5/23.
//

import Foundation

class FoodFactsViewModel: ObservableObject {
    
//    private var isBarcode: Bool
//
//    init(isBarcode: Bool) {
//        self.isBarcode = isBarcode
//    }
    
    @Published var barcodeData: BarcodeData?
    @Published var nameSearch: NameSearch?
    @Published var didFail = false

    
    struct BarcodeData: Codable {
        var code: String?
        var statusVerbose: String?
        var productData: ProductData
        
        //you have to include all cases even if not changing CodingKey
        enum CodingKeys: String, CodingKey {
            case code
            case statusVerbose = "status_verbose"
            case productData = "product"
        }
    }
    
    //for barcode
    struct ProductData: Codable {
        var id: String?
        var keywords: [String]?
        var brands: String?
        var categories: String?
        var genericName: String?
        var productName: String?
        var serving_quantity: String?
        var servingSize: String?
//        var serving_size_imported: String?
        var quantity: String?
//        var quantity: String?
        var nutrients: Nutrients
//        var ownerFields: OwnerFields?
//        var packagings: Packagings?


        
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case keywords
            case brands
            case categories
            case genericName = "generic_name"
            case productName = "product_name_en"
            case nutrients = "nutriments"
            case servingSize = "serving_size"
//            case ownerFields = "owner_fields"
//            case packagings = " packagings"
            case quantity


        }
    }
    
    //for barcode
    struct Nutrients: Codable {
        var carbohydrates100g: Double?
        var carbohydratesServing: Double?
        var carbohydratesUnit: String?
        
        var sugars100g: Double?
        var sugarsServing: Double?
        var sugarsUnit: String?
        
        var energyKcal: Double?
        var energyKcal100g: Double?
        var energyKcalServing: Double?
        var energyKcalUnit: String?
        
        var proteins100g: Double?
        var proteinsServing: Double?
        var proteinsUnit: String?

//        var energyValue: Int?
        var fat100g: Double?
        var fatServing: Double?
        var fatUnit: String?
        
        var sodium100g: Double?
        var sodiumServing: Double?
        var sodiumUnit: String?
        
//        var servingQuantity: String?
//        var servingSize: String?
//        var servingSizeImported: String?

        
        enum CodingKeys: String, CodingKey {
            case carbohydrates100g = "carbohydrates_100g"
            case carbohydratesServing = "carbohydrates_serving"
            case carbohydratesUnit = "carbohydrates_unit"
            
            case sugars100g = "sugars_100g"
            case sugarsServing = "sugars_serving"
            case sugarsUnit = "sugars_unit"


            case energyKcal100g = "energy-kcal_100g"
            case energyKcalServing = "energy-kcal_serving"
            case energyKcalUnit = "energy-kcal_unit"
            
            case proteins100g = "proteins_100g"
            case proteinsServing = "proteins_serving"
            case proteinsUnit = "proteins_unit"

            case fat100g = "fat_100g"
            case fatServing = "fat_serving"
            case fatUnit = "fat_unit"
            
            case sodium100g = "sodium_100g"
            case sodiumServing = "sodium_serving"
            case sodiumUnit = "sodium_unit"
            
        }
    }
    
//    struct OwnerFields: Codable {
//        var servingSize: Double?
//        var quantity: Int?
//
//        enum CodingKeys: String, CodingKey {
//            case servingSize = "serving_size"
//        }
//    }
    
//    struct OwnerFields: Codable {
//        var productName: String
//
//        enum CodingKeys: String, CodingKey {
//            case productName = "product_name_en"
//        }
//    }
    
    struct NameSearch: Codable {
    var count: Int?
    var page: String?
    var pageCount: Int?
    var pageSize: Int?
    var products: [ProductSearch]
        
//    var skip: Int
        
        enum CodingKeys: String, CodingKey {
            case count
            case page
            case pageCount = "page_count"
            case pageSize = "page_size"
            case products
        }
    }
    
    struct ProductSearch: Codable, Identifiable {
        var id: String? { return barcode }
        var barcode: String?
        var productName: String?
        var nutrients: NutrientsSearch
        
        enum CodingKeys: String, CodingKey {
            case barcode = "code"
            case productName = "product_name"
            case nutrients = "nutriments"
        }
    }
    
    struct NutrientsSearch: Codable {
        var energyKcal100g: Double?
        
        enum CodingKeys: String, CodingKey {
            case energyKcal100g = "energy-kcal_100g"
        }
    }
    
//    struct Packagings: Codable {
//    var quantity_per_unit: String?
//
//    var quantity_per_unit_value: Int?
//
//    var quantity_per_unit_unit: String?
//    }
    
    func getData(userInput: String, isBarcode: Bool) async {
        let query = userInput
        var urlString = ""
        
        if isBarcode {
            urlString = "https://world.openfoodfacts.org/api/v2/product/\(query)"
            print("BARCODE IS TRUE")
        }
        else {
            urlString = "https://world.openfoodfacts.org/cgi/search.pl?search_terms=\(query)&search_simple=1&action=process&json=1"

//            for whitespace in query {
//                if whitespace == " " {
////                    whitespace = "+"
//                }
//            }
            

            print("BARCODE IS FALSE")
        }
        
        print("TRYING TO ACCESS URL from query: \(query)")
        
        guard let url = URL(string: urlString) else {
            print("Could not create a URL")
            didFail = true
            return
        }
        print("It got created!")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print("TRY AWAIT PASSED")

//            print(String(data: data, encoding: .utf8))
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print(jsonString)
//            }
//            do {
//                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//                let fileURL = documentsURL.appendingPathComponent("response.json")
//                try data.write(to: fileURL)
//                print("Data saved to file: \(fileURL)")
//            } catch {
//                print("Error saving data to file: \(error)")
//            }



            if isBarcode {
                guard let barcodeData = try? JSONDecoder().decode(BarcodeData.self, from: data) else {
                    print("JSON ERROR: Could not decode returned JSON data for Barcode")
                    didFail = true
                    return
                }
                print("FIRST GUARD PASSED")

                DispatchQueue.main.async {
                    self.barcodeData = barcodeData
                }
                
                print("JSON returned! code: \(barcodeData.code), and Status_Verbose: \(barcodeData.statusVerbose), Also the ID: \(barcodeData.productData.id), and Brand: \(barcodeData.productData.brands), Category: \(barcodeData.productData.categories), Generic Name EN: \(barcodeData.productData.genericName), KCAL: \(barcodeData.productData.nutrients.energyKcalServing), PRODUCT NAME: \(barcodeData.productData.productName)")
                
                print("SERVING SIZE \(barcodeData.productData.servingSize)")
            } else {
                print("INSIDE ELSE BLOCK")

                guard let nameSearch = try? JSONDecoder().decode(NameSearch.self, from: data) else {
                    print("JSON ERROR: Could not decode returned JSON data for NameSearch")
                    didFail = true
                    print("\(didFail)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.nameSearch = nameSearch
                }
                print("SECOND GUARD PASSED")

                print("NAMESEARCH RETURN: \(nameSearch.count) and pages: \(nameSearch.page) and page count: \(nameSearch.pageCount) and page size: \(nameSearch.pageSize), THE BARCODE \(nameSearch.products)")

//                for product in nameSearch.products {
//                    print("PRODUCT: \(product.productName)")
//                }
            }
        } catch {
            print("ERROR: Could not use URL at \(urlString) to get data and response")
            didFail = true
        }

    }
}
