//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct Clue: Codable {
    let id: Int
    var answer: String?
    let question: String?
    let value: Int?
    let category_id: Int?
    let category: Category
}

struct Category: Codable {
    let id: Int
    let title: String
}


