//
//  DetailsViewController.swift
//  SkyApp
//
//  Created by Guest2 on 12/26/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit

class DetailsViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let viewModel: DetailsViewModel
    let router: WeatherRouter
    var forecastList = [ForecastModel]()
    
    // MARK: - Initializers
    init(viewModel: DetailsViewModel, router: WeatherRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = DetailsViewModel(id: 0)
        self.router = WeatherRouter()
        super.init(coder: aDecoder)
    }
    
    public override init(nibName: String?, bundle: Bundle?) {
        viewModel = DetailsViewModel(id: 0)
        self.router = WeatherRouter()
        super.init(nibName: nibName, bundle: bundle)
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNaviagtionBar()
        getforecastList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: DetailsTableViewCellEnum.nibName.rawValue, bundle: nil), forCellReuseIdentifier: DetailsTableViewCellEnum.CellReuseIdentifier.rawValue)
        tableView.backgroundView = UIImageView(image: UIImage(named: ImagesEnum.HomeBackGroundImage.rawValue))
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupNaviagtionBar() {
        let img = UIImage(named: ImagesEnum.DetailsBarImage.rawValue)
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func getforecastList() {
        viewModel.getFiveDaysForecast(onSuccess: { [weak self] List in
            self?.forecastList = List
            self?.tableView.reloadData()
        }, onAPIError: { [weak self] error in
            self?.showErrorView(title: "API Error", description: error)
        }, onConnectionError:  { [weak self] error in
            self?.showErrorView(title:  "Connection Error", description: error)
        })
    }

}
