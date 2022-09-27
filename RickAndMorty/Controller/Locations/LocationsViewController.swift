//
//  LocationsViewController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import UIKit

class LocationsViewController: UIViewController {
    
    //MARK: - Private variables
    private var locationsView: LocationsView!
    private var locations: Locations! {
        didSet {
            locationsView.configure(locations)
        }
    }
    
    //MARK: - Func view controllers
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        NetworkService.shared.getLocations { [weak self] result in
            switch result {
            case .success(let data):
                self?.locations = data
            case .failure(let error):
                print("Error with get locations \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - Private func
    private func setupViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constans.Text.Titles.locations
        locationsView = LocationsView(frame: view.frame)
        locationsView.delegate = self
        view = locationsView
    }
}

//MARK: - LocationsViewTapHandler
extension LocationsViewController: LocationsViewTapHandler {
    
    func pressedOnCell(_ indexPath: IndexPath) {
        print(locations.results[indexPath.row].name)
    }
}
