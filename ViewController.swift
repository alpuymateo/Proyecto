//
//  ViewController.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 21/7/21.
//

import UIKit
import Alamofire
import Kingfisher


class ViewController: UIViewController, MovieCollectionViewCellDelegate{
    func collectionView(collectionviewcell: TapMoreCollectionViewCell?, index: Int, didTappedInTableViewCell: MovieTableViewCell) {
        let gen1 = (collectionviewcell?.ViewMoreLabel.text) ?? ""
        self.genre = Int(gen1)!
        performSegue(withIdentifier: "tapmoresegue", sender: self)
        
    }
    func collectionView(collectionviewcell: MovieCollectionViewCell?, index: Int, didTappedInTableViewCell: MovieTableViewCell) {
        //        print("Index \(index) )")
        for item in self.list {
            for item2 in item.Movies {
                if(item2.id == Int(collectionviewcell!.MovieCollectionMovieId.text!)){
                    self.tappedCell = item2                }
            }
        }
        performSegue(withIdentifier: "detailsviewcontrollerseg", sender: self)
        
    }
    
    var list = [CategoryMovieModel]()
    var genres = [Genre]()
    var movies = [Movie]()
    var tappedCell: Movie!
    var genre = 0
    var dicc: [UICollectionView : Int] = [:]
    @IBOutlet weak var MoviesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        print("TENGO SINGLETON \(Singleton.shared.session_id!)")
        MoviesTableView.dataSource = self
        MoviesTableView.delegate = self
        let nib: UINib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        MoviesTableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")
        
        func getMovies() {
            for genre in self.genres {
                if(Settings.shared.categories.contains(genre.id)){
                    LoadGroup(genre: genre)
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
        
        //        cell.MovieCollection.delegate = self
        cell.MovieCollection.dataSource = self
        
        //        let rowArray = self.list[indexPath.section].Movies
        //        cell.updateCellWith(row: rowArray)
        cell.cellDelegate = self
        
        dicc[cell.MovieCollection] = indexPath.section
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
        if segue.identifier == "tapmoresegue" {
            let CategoryDetailViewController = segue.destination as! CategoryDetailViewController
            CategoryDetailViewController.genre =  self.genre
            
        }
    }
    
    
}
extension ViewController: UICollectionViewDataSource   {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        let numberOfSections =  dicc[collectionView]
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row > 9){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TapMoreCollectionViewCell", for: indexPath) as! TapMoreCollectionViewCell
            cell.ViewMoreLabel.text = String(self.list[dicc[collectionView]!].Genre.id)
            return cell
        }else {
            print("INDEX PATH \(indexPath.row)")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
//            print("DICC place \(dicc[collectionView]!) generoo \(self.list[dicc[collectionView]!].Genre.name!) ")
            cell.MovieCollectionLabel.text = self.list[dicc[collectionView]!].Movies[indexPath.row].title
            let path = self.list[dicc[collectionView]!].Movies[indexPath.row].poster_path
            let url = "https://image.tmdb.org/t/p/w500"
            let url2 = URL(string: url + path!)
            cell.MovieCollectionImage.kf.setImage(with: url2)
            
            cell.MovieCollectionMovieId.text = String(self.list[dicc[collectionView]!].Movies[indexPath.row].id)
            return cell
        }
    }
}


