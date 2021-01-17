//
//  PokemonListViewController.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 13/01/21.
//

import UIKit


// MARK: - PokemonListViewController - Delegate

protocol PokemonListViewControllerDelegate: AnyObject {
    
    func pokemonListViewController(_ viewController: PokemonListViewController, didSelectPokemonWithIdentifier identifier: Int, pokemonImage: UIImage?)
}


// MARK: - PokemonListViewController

class PokemonListViewController: UIViewController {
    
    var tableView: UITableView!
    var btnRetry: UIButton?
    
    weak var delegate: PokemonListViewControllerDelegate?
    
    var isFirstLoad: Bool?
    
    var viewModel: PokemonListViewModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = PokemonListViewModel.init(withDelegate: self)
        
        title = "Pokémon"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PokemonListTableViewCell.self, forCellReuseIdentifier: PokemonListViewModel.CellIdentifiers.pokemonList)
        
        isFirstLoad = true
        
        viewModel?.fetchPokemon()
    }
    
    // MARK: UI
    
    override func loadView() {
        
        // MARK: Set views

        view = UIView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            view.backgroundColor = .white
        }
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            if #available(iOS 13.0, *) {
                tableView = UITableView.init(frame: .zero, style: UITableView.Style.insetGrouped)
            } else {
                // Fallback on earlier versions
                tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
            }
        } else {
            tableView = UITableView.init()
        }
        
        view.addSubview(tableView)

        // Table view setup
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView.init()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: Activate constraints
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tableView.superview!.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: tableView.superview!.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: tableView.superview!.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


// MARK: - Retry Button

extension PokemonListViewController {
    
    private func activateRetryButton() {
        
        if btnRetry == nil {
            btnRetry = UIButton.init(type: .system)
            btnRetry?.setTitle("Retry", for: .normal)
            if #available(iOS 13.0, *) {
                btnRetry?.tintColor = .label
            } else {
                // Fallback on earlier versions
                btnRetry?.tintColor = .darkText
            }
            btnRetry?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            btnRetry?.addTarget(self, action: #selector(retry), for: .touchUpInside)
            
            view.addSubview(btnRetry!)
            view.bringSubviewToFront(btnRetry!)
            
            btnRetry?.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                btnRetry!.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                btnRetry!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                btnRetry!.widthAnchor.constraint(equalToConstant: 140),
                btnRetry!.heightAnchor.constraint(equalToConstant: 60)
            ])
            
            self.view.layoutIfNeeded()
        } else {
            guard btnRetry!.isHidden else {
                return
            }
            
            view.addSubview(btnRetry!)
            view.bringSubviewToFront(btnRetry!)
        }
    }
    
    private func hideRetryButton() {
        
        btnRetry?.isHidden = true
        btnRetry?.removeFromSuperview()
    }
    
    @objc private func retry() {
        
        viewModel?.fetchPokemon()
    }
}


// MARK: - UITableView - Delegate

extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let pk = viewModel!.pokemon[indexPath.row]
        let image = (tableView.cellForRow(at: indexPath) as! PokemonListTableViewCell).pokemonImageView.image
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            let vc = PokemonDetailsViewController.init()
            vc.identifier = pk.identifier!
            vc.pokemonImage = image
            navigationController?.pushViewController(vc, animated: true)
        } else {
            delegate?.pokemonListViewController(self, didSelectPokemonWithIdentifier: pk.identifier!, pokemonImage: image)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
}


// MARK: - UITableView - Data Source

extension PokemonListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.pokemon.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = PokemonListViewModel.CellIdentifiers.pokemonList
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! PokemonListTableViewCell
        
        let thePokemon = viewModel!.pokemon[indexPath.row]
        
        cell.lblName.text = thePokemon.name?.capitalized
        if let url = thePokemon.autogeneratedImageURL {
            cell.pokemonImageView.download(from: URL.init(string: url)!)
            cell.pokemonImageView.download(
                from: URL.init(string: url)!,
                contentMode: UIView.ContentMode.scaleAspectFit,
                placeholder: nil) { (image) in
                    // Download completed
            }
        }
        
        if (indexPath.row == viewModel!.pokemon.count - 5) {
            // Start fetching next page
            viewModel?.fetchPokemon()
        }
        
        return cell
    }
}


// MARK: - PokemonListViewModel - Delegate

extension PokemonListViewController: PokemonListViewModelDelegate {
    
    func pokemonListViewModelDidStartFetching(_ viewModel: PokemonListViewModel) {
        
        UIApplication.shared.keyWindow?.showBlurredActivityIndicator(withBlurEffect: .dark)
    }
    
    func pokemonListViewModelDidFinishFetching(_ viewModel: PokemonListViewModel) {
        
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.hideBlurredActivityIndicator()
        }
    }
    
    func pokemonListViewModel(_ viewModel: PokemonListViewModel, didFinishFetchingWithError error: APIError) {
        
        print("Error! \(error.localizedDescription)")
        
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.hideBlurredActivityIndicator()
            self.showAlert(withAPIError: error)
            if self.isFirstLoad! {
                self.activateRetryButton()
            }
        }
    }
    
    func pokemonListViewModelDidFinishFetchingWithSuccess(_ viewModel: PokemonListViewModel) {
        
        
    }
    
    func pokemonListViewModel(_ viewModel: PokemonListViewModel, didFinishFetchingWithSuccess pokemon: [Pokemon]) {
        
        DispatchQueue.main.async {
            if self.isFirstLoad! {
                self.isFirstLoad = false
            }
            self.hideRetryButton()
            self.tableView.reloadData()
        }
    }
    
    func pokemonListViewModelNoMorePokemonToLoad(_ viewModel: PokemonListViewModel) {
        
        print("No more pokemon to load, list is full.")
    }
}
