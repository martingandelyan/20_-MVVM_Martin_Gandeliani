//
//  ViewController.swift
//  19_Networking-2_Martin_Gandeliani
//
//  Created by Martin on 28.11.25.
//
import UIKit

class MovieViewController: UIViewController, UITableViewDelegate {
    var movie: [Movie] = []
    var viewModel = MovieViewModel()

    let moviesTableView = UITableView()
    let actionBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        bindViewModel()
        viewModel.loadAllMovies()
    }
    
    func setupUi() {
        view.addSubview(moviesTableView)
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
        moviesTableView.backgroundColor = .white
        moviesTableView.register(MoviewCell.self, forCellReuseIdentifier: "MoviewCell")
        
        view.addSubview(actionBtn)
        actionBtn.translatesAutoresizingMaskIntoConstraints = false
        actionBtn.setTitle(" ფილმის ჩვენება ", for: .normal)
        actionBtn.setTitleColor(.white, for: .normal)
        actionBtn.backgroundColor = .systemBlue
        actionBtn.layer.cornerRadius = 5
        actionBtn.addAction(UIAction(handler: { action in
            self.addMovieBtnPressed()
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            moviesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            actionBtn.bottomAnchor.constraint(equalTo: moviesTableView.bottomAnchor, constant: -20),
            actionBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            actionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    func addMovieBtnPressed() {
        //add action
        viewModel.getNextMovie()
    }
    
    func bindViewModel() {
        viewModel.moviesUploaded = { [weak self] in
            guard let self = self else { return }
            self.movie = self.viewModel.movie
            self.moviesTableView.reloadData()
        }
        
        viewModel.showAlert = { [weak self] in
            let alert = UIAlertController(title: "ფილმების მაქსიმალური რაოდენობა ჩაიტვირთა", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "დახურვა", style: .default, handler: nil))
            self?.present(alert, animated: true)
        }
    }
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "MoviewCell", for: indexPath) as! MoviewCell
        let currentMovie = movie[indexPath.row]
        
        movieCell.configure(with: currentMovie)
              
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentMovie = movie[indexPath.row]
        
        let movieDetailViewController = MovieDetailsViewController(movie: currentMovie)
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

import SwiftUI

#Preview {
    MovieViewController()
}
