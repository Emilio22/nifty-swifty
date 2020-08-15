//
//  Networking.swift
//  BarBackr
//
//  Created by Emilio Rodriguez on 8/14/20.
//  Copyright © 2020 RWbc Emilio. All rights reserved.
//

import Foundation
import UIKit

class Networking {
    // MARK: - Properties
    
    static let sharedInstance = Networking()
    

    //possible errors
    enum NetworkError: Error {
        case otherError(Error)
        case noData
        case decodeFailed
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case pull = "PULL"
        case delete = "DELETE"
    }
    
    enum Endpoints {
        static let baseURL = "https://www.thecocktaildb.com/api/json/v1/1"
        //This is where we store the different endpoint cases. They are named based on their functionality
        case getRandomCocktail
        case getImage(String)
        case getSearchList(String)
        
        var stringValue: String {
            switch self {
            case .getRandomCocktail:
                return Endpoints.baseURL + "/random.php"
            case.getImage(let imagePath):
                return imagePath
            case.getSearchList(let searchPath):
                return Endpoints.baseURL + searchPath
            }
            
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    // MARK: - Fetching Functions
    // Function to get a random Drink
    func getRandomCocktail(completion: @escaping (Result<Drinks, NetworkError>) -> Void) {
        
        //Build up the URL with necessary information
        var request = URLRequest(url: Endpoints.getRandomCocktail.url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        //Request the data
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.otherError(error!)))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            //Decode the data
            let decoder = JSONDecoder()
            do {
                let drinksResults = try decoder.decode(Drinks.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(drinksResults))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodeFailed))
                }
                return
            }
        }.resume()
    }
    
    
}
