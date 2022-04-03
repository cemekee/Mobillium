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
}

extension MainViewController {
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SliderCell", bundle: nil), forCellReuseIdentifier: "SliderCell")
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    func loadData(){
        viewModel.fetchUpcomingMovies()
        viewModel.fetchPlayingMovies()
    }
    
    func initVM(){
        viewModel.updateUI = { [weak self] in 
            self?.tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getUpcomingMovies()?.results.count ?? 0
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
            cell.configure(imgUrl: data?.results[indexPath.row - 1 ].posterPath ?? "", lblTitle: data?.results[indexPath.row - 1].title ?? "", lblDescription: data?.results[indexPath.row - 1].overview ?? "", lblDate: data?.results[indexPath.row - 1].releaseDate ?? "")
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC
//           vc!.movieDetail = self.viewModel.movie
//           self.navigationController?.pushViewController(vc!, animated: true)
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 1 {
            return 256
        }
        return 136
        
    }
    
    
    
}
