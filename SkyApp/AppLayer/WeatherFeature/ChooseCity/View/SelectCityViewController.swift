//
//  ChooseCountryViewController.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit

class SelectCityViewController: BaseViewController {

     // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let viewModel: ChooseCountryViewModel
    let router: WeatherRouter
    weak var delegate: SelectCityDelegate?
    var citiesList = [CityElement]()
    var selectedCity: CityElement?

    
    // MARK: - Initializers
    init(viewModel: ChooseCountryViewModel, router: WeatherRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = ChooseCountryViewModel(fileName: CitiesListFileEnum.name.rawValue, fileType: CitiesListFileEnum.type.rawValue)
        self.router = WeatherRouter()
        super.init(coder: aDecoder)
    }
    
    public override init(nibName: String?, bundle: Bundle?) {
         viewModel = ChooseCountryViewModel(fileName: CitiesListFileEnum.name.rawValue, fileType: CitiesListFileEnum.type.rawValue)
        self.router = WeatherRouter()
        super.init(nibName: nibName, bundle: bundle)
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        getListOfCities()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: SearchCountryTableViewCellEnum.nibName.rawValue, bundle: nil), forCellReuseIdentifier: SearchCountryTableViewCellEnum.CellReuseIdentifier.rawValue)
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    private func getListOfCities() {
        showLoadingView()
        viewModel.getListOfCities(onSuccess: { [weak self] citiesList in
            self?.citiesList = citiesList
            self?.tableView.reloadData()
            self?.hideLoadingView()
        }, onError: { [weak self] error in
            self?.hideLoadingView()
            self?.showErrorView(title: error, description: error)
        })
    }

    @IBAction func doneButtonIsPressed(_ sender: Any) {
        if let _selectedCity = selectedCity {
            delegate?.didSelectCity(city: _selectedCity)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonIsPressed(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }


}
