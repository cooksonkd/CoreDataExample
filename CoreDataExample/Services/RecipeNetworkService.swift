//
//  RecipeNetworkService.swift
//  CoreDataExample
//
//  Created by Keenan Cookson on 2024/04/27.
//

import Foundation

class RecipeNetworkService {
    
    /// Fetches recipes from the api.
    /// - Returns: Result<[Recipe], Error>
    func fetchRecipes() async -> Result<[Recipe], Error> {
        guard let url = URL(string: "https://dummyjson.com/recipes") else { return .failure(RecipeError.failedToGetRecipes) }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let recipeResponse = try JSONDecoder().decode(RecipesResponse.self, from: data)
            return .success(recipeResponse.recipes)
        } catch {
            return .failure(error)
        }
    }
    
}

// MARK: - Enum
enum RecipeError: Error {
    case failedToGetRecipes
}

