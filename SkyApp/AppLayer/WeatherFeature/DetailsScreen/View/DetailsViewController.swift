//
//  DetailsViewController.swift
//  SkyApp
//
//  Created by Guest2 on 12/26/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit

class DetailsViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    let viewModel: DetailsViewModel
    let router: WeatherRouter
    
    // MARK: - Initializers
    init(viewModel: DetailsViewModel, router: WeatherRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = DetailsViewModel()
        self.router = WeatherRouter()
        super.init(coder: aDecoder)
    }
    
    public override init(nibName: String?, bundle: Bundle?) {
        viewModel = DetailsViewModel()
        self.router = WeatherRouter()
        super.init(nibName: nibName, bundle: bundle)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNaviagtionBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupNaviagtionBar() {
        let img = UIImage(named: ImagesEnum.DetailsBarImage.rawValue)
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: DetailsTableViewCellEnum.nibName.rawValue, bundle: nil), forCellReuseIdentifier: DetailsTableViewCellEnum.CellReuseIdentifier.rawValue)
        tableView.backgroundView = UIImageView(image: UIImage(named: ImagesEnum.HomeBackGroundImage.rawValue))
        tableView.delegate = self
        tableView.dataSource = self
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
