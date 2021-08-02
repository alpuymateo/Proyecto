//
//  MovieTableViewCell.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 27/7/21.
//

import UIKit
protocol MovieCollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: MovieCollectionViewCell?, index: Int, didTappedInTableViewCell: MovieTableViewCell)
    func collectionView(collectionviewcell: TapMoreCollectionViewCell?, index: Int, didTappedInTableViewCell: MovieTableViewCell)

    // other delegate methods that you can define to perform action in viewcontroller
}
class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var MovieLabel: UILabel!
    

    @IBOutlet weak var MovieCollection: UICollectionView!
    weak var cellDelegate: MovieCollectionViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        let nib: UINib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        self.MovieCollection.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        let nib2: UINib = UINib(nibName: "TapMoreCollectionViewCell", bundle: nil)
        self.MovieCollection.register(nib2, forCellWithReuseIdentifier: "TapMoreCollectionViewCell")
        MovieCollection.delegate = self
        MovieCollection.dataSource = self

        // Initialization code
        self.MovieCollection.isPagingEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
        // Configure the view for the selected state
    }
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        
    }
}

extension MovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func updateCellWith(row: [Movie]) {
//        self.rowWithMovies = row
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.item < 10){
            let cell = collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell
            print("I'm tapping the \(indexPath.item)")
            self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
        } else{
            let cell = collectionView.cellForItem(at: indexPath) as? TapMoreCollectionViewCell
            print("cellll")
            self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
            
//            self.cellDelegate?.collectionView(collectionviewcell: cell2, index: indexPath.item, didTappedInTableViewCell: self)
           
        }
       
       
        
       
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
//        cell.MovieCollectionLabel.text = self.rowWithMovies?[indexPath.item].title ?? ""
//        let path = self.rowWithMovies?[indexPath.item].poster_path
//        let url = "https://image.tmdb.org/t/p/w500"
//        let url2 = URL(string: url + path!)
//        if let data = try? Data(contentsOf: url2!) {
               // Create Image and Update Image View
//            cell.MovieCollectionImage.image = UIImage(data: data)
//           }
        return UICollectionViewCell.init()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.rowWithMovies?.count ?? 0
        return 1
    }
    
    }

