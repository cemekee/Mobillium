//
//  DetailViewController.swift
//  Mobillium
//
//  Created by Cem Eke on 3.04.2022.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        initVM()
        loadData()
        
    }
}
