//
//  SearchViewController.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 30/7/21.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate,  UITableViewDataSource, UITableViewDelegate, CategoryMovieTableViewCellDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    @IBOutlet weak var SearchTab: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    var EndTiping = Bool()
    var resultSearchController = UISearchController()
    var movies2 = [Movie]()
    var movies = [Movie]()
    var filtered = [Movie]()
    var tappedCell = CategoryMovieTableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SearchTab.delegate = self
        TableView.dataSource = self
        TableView.delegate = self
        navigationItem.searchController = self.resultSearchController
        let nib: UINib = UINib(nibName: "CategoryMovieTableViewCell", bundle: nil)
        TableView.register(nib, forCellReuseIdentifier: "CategoryMovieTableViewCell")
        self.LoadLetter(page: 1)

        DispatchQueue.main.asyncAfter(deadline: .now() , execute:{
            for i in 2...20 {
                self.LoadLetter(page: i)
            }
        }
        )

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "searchdetailsegue" {
        let DestViewController = segue.destination as! DetailedViewController
        DestViewController.movie = self.tappedCell.movie
    }
}
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("entreeal de cancelarr")

    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("entreeal de cancelarr")
        self.filtered = self.movies
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.movies[indexPath.row].title!)
        self.tappedCell.movie = self.filtered[indexPath.row]
        performSegue(withIdentifier:"searchdetailsegue", sender: nil)

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filtered.removeAll()
        print("MAMA \(searchText)")
        print(self.movies.count)
        if(!searchText.isEmpty){

            
        for item in self.movies {
            if(item.title.contains(searchText)) && !searchText.isEmpty{
                print(item.title!)
                self.filtered.append(item)
                print("cantidad \(self.filtered.count)")
                self.TableView.reloadData()
            }
            if (searchText.isEmpty){
                self.filtered.append(item)
                self.TableView.reloadData()
            }

        }
    }
        if(searchText == ""){
            self.filtered.append(contentsOf: self.movies)
        }
        self.TableView.reloadData()

    
    }
    func LoadLetter(page: Int){
        APIClient.shared.requestItems(request: Router.getMovies(page: page),responseKey: "results", onCompletion: {(result:Result<[Movie],Error>)
            in
            switch (result){
            case .success(let movie): self.movies2 = movie
            case .failure(let error ): print(error)
            }
            self.movies.append(contentsOf: self.movies2)
            self.filtered.append(contentsOf: self.movies2)
            self.TableView.reloadData()
            print(self.movies.count)
            
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.filtered.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryMovieTableViewCell", for: indexPath) as! CategoryMovieTableViewCell
            cell.configure(name: self.filtered[indexPath.row].title)
            let path = self.filtered[indexPath.row].poster_path
            let url = "https://image.tmdb.org/t/p/w500"
            let url2 = URL(string: url + path!)
            cell.MovieImage.kf.setImage(with: url2)
            cell.RatingView.rating =  (self.movies[indexPath.row].vote_average)/2
            return cell
    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryMovieTableViewCell", for: indexPath) as! CategoryMovieTableViewCell
    //        cell.configure(name: self.movies[indexPath.row].title)
    //        print("entre")
    //        let path = self.movies[indexPath.row].poster_path
    //        let url = "https://image.tmdb.org/t/p/w500"
    //
    //        let url2 = URL(string: url + path!)
    //        cell.MovieImage.kf.setImage(with: url2)
    //        return cell
    //    }
}
