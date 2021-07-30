//
//  ViewController.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 21/7/21.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    var list = [CategoryMovieModel]()
    var genres = [Genre]()
    var movies = [Movie]()
    var tappedCell: Movie!

    @IBOutlet weak var MenuBar: UIBarButtonItem!
    //    var error = Error()
    @IBOutlet weak var MoviesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib: UINib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        MoviesTableView.dataSource = self
        MoviesTableView.delegate = self
        MoviesTableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")

//        APIClient.shared.request(request: Router.getToken, onCompletion: { (result) in
//            switch result{
//            case .success:
//                print(result)
//            case .failure:
//                print("Error")
//            }
//        }
//        )
        
        func getGenres() {
            for genre in self.genres {
                print(genre.name!)
            }
        }
        func getMovies() {
            for genre in self.genres {
                switch genre.id {
                case 28:
                    LoadGroup(genre: genre)
                case 12:
                    LoadGroup(genre: genre)
                case 16:
                    LoadGroup(genre: genre)
                case 10751:
                    LoadGroup(genre: genre)
                case 36:
                    LoadGroup(genre: genre)
                case 10402:
                    LoadGroup(genre: genre)
                case 10749:
                    LoadGroup(genre: genre)
                case 35:
                    LoadGroup(genre: genre)
                default:
                    print()
                }
            }
        }
        APIClient.shared.requestItems(request: Router.getGenre,responseKey: "genres", onCompletion: {(result:Result<[Genre],Error>)
            in
            switch (result){
            case .success(let genre): self.genres = genre
            case .failure(let error ): print(error)
            }
            getMovies()
            self.MoviesTableView.reloadData()
        })

        func LoadGroup(genre:Genre){
            APIClient.shared.requestItems(request: Router.getMoviesByGenre(genreId: genre.id), responseKey: "results", onCompletion:{(result:Result<[Movie],Error>)
                    in
                    switch (result){
                    case .success(let movie): self.movies = movie ;
                    case .failure(let error ): print(error)
                    }
                   let a = CategoryMovieModel(Genre: genre, Movies: self.movies)
                    self.list.append(a)
                    self.MoviesTableView.reloadData()
                })
        }
        
        

      
           }
    }


extension ViewController:  UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
            let rowArray = self.list[indexPath.section].Movies
        cell.updateCellWith(row: rowArray)
        cell.cellDelegate = self

        return cell


    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.list.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 200
       }
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 44
        }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Prueba"
    }
    
    // Category Title
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
//        headerView.backgroundColor = UIColor.colorFromHex("#BC224B")
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 0, width: 200, height: 44))
        headerView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = self.list[section].Genre.name
        return headerView
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "detailsviewcontrollerseg" {
        let DestViewController = segue.destination as! DetailedViewController
        DestViewController.movie = self.tappedCell
    }
}

}
extension ViewController: MovieCollectionViewCellDelegate {
func collectionView(collectionviewcell: MovieCollectionViewCell?, index: Int, didTappedInTableViewCell: MovieTableViewCell) {
    print("llegue")
    if let movieRow = didTappedInTableViewCell.rowWithMovies {
        self.tappedCell = movieRow[index]
        performSegue(withIdentifier: "detailsviewcontrollerseg", sender: self)
        // You can also do changes to the cell you tapped using the 'collectionviewcell'
    }
}
}




