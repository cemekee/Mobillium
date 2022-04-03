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
    }
    
    func initVM(){
        viewModel.updateUI = { [weak self] in
                self?.tableView.reloadData()
        }
    }
    
    func loadData(){
        viewModel.fetchUpcomingMovies()
        viewModel.fetchPlayingMovies()
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
        cell.configure(imgUrl: data[indexPath.row - 1 ].posterPath ?? "", lblTitle: data[indexPath.row - 1].title ?? "", lblDescription: data[indexPath.row - 1].overview ?? "", lblDate: data[indexPath.row - 1].releaseDate ?? "")
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
            print("more data")
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
