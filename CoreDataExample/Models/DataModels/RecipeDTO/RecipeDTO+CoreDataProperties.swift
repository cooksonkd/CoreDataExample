//
//  RecipeDTO+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Keenan Cookson on 2024/04/28.
//
//

import Foundation
import CoreData


extension RecipeDTO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeDTO> {
        return NSFetchRequest<RecipeDTO>(entityName: "RecipeDTO")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String
    @NSManaged public var ingredients: [String]
    @NSManaged public var instructions: [String]
    @NSManaged public var prepTimeMinutes: Int16
    @NSManaged public var cookTimeMinutes: Int16
    @NSManaged public var servings: Int16
    @NSManaged public var difficulty: String
    @NSManaged public var cuisine: String
    @NSManaged public var caloriesPerServing: Int16
    @NSManaged public var tags: [String]
    @NSManaged public var userID: Int16
    @NSManaged public var image: String
    @NSManaged public var rating: Double
    @NSManaged public var reviewCount: Int16
    @NSManaged public var mealType: [String]

    public func setProperties(using recipe: Recipe) {
        self.id = Int16(recipe.id)
        self.name = recipe.name
        self.ingredients = recipe.ingredients
        self.instructions = recipe.instructions
        self.prepTimeMinutes = Int16(recipe.prepTimeMinutes)
        self.cookTimeMinutes = Int16(recipe.cookTimeMinutes)
        self.servings = Int16(recipe.servings)
        self.difficulty = recipe.difficulty.rawValue
        self.cuisine = recipe.cuisine
        self.caloriesPerServing = Int16(recipe.caloriesPerServing)
        self.tags = recipe.tags
        self.userID = Int16(recipe.userID)
        self.image = recipe.image
        self.rating = recipe.rating
        self.reviewCount = Int16(recipe.reviewCount)
        self.mealType = recipe.mealType
    }
}

extension RecipeDTO : Identifiable {

}
