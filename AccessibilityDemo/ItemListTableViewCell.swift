//
//  ItemListTableViewCell.swift
//  AccessibilityDemo
//
//  Created by sudip kundu on 11/12/18.
//  Copyright © 2018 sudip kundu. All rights reserved.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {
    @IBOutlet var roundedBackgroundView: UIView!
    @IBOutlet var foodImageView: UIImageView!
    @IBOutlet var dishNameLabel: UILabel!
    @IBOutlet var difficultyLabel: UILabel!
    var difficultyValue: RecipeDifficulty = .unknown
    override func awakeFromNib() {
        super.awakeFromNib()
        styleAppearance()
    }
    func configureCell(with recipe:Recipe) {
        dishNameLabel.text = recipe.name
        foodImageView.image = recipe.photo
        difficultyValue = recipe.difficulty
        difficultyLabel.text = difficultyString
        applyAccessibility(recipe)
    }

    var difficultyString: String {
        switch difficultyValue {
        case .unknown:
            return ""
        case .rating(let value):
            var string = ""
            for _ in 0..<value {
                string.append("👍🏻")
            }
            return string
        }
    }

    func styleAppearance() {
        roundedBackgroundView.layer.cornerRadius = 3.0
        roundedBackgroundView.layer.masksToBounds = false
        roundedBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        roundedBackgroundView.layer.shadowColor = #colorLiteral(red: 0.05439098924, green: 0.1344551742, blue: 0.1884709597, alpha: 1).cgColor
        roundedBackgroundView.layer.shadowRadius = 1.0
        roundedBackgroundView.layer.shadowOpacity = 0.3

        foodImageView.layer.cornerRadius = 3.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
// MARK: Accessibility
extension ItemListTableViewCell {
    func applyAccessibility(_ recipe: Recipe) {
        foodImageView.accessibilityTraits = UIAccessibilityTraits.image
        foodImageView.accessibilityLabel = recipe.photoDescription

        dishNameLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        dishNameLabel.adjustsFontForContentSizeCategory = true

        difficultyLabel.isAccessibilityElement = true
        difficultyLabel.accessibilityTraits = UIAccessibilityTraits.none
        difficultyLabel.accessibilityLabel = "Difficulty Level"

        switch recipe.difficulty {
        case .unknown:
            difficultyLabel.accessibilityValue = "Unknown"
        case .rating(let value):
            difficultyLabel.accessibilityValue = "\(value)"
        }

        difficultyLabel.font = UIFont.preferredFont(forTextStyle: .body)
        difficultyLabel.adjustsFontForContentSizeCategory = true
    }
}
