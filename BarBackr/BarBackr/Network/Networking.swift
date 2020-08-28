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
    
    static let sharedInstance = Networking()
    

    //possible errors
    enum NetworkError: Error {
        case otherError(Error)
        case noData
        case decodeFailed
    }
    
    enum Endpoints {
        static let baseURL = "https://www.thecocktaildb.com/api/json/v1/1"
        //Endpoint cases
        case getRandomCocktail
        case getSearchList(String)
        
        var stringValue: String {
            switch self {
            case .getRandomCocktail:
                return Endpoints.baseURL + "/random.php"
            case.getSearchList(let searchPath):
                return Endpoints.baseURL + "/search.php?s=" + searchPath
            }
            
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    // MARK: - Fetching Functions
    //Search for cocktail
    func searchCocktail(searchPath: String, completion: @escaping (Result<Drinks, NetworkError>) -> Void ){
        var request = URLRequest(url: Endpoints.getSearchList(searchPath).url)
        request.httpMethod = "GET"
        
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
    
    // Function to get a random Drink
    func getRandomCocktail(completion: @escaping (Result<Drinks, NetworkError>) -> Void) {
        
        //Build up the URL with necessary information
        var request = URLRequest(url: Endpoints.getRandomCocktail.url)
        request.httpMethod = "GET"
        
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
