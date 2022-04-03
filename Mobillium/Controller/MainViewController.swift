//
//  ViewController.swift
//  Mobillium
//
//  Created by Cem Eke on 2.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private let viewModel = MainViewModel()
    private let firstCell = FirstCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        initVM()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension MainViewController {
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: StringConstant.firstCell, bundle: nil), forCellReuseIdentifier: StringConstant.firstCell)
        tableView.register(UINib(nibName: StringConstant.movieCell, bundle: nil), forCellReuseIdentifier: StringConstant.movieCell)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(didPullToRefresh),
                                            for: .valueChanged)
    }
    
    @objc private func didPullToRefresh(){
        loadData()
    }
    
    private func initVM(){
        viewModel.updateUI = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.showError = {[weak self] in
            self?.showErrorPopUp()
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getUpcomingMovies().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: StringConstant.firstCell, for: indexPath) as! FirstCell
            let data = viewModel.getPlayingMovies()
            cell.configure(data: data?.results)
            cell.goToDetail = {[weak self] data in
                let vc = UIStoryboard.init(name: StringConstant.main, bundle: Bundle.main).instantiateViewController(withIdentifier: StringConstant.detailViewController) as? DetailViewController
                vc?.selectedMovieId = data
                self?.navigationController?.pushViewController(vc!, animated: true)
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: StringConstant.movieCell, for: indexPath) as! MovieCell
        let data = viewModel.getUpcomingMovies()
        cell.configure(data:data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: StringConstant.main, bundle: Bundle.main).instantiateViewController(withIdentifier: StringConstant.detailViewController) as? DetailViewController
        if indexPath.row < 1 {
            vc?.selectedMovieId = viewModel.getPlayingMovies()?.results[indexPath.row].id
        } else {
            vc?.selectedMovieId = viewModel.getUpcomingMovies()[indexPath.row].id
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 1 {
            return 256
        }
        return 136
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            
            guard !viewModel.isPaginating  else {
                return
            }
            tableView.tableFooterView = createSpinnerFooter()
            fetchNextPage(isPagination: true)
        }
    }
}

extension MainViewController {
    private func loadData(){
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.tableView.refreshControl?.endRefreshing()
            self.viewModel.removeAll()
            self.viewModel.currentPage = 1
            self.viewModel.fetchUpcomingMovies()
            self.viewModel.fetchPlayingMovies()
        }
    }
    
    private func showErrorPopUp(){
        let alert = UIAlertController(title: PopUpConstant.error, message: PopUpConstant.fetchError, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: PopUpConstant.ok, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func fetchNextPage(isPagination:Bool){
        DispatchQueue.main.async {
            self.tableView.tableFooterView = nil
        }
        
        viewModel.currentPage += 1
        viewModel.fetchUpcomingMovies(pagination: isPagination)
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x:0, y:0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
}
