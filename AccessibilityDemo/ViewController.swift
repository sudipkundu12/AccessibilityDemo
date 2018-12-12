//
//  ViewController.swift
//  AccessibilityDemo
//
//  Created by sudip kundu on 11/12/18.
//  Copyright © 2018 sudip kundu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var recipes = [Recipe]()

    @IBOutlet weak var recipeTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let seedRecipe = Recipe.loadDefaultRecipe() {
            recipes += seedRecipe
            recipes = recipes.sorted(by: { $0.name < $1.name })
        }
        recipeTblView.estimatedRowHeight = 100
        recipeTblView.rowHeight = UITableView.automaticDimension
    }

}
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemListTableViewCell", for: indexPath) as? ItemListTableViewCell else {
            fatalError("Error")
        }
        let recipe = recipes[indexPath.item]
        cell.configureCell(with: recipe)

        return cell
    }


}
