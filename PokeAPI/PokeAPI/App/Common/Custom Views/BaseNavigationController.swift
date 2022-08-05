//
//  BaseNavigationController.swift
//  PokeAPI
//
//  Created by Alizain on 02/08/2022.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: Color.primary]
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = Color.background
        
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.standardAppearance = appearance
    }
}
