//
//  ViewController.swift
//  Mobillium
//
//  Created by Cem Eke on 2.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = MainViewModel()
    
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
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SliderCell", bundle: nil), forCellReuseIdentifier: "SliderCell")
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(didPullToRefresh),
                                            for: .valueChanged)
    }
    
    @objc private func didPullToRefresh(){
        loadData()
    }
    
    func initVM(){
        viewModel.updateUI = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.showError = {[weak self] in
            self?.showErrorPopUp()
        }
    }
    
    func loadData(){
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.tableView.refreshControl?.endRefreshing()
            self.viewModel.removeAll()
            self.viewModel.currentPage = 1
            self.viewModel.fetchUpcomingMovies()
            self.viewModel.fetchPlayingMovies()
        }
        
    }
    
    func showErrorPopUp(){
        let alert = UIAlertController(title: "Error", message: "Fetch Error", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func fetchNextPage(isPagination:Bool){
        DispatchQueue.main.async {
            self.tableView.tableFooterView = nil
        }
        
        viewModel.currentPage += 1
        viewModel.fetchUpcomingMovies(pagination: isPagination)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getUpcomingMovies().count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        if indexPath.row < 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SliderCell", for: indexPath) as! SliderCell
            let data = viewModel.getPlayingMovies()
            cell.configure(imgUrl: data?.results[indexPath.row].posterPath ?? "", lblTitle: data?.results[indexPath.row].title ?? "", lblDescription: data?.results[indexPath.row].overview ?? "")
            return cell
        }
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
            let data = viewModel.getUpcomingMovies()
        cell.configure(imgUrl: data[indexPath.row].posterPath ?? "", lblTitle: data[indexPath.row].title ?? "", lblDescription: data[indexPath.row].overview ?? "", lblDate: data[indexPath.row].releaseDate ?? "")
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
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
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x:0, y:0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
}
