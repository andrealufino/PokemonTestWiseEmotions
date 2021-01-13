//
//  PokemonListViewController.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 13/01/21.
//

import UIKit


class PokemonListViewController: UIViewController {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pokèmon"
        
        APIManager.details(forPokemonWithName: "mew") { (result) in
            
        }
    }
    
    // MARK: UI
    
    override func loadView() {

        view = UIView()
        view.backgroundColor = .white

        tableView = UITableView.init()
        view.addSubview(tableView)

        // Table view setup
        tableView.backgroundColor = .red
        tableView.tableFooterView = UIView.init()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tableView.superview!.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: tableView.superview!.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: tableView.superview!.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

