//
//  HomeViewController.swift
//  SkyApp
//
//  Created by Guest2 on 12/26/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    
    // MARK: - Properties
    let viewModel: HomeViewModel
    let router: WeatherRouter
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Initializers
    init(viewModel: HomeViewModel, router: WeatherRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = HomeViewModel()
        self.router = WeatherRouter()
        super.init(coder: aDecoder)
    }
    
    public override init(nibName: String?, bundle: Bundle?) {
        viewModel = HomeViewModel()
        self.router = WeatherRouter()
        super.init(nibName: nibName, bundle: bundle)
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.getForecastList(onSuccess: { _ in
            
        }, onAPIError: { _ in
            
        }) { _ in
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true 
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: HomeTableViewCellEnum.nibName.rawValue, bundle: nil), forCellReuseIdentifier: HomeTableViewCellEnum.CellReuseIdentifier.rawValue)
        tableView.backgroundView = UIImageView(image: UIImage(named: ImagesEnum.HomeBackGroundImage.rawValue))
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func addButtonDidPressed(_ sender: Any) {
        let vm = ChooseCountryViewModel()
        let vc = ChooseCountryViewController(viewModel: vm, router: router)
        self.present(vc, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
