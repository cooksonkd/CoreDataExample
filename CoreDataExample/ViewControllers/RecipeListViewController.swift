//
//  RecipeListViewController.swift
//  CoreDataExample
//
//  Created by Keenan Cookson on 2024/04/27.
//

import UIKit

class RecipeListViewController: UIViewController {
    
    let networkService: RecipeNetworkService = RecipeNetworkService()
    var recipes = [Recipe]()
    
    init() {
        super.init(nibName: "RecipeListViewController", bundle: nil)
        Task {
            let result = await self.networkService.fetchRecipes()
            self.setRecipes(using: result)   
            guard self.recipes.isEmpty == false else { return }
            print(self.recipes)
        }
    }
    
    private func setRecipes(using result: Result<[Recipe], any Error>) {
        switch result {
        case .success(let recipes):
            self.recipes = recipes
        case .failure(let error):
            print("Error: ", error)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
