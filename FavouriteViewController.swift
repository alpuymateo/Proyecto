//
//  FavouriteViewController.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 2/8/21.
//

import UIKit

class FavouriteViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, CategoryMovieTableViewCellDelegate {
    
    
    
    @IBOutlet weak var FavouriteTableView: UITableView!
    var movies = [Movie]()
    var tappedCell = CategoryMovieTableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        FavouriteTableView.dataSource = self
        FavouriteTableView.delegate = self
        let nib: UINib = UINib(nibName: "CategoryMovieTableViewCell", bundle: nil)
        FavouriteTableView.register(nib, forCellReuseIdentifier: "CategoryMovieTableViewCell")
        LoadGroup()
//        LoadGr
//        SetFavorite()
      
//        print(.urlRequest!)
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryMovieTableViewCell", for: indexPath) as! CategoryMovieTableViewCell
        cell.configure(name: self.movies[indexPath.row].title)
        let path = self.movies[indexPath.row].poster_path
        let url = "https://image.tmdb.org/t/p/w500"
        let url2 = URL(string: url + path!)
        cell.MovieImage.kf.setImage(with: url2)
        cell.RatingView.rating =  (self.movies[indexPath.row].vote_average)/2

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favouritedetail" {
            let DestViewController = segue.destination as! DetailedViewController
            DestViewController.movie = self.tappedCell.movie
        }
    }
    
//    func SetFavorite(){
//        print(Router.setFavorite(session_id: Settings.shared.session_id!, movie_id: 508943).urlRequest)
//        APIClient.shared.requestItem(request: Router.setFavorite(session_id: Settings.shared.session_id!, movie_id: 508943), responseKey: "", onCompletion:{(result:Result<SuccessPostModel,Error>)
//            in
//            switch (result){
//            case .success(let success):print( success) ;
//            case .failure(let error ): print(error)
//            }
//            self.FavouriteTableView.reloadData()
//        })
//    }
    
    func LoadGroup(){
        APIClient.shared.requestItems(request: Router.getFavorites, responseKey: "results", onCompletion:{(result:Result<[Movie],Error>)
            in
            switch (result){
            case .success(let movie): self.movies = movie ;
            case .failure(let error ): print(error)
            }
            self.FavouriteTableView.reloadData()
            
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        LoadGroup()
    }
    override func viewDidAppear(_ animated: Bool) {
        LoadGroup()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.movies[indexPath.row].title!)
        self.tappedCell.movie = self.movies[indexPath.row]
        performSegue(withIdentifier:"favouritedetail", sender: nil)
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
