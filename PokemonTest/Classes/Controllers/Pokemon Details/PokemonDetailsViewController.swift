//
//  PokemonDetailsViewController.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 14/01/21.
//

import Foundation
import UIKit


// MARK: - Instance vars and IBOutlets

class PokemonDetailsViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var pokemonImage: UIImageView!
    var lblName: UILabel!
    var lblTypes: UILabel!
    var tableView: UITableView!
    
    var pokemon: Pokemon?
}


// MARK: - Essentials

extension PokemonDetailsViewController {
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(PokemonDetailsStatsTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.layoutIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
    
    // MARK: Memory warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    // MARK: Layout subviews
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    // MARK: UI
    
    override func loadView() {
        
        print("loadView")

        view = UIView()
        view.backgroundColor = .white
        
        scrollView = UIScrollView.init(frame: view.frame)
        scrollView.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        view.addSubview(scrollView)

        pokemonImage = UIImageView.init()
        pokemonImage.backgroundColor = .red
        scrollView.addSubview(pokemonImage)
        
        lblName = UILabel.init()
        lblName.backgroundColor = .cyan
        lblName.font = UIFont.boldSystemFont(ofSize: 24)
        lblName.textAlignment = .center
        lblName.text = "Pokemon Name"
        scrollView.addSubview(lblName)
        
        lblTypes = UILabel.init()
        lblTypes.backgroundColor = .lightGray
        lblTypes.font = UIFont.boldSystemFont(ofSize: 16)
        lblTypes.textAlignment = .center
        lblTypes.text = "water, psychic"
        lblTypes.minimumScaleFactor = 0.7
        scrollView.addSubview(lblTypes)
        
        tableView = UITableView.init()
        tableView.separatorStyle = .none
        scrollView.addSubview(tableView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblTypes.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImage.topAnchor.constraint(equalTo: pokemonImage.superview!.topAnchor),
            pokemonImage.leadingAnchor.constraint(equalTo: pokemonImage.superview!.leadingAnchor),
            pokemonImage.trailingAnchor.constraint(equalTo: pokemonImage.superview!.trailingAnchor),
            pokemonImage.heightAnchor.constraint(equalTo: pokemonImage.superview!.heightAnchor, multiplier: 0.35),
            pokemonImage.centerXAnchor.constraint(equalTo: pokemonImage.superview!.centerXAnchor),
            lblName.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor, constant: 20),
            lblName.leadingAnchor.constraint(equalTo: lblName.superview!.leadingAnchor, constant: 30),
            lblName.trailingAnchor.constraint(equalTo: lblName.superview!.trailingAnchor, constant: -30),
            lblName.heightAnchor.constraint(equalToConstant: 60),
            lblName.centerXAnchor.constraint(equalTo: pokemonImage.centerXAnchor),
            lblTypes.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 10),
            lblTypes.leadingAnchor.constraint(equalTo: lblName.leadingAnchor),
            lblTypes.trailingAnchor.constraint(equalTo: lblName.trailingAnchor),
            lblTypes.centerXAnchor.constraint(equalTo: lblName.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: lblTypes.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: lblTypes.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: lblTypes.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 360),
            tableView.centerXAnchor.constraint(equalTo: lblTypes.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: tableView.superview!.bottomAnchor, constant: -20)
        ])
    }
}


// MARK: - UITableView - Delegate

extension PokemonDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
}


// MARK: - UITableView - Data Source

extension PokemonDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! PokemonDetailsStatsTableViewCell
        
        return cell
    }
}
