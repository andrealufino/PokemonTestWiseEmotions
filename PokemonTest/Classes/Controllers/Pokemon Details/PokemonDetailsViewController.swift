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
    var pokemonImageView: UIImageView!
    var lblName: UILabel!
    var lblTypes: UILabel!
    var tableView: UITableView!
    
    var tableViewHeight: NSLayoutConstraint?
    
//    var pokemon: Pokemon?
    var identifier: Int?
    var pokemonImage: UIImage?
    
    var viewModel: PokemonDetailsViewModel?
    
    private let cellHeight: CGFloat = 60
}


// MARK: - Essentials

extension PokemonDetailsViewController {
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(PokemonDetailsStatsTableViewCell.self, forCellReuseIdentifier: PokemonDetailsViewModel.CellIdentifiers.pokemonDetails)
        
        viewModel = PokemonDetailsViewModel.init(withDelegate: self)
        
        if let id = identifier {
//            viewModel?.fetchPokemonDetails(aPokemon)
            viewModel?.fetchPokemonDetails(withIdentifier: id)
        }
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

        view = UIView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            view.backgroundColor = .white
        }
        
        // MARK: Set views
        
        scrollView = UIScrollView.init(frame: view.frame)
        view.addSubview(scrollView)

        pokemonImageView = UIImageView.init()
        pokemonImageView.contentMode = .scaleAspectFit
        scrollView.addSubview(pokemonImageView)
        
        lblName = UILabel.init()
        lblName.font = UIFont.boldSystemFont(ofSize: 24)
        lblName.textAlignment = .center
        scrollView.addSubview(lblName)
        
        lblTypes = UILabel.init()
        lblTypes.font = UIFont.systemFont(ofSize: 16)
        lblTypes.textAlignment = .center
        lblTypes.minimumScaleFactor = 0.7
        scrollView.addSubview(lblTypes)
        
        tableView = UITableView.init()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        scrollView.addSubview(tableView)
        
        tableViewHeight = tableView.heightAnchor.constraint(equalToConstant: 0)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblTypes.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: Activate constraints
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: pokemonImageView.superview!.topAnchor),
            pokemonImageView.leadingAnchor.constraint(equalTo: pokemonImageView.superview!.leadingAnchor),
            pokemonImageView.trailingAnchor.constraint(equalTo: pokemonImageView.superview!.trailingAnchor),
            pokemonImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            pokemonImageView.centerXAnchor.constraint(equalTo: pokemonImageView.superview!.centerXAnchor),
            lblName.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 20),
            lblName.leadingAnchor.constraint(equalTo: lblName.superview!.leadingAnchor, constant: 30),
            lblName.trailingAnchor.constraint(equalTo: lblName.superview!.trailingAnchor, constant: -30),
            lblName.heightAnchor.constraint(equalToConstant: 60),
            lblName.centerXAnchor.constraint(equalTo: pokemonImageView.centerXAnchor),
            lblTypes.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 10),
            lblTypes.leadingAnchor.constraint(equalTo: lblName.leadingAnchor),
            lblTypes.trailingAnchor.constraint(equalTo: lblName.trailingAnchor),
            lblTypes.centerXAnchor.constraint(equalTo: lblName.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: lblTypes.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: lblTypes.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: lblTypes.trailingAnchor),
            tableView.centerXAnchor.constraint(equalTo: lblTypes.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: tableView.superview!.bottomAnchor, constant: -20),
            tableViewHeight!
        ])
    }
}


// MARK: - UITableView - Delegate

extension PokemonDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeight
    }
}


// MARK: - UITableView - Data Source

extension PokemonDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return pokemon?.stats?.count ?? 0
        return viewModel?.pokemon?.stats?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = PokemonDetailsViewModel.CellIdentifiers.pokemonDetails
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! PokemonDetailsStatsTableViewCell
        
//        let stat = pokemon!.stats![indexPath.row]
        let stat = viewModel!.pokemon!.stats![indexPath.row]
        
        cell.lblTitle.text = stat.name
        cell.lblValue.text = "\(stat.value!)"
        
        return cell
    }
}


// MARK: - PokemonDetailsViewModel - Delegate

extension PokemonDetailsViewController: PokemonDetailsViewModelDelegate {
    
    func pokemonDetailsViewModelDidStartFetching(_ viewModel: PokemonDetailsViewModel) {
        
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.showBlurredActivityIndicator(withBlurEffect: .dark)
        }
    }
    
    func pokemonDetailsViewModelDidFinishFetching(_ viewModel: PokemonDetailsViewModel) {
        
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.hideBlurredActivityIndicator()
        }
    }
    
    func pokemonDetailsViewModel(_ viewModel: PokemonDetailsViewModel, didFinishFetchingWithError error: APIError) {
        
        DispatchQueue.main.async {
            self.showAlert(withAPIError: error)
        }
    }
    
    func pokemonDetailsViewModelDidFinishFetchingWithSuccess(_ viewModel: PokemonDetailsViewModel) {
        
    }
    
    func pokemonDetailsViewModel(_ viewModel: PokemonDetailsViewModel, didFinishFetchingWithSuccess pokemon: Pokemon) {
        
//        self.pokemon = pokemon
        
        DispatchQueue.main.async {
            
            let pokemonName = pokemon.name?.capitalized
            
            self.title = pokemonName! + "  ·  #\(pokemon.identifier!)"
            
            self.lblName.text = pokemonName
            if let image = self.pokemonImage {
                print("No need to download image, it has been passed by master controller.")
                self.pokemonImageView.image = image
            } else {
                if let url = pokemon.autogeneratedImageURL {
                    self.pokemonImageView.download(from: URL.init(string: url)!)
                }
            }
            
            self.tableViewHeight?.constant = self.cellHeight * CGFloat(pokemon.stats!.count)
            self.tableView.layoutIfNeeded()
            self.tableView.reloadData()
            
            var types = ""
            pokemon.types?.forEach({ (type) in
                if !types.isEmpty {
                    types.append(" · ")
                }
                types.append("\(type.name!.capitalized)")
            })
            self.lblTypes.text = types
        }
    }
}


// MARK: - PokemonListViewController - Delegate

extension PokemonDetailsViewController: PokemonListViewControllerDelegate {
    
    func pokemonListViewController(_ viewController: PokemonListViewController, didSelectPokemonWithIdentifier identifier: Int, pokemonImage: UIImage?) {
        
        self.identifier = identifier
        self.pokemonImage = pokemonImage
        viewModel?.fetchPokemonDetails(withIdentifier: identifier)
    }
}
