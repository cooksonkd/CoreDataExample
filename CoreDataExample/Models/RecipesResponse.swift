//
//  RecipesResponse.swift
//  CoreDataExample
//
//  Created by Keenan Cookson on 2024/04/27.
//

import Foundation

// MARK: -
public struct RecipesResponse: Decodable {
    public let recipes: [Recipe]
    public let total, skip, limit: Int

    public init(recipes: [Recipe], total: Int, skip: Int, limit: Int) {
        self.recipes = recipes
        self.total = total
        self.skip = skip
        self.limit = limit
    }
}

// MARK: -
public struct Recipe: Decodable {
    public let id: Int
    public let name: String
    public let ingredients, instructions: [String]
    public let prepTimeMinutes, cookTimeMinutes, servings: Int
    public let difficulty: Difficulty
    public let cuisine: String
    public let caloriesPerServing: Int
    public let tags: [String]
    public let userID: Int
    public let image: String
    public let rating: Double
    public let reviewCount: Int
    public let mealType: [String]

    public enum CodingKeys: String, CodingKey {
        case id, name, ingredients, instructions, prepTimeMinutes, cookTimeMinutes, servings, difficulty, cuisine, caloriesPerServing, tags
        case userID = "userId"
        case image, rating, reviewCount, mealType
    }

    public init(id: Int, name: String, ingredients: [String], instructions: [String], prepTimeMinutes: Int, cookTimeMinutes: Int, servings: Int, difficulty: Difficulty, cuisine: String, caloriesPerServing: Int, tags: [String], userID: Int, image: String, rating: Double, reviewCount: Int, mealType: [String]) {
        self.id = id
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
        self.prepTimeMinutes = prepTimeMinutes
        self.cookTimeMinutes = cookTimeMinutes
        self.servings = servings
        self.difficulty = difficulty
        self.cuisine = cuisine
        self.caloriesPerServing = caloriesPerServing
        self.tags = tags
        self.userID = userID
        self.image = image
        self.rating = rating
        self.reviewCount = reviewCount
        self.mealType = mealType
    }
}

// MARK: -
public enum Difficulty: String, Decodable {
    case easy = "Easy"
    case medium = "Medium"
}
