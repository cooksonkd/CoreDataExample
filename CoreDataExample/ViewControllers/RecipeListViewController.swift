//
//  RecipeListViewController.swift
//  CoreDataExample
//
//  Created by Keenan Cookson on 2024/04/27.
//

import UIKit
import CoreData

/// Initial view controller
class RecipeListViewController: UIViewController {
    
    let networkService = RecipeNetworkService()
    var recipes = [Recipe]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        super.init(nibName: "RecipeListViewController", bundle: nil)
        Task {
            self.setRecipes(using: await self.fetchRecipesFromAPI())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - Networking
extension RecipeListViewController {
    
    private func fetchRecipesFromAPI() async -> Result<[Recipe], any Error> {
        let result = await self.networkService.fetchRecipes()
        return result
    }
    
    private func setRecipes(using result: Result<[Recipe], any Error>) {
        switch result {
        case .success(let recipes):
            self.recipes = recipes
        case .failure(_):
            // TODO: Show error alert/action-sheet to user
            break
        }
    }
    
}

// MARK: - Core Data
extension RecipeListViewController {
    
    private func writeRecipeToDB(_ recipe: Recipe) async -> Result<[Recipe], Error> {
        let recipeDTO = RecipeDTO(context: self.context)
        recipeDTO.setProperties(using: recipe)
        do {
            try self.context.save()
        } catch {
            // TODO: Handle error when recipe cannot be written to DB
        }
        return await self.fetchRecipesFromDB()
    }
    
    private func writeRecipesToDB(_ recipes: [Recipe]) async -> Result<[Recipe], Error> {
        for recipe in recipes {
            let recipeDTO = RecipeDTO(context: self.context)
            recipeDTO.setProperties(using: recipe)
        }
        do {
            try self.context.save()
        } catch {
            // TODO: Handle error when recipe cannot be written to DB
        }
        return await self.fetchRecipesFromDB()
    }
    
    private func fetchRecipesFromDB() async -> Result<[Recipe], Error> {
        do {
            let recipeDTOList = try context.fetch(RecipeDTO.fetchRequest())
            let recipes = {
                var recipes = [Recipe]()
                for recipeDTO in recipeDTOList {
                    recipes.append(Recipe(from: recipeDTO))
                }
                return recipes
            }
            return .success(recipes())
        } catch {
            // TODO: Handle error when recipes cannot be retrieved from DB
            return .failure(error)
        }
    }
    
    private func deleteRecipeFromDB(_ recipe: Recipe) async -> Result<[Recipe], Error> {
        let dto = RecipeDTO(context: self.context)
        dto.setProperties(using: recipe)
        self.context.delete(dto)
        do {
            try context.save()
        } catch {
            // TODO: Handle error when recipe cannot be deleted from DB
        }
        return await self.fetchRecipesFromDB()
    }
    
    private func deleteRecipesFromDB(_ recipes: [Recipe]) async -> Result<[Recipe], Error> {
        for recipe in recipes {
            let dto = RecipeDTO(context: self.context)
            dto.setProperties(using: recipe)
            self.context.delete(dto)
        }
        do {
            try context.save()
        } catch {
            // TODO: Handle error when recipe cannot be deleted from DB
        }
        return await self.fetchRecipesFromDB()
    }
    
}
