//
//  HomeViewController.swift
//  SkyApp
//
//  Created by Guest2 on 12/26/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit
import CoreLocation


class HomeViewController: BaseViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let viewModel: HomeViewModel
    let router: WeatherRouter
    var locationManager: CLLocationManager?
    var citiesList: [CityWeatherModel] = [CityWeatherModel]()
    
    // MARK: - Initializers
    init(viewModel: HomeViewModel, router: WeatherRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        let storageProvider = CoreDataStorageProvider(context: AppDelegate.viewContext)
        viewModel = HomeViewModel(storageProvider: storageProvider)
        self.router = WeatherRouter()
        super.init(coder: aDecoder)
    }
    
    public override init(nibName: String?, bundle: Bundle?) {
        let storageProvider = CoreDataStorageProvider(context: AppDelegate.viewContext)
        viewModel = HomeViewModel(storageProvider: storageProvider)
        self.router = WeatherRouter()
        super.init(nibName: nibName, bundle: bundle)
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLocation()
        setupNaviagtionBar()
        // Do any additional setup after loading the view.
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: HomeTableViewCellEnum.nibName.rawValue, bundle: nil), forCellReuseIdentifier: HomeTableViewCellEnum.CellReuseIdentifier.rawValue)
        tableView.backgroundView = UIImageView(image: UIImage(named: ImagesEnum.HomeBackGroundImage.rawValue))
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
    
    private func setupNaviagtionBar() {
        let img = UIImage(named: ImagesEnum.DetailsBarImage.rawValue)
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    // user can optionaly send his lat and lon to get his city's current weather as an element of the returned list
    func getWeatherList(lat: Double?, lon: Double?) {
        self.showLoadingView()
        viewModel.getCitiesList(currentlat: lat, currentLon: lon, onSuccess: { [weak self] citiesList in
            self?.citiesList = citiesList
            self?.tableView.reloadData()
            self?.hideLoadingView()
        }, onAPIError: { [weak self] error in
            self?.hideLoadingView()
            self?.showErrorView(title: "", description: error)
        }) { [weak self] error in
            self?.hideLoadingView()
            self?.showErrorView(title: "", description: error)
        }
    }

    @IBAction func addButtonDidPressed(_ sender: Any) {
        let vm = ChooseCountryViewModel(fileName: CitiesListFileEnum.name.rawValue, fileType: CitiesListFileEnum.type.rawValue)
        let vc = SelectCityViewController(viewModel: vm, router: router)
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }

}
