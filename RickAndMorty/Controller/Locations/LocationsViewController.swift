//
//  LocationsViewController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import UIKit

class LocationsViewController: UIViewController {
    
    //MARK: - Private variables
    private var locationView: LocationView!
    private var locations: Locations!
    
    //MARK: - Func view controllers
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        NetworkService.shared.getLocations { [weak self] result in
            switch result {
            case .success(let data):
                self?.locationView.configure(data)
            case .failure(let error):
                print("Error with get locations \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - Private func
    private func setupViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constans.Text.Titles.locations
        locationView = LocationView(frame: view.frame)
        locationView.delegate = self
        view = locationView
    }
}

//MARK: - LocationViewTapHandler
extension LocationsViewController: LocationViewTapHandler {
    
    func pressedOnCell(_ indexPath: IndexPath) {
        print(locations.results[indexPath.row].name)
    }
}
