//
//  SearchViewController.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 01.06.2023.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    func updateView()
}

class SearchViewController: UIViewController, SearchViewProtocol, UISearchBarDelegate {
    var presenter: SearchPresenterProtocol!

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .mainBackground
        return collectionView
    }()

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = .searchBackground
        return searchBar
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
         let indicator = UIActivityIndicatorView(style: .large)
         indicator.translatesAutoresizingMaskIntoConstraints = false
         indicator.hidesWhenStopped = true
        indicator.color = .white
         return indicator
     }()

    var workItem: DispatchWorkItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setupnavigationController()
        setupCollectionView()
        setupSearchBar()
        setupActivityIndicator()
        
    }
    
    private func setupnavigationController() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .mainBackground
        navigationController?.navigationBar.tintColor = .white
    }

    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(SongCell.self, forCellWithReuseIdentifier: SongCell.identifier)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.tintColor = .white
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        workItem?.cancel()
        workItem = DispatchWorkItem {
            self.sendSearchRequest()
        }
        //Set up delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: workItem!)
        
        if searchText.isEmpty {
            presenter.didReceive(songs: [])
            updateView()
        }
    }

    func sendSearchRequest() {
        guard let keyword = searchBar.text, keyword.count > 3 else {
            return
        }
        
        activityIndicator.startAnimating()
        presenter.didEnter(keyword: keyword)
    }

    func updateView() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfSongs()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SongCell.identifier, for: indexPath) as! SongCell
        let song = presenter.songAt(index: indexPath.row)
        cell.configureCell(with: song)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSong = presenter.songAt(index: indexPath.row)
            presenter.didSelectSong(selectedSong)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
}
// MARK: - UICollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return LayoutHelper.shared.collectionViewCellSize(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return LayoutHelper.shared.collectionViewSectionInsets()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutHelper.shared.collectionViewLineSpacing()
    }
}
