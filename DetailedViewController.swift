//
//  DetailedViewController.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 28/7/21.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var CategoryButton: UIButton!
    @IBOutlet weak var OverviewText: UITextView!
    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var MovieTitleLabel: UILabel!
    var movie :Movie!
    var movies = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadGroup(genre: 18)
        self.MovieTitleLabel.text = movie.title
        let path = self.movie.poster_path
        let url = "https://image.tmdb.org/t/p/w500"
        let url2 = URL(string: url + path!)
        if let data = try? Data(contentsOf: url2!) {
               // Create Image and Update Image View
            self.MovieImage.image = UIImage(data: data)
            
           }
        self.OverviewText.text = self.movie.overview
      
    }
    @IBAction func Category(_ sender: Any) {
        performSegue(withIdentifier: "categorydetailsegue", sender: nil)
    }
    func LoadGroup(genre:Int){
        APIClient.shared.requestItems(request: Router.getMoviesByGenre(genreId: genre), responseKey: "results", onCompletion:{(result:Result<[Movie],Error>)
                in
                switch (result){
                case .success(let movie): self.movies = movie ;
                case .failure(let error ): print(error)
                }
//            print(self.movies.count)
            })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "categorydetailsegue" {
        
        let CategoryDetailViewController = segue.destination as! CategoryDetailViewController
        CategoryDetailViewController.movies = self.movies
        CategoryDetailViewController.genre =      18
        print(self.movies.count)
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
}
