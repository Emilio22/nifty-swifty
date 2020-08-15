//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class Networking {
    
    static let sharedInstance = Networking()
    
    
    //get a random category
    func getRandomCategory(completion: @escaping(_ categoryId: Int?) -> ()){
        print("getRandomCategory is called")
        
        let urlString = "http://www.jservice.io/api/random"
        if let url = URL(string: urlString){
            //create a session
            let session = URLSession(configuration: .default)
            //create a task
            let task = session.dataTask(with: url) { data, response, error in
                //check for error
                if let error = error {
                    print(error)
                    return
                }
                if let data = data {
                    do{
                        let decoder = JSONDecoder()
                        let clue = try decoder.decode([Clue].self, from: data)
                        let categoryId = clue.first?.category_id
                        print("before calling categoryID in completion handler")
                        completion(categoryId)
                        print("after calling completion handler in getRandomCategory")
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
                
            }
            task.resume()
        }
        print("the end of get RandomCategory")
    }
    
    func getAllCluesInCategory(categoryId: Int, completion: @escaping([Clue]) -> ()){
        print("getAllCluesInCategy is called")
        let urlString = "http://www.jservice.io/api/clues/?category=\(categoryId)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                if let data = data {
                    do{
                        let decoder = JSONDecoder()
                        var clues = try decoder.decode([Clue].self, from: data)
                        var limitedClues : [Clue] = []
                        for i in 0...3 {
                            if clues[i].answer == nil {
                                clues[i].answer = "Goerge Washington"
                            }
                            limitedClues.append(clues[i])
                        }
                        limitedClues.shuffle()
                        completion(limitedClues)
                        print("after calling completion handler in getAllCluesInCategory")
                    } catch let error {
                        print(error.localizedDescription)
                    }
                    
                }
            }
            task.resume()
        }
    }
    

}
