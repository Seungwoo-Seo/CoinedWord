//
//  DeliveryViewController.swift
//  CoinedWord
//
//  Created by 서승우 on 2023/07/21.
//

import UIKit

final class DeliveryViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet var backgroundViews: [UIView]!
    @IBOutlet var imageViews: [UIImageView]!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureSearchBar()
        configureBackgroundViews()
        configureImageViews()


        print("hi")

    }

    func configureNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(
            red: 42.0/255.0,
            green: 193/255.0,
            blue: 188/255.0,
            alpha: 1.0
        )
        navigationBarAppearance.shadowColor = UIColor(
            red: 42.0/255.0,
            green: 193/255.0,
            blue: 188/255.0,
            alpha: 1.0
        )

        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance

        navigationController?.navigationBar.tintColor = .white

    }

    func configureSearchBar() {
        searchBar.placeholder = "순대볶음 나와라 뚝딱!!"

        searchBar.directionalLayoutMargins = .init(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )

        let image = UIImage(named: "magnifyingglass")
        searchBar.setImage(
            image,
            for: .search,
            state: .normal
        )
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = UIColor(
            red: 42.0/255.0,
            green: 193/255.0,
            blue: 188/255.0,
            alpha: 1.0
        )

        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.borderStyle = .none

        searchBar.layer.masksToBounds = true
        searchBar.layer.cornerRadius = 15
        searchBar.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
    }

    func configureBackgroundViews() {
        backgroundViews.forEach {
            $0.layer.shadowColor = UIColor.gray.cgColor
            $0.layer.shadowOffset = .init(
                width: 1,
                height: 1
            )
            $0.layer.shadowRadius = 1
            $0.layer.shadowOpacity = 0.1
            $0.backgroundColor = .clear
        }
    }

    func configureImageViews() {
        imageViews.forEach {
            $0.layer.cornerRadius = 15
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }

}
