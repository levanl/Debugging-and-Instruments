//
//  News.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

// Decodable protocol added
struct News: Decodable {
    let author: String?
    let title: String?
    let urlToImage: String?
}
