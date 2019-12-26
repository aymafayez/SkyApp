//
//  ChooseCountryViewController.swift
//  SkyApp
//
//  Created by Guest2 on 12/27/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit

class ChooseCountryViewController: BaseViewController {

    // MARK: - Properties
    let viewModel: ChooseCountryViewModel
    let router: WeatherRouter
    weak var delegate: ChooseCountryDelegate?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Initializers
    init(viewModel: ChooseCountryViewModel, router: WeatherRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = ChooseCountryViewModel()
        self.router = WeatherRouter()
        super.init(coder: aDecoder)
    }
    
    public override init(nibName: String?, bundle: Bundle?) {
        viewModel = ChooseCountryViewModel()
        self.router = WeatherRouter()
        super.init(nibName: nibName, bundle: bundle)
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: SearchCountryTableViewCellEnum.nibName.rawValue, bundle: nil), forCellReuseIdentifier: SearchCountryTableViewCellEnum.CellReuseIdentifier.rawValue)
    }

    @IBAction func doneButtonIsPressed(_ sender: Any) {
        delegate?.didSelectCurrency(country: "")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonIsPressed(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
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
