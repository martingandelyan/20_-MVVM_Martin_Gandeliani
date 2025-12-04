//
//  MovieViewModel.swift
//  20_ MVVM_Martin_Gandeliani
//
//  Created by Martin on 01.12.25.
//

import Foundation

class MovieViewModel {
    var moviesManager = MoviesManager()
    
    var allMovies: [Movie] = []
    var movie: [Movie] = []
    var currentIndexOfMovie = 0
    
    var moviesUploaded: (() -> Void)?
    
    func getNextMovie() {
        moviesManager.getMoviesData { [weak self] newMovies in
            guard let self = self else { return }
            
            if self.currentIndexOfMovie < newMovies.count {
                let nextMovie = newMovies[self.currentIndexOfMovie]
                self.movie.append(nextMovie)
                self.currentIndexOfMovie += 1
                self.moviesUploaded?()
            }
        }
    }
}
