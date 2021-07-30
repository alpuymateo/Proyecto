//
//  MovieTableViewCell.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 27/7/21.
//

import UIKit
protocol MovieCollectionViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: MovieCollectionViewCell?, index: Int, didTappedInTableViewCell: MovieTableViewCell)
    // other delegate methods that you can define to perform action in viewcontroller
}
class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var MovieLabel: UILabel!
    

    var rowWithMovies : [Movie]?
    @IBOutlet weak var MovieCollection: UICollectionView!
    weak var cellDelegate: MovieCollectionViewCellDelegate?

   
//    func configure(with models:[model]){
//        self.models = models
//        MovieCollection.reloadData()
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        let nib: UINib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        self.MovieCollection.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        MovieCollection.delegate = self
        MovieCollection.dataSource = self

        // Initialization code
        self.MovieCollection.isPagingEnabled = true

        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
//        flowLayout.itemSize = CGSize(width: 250, height: 250)
//        flowLayout.minimumLineSpacing = 2.0
//        flowLayout.minimumInteritemSpacing = 5.0
//        self.MovieCollection.collectionViewLayout = flowLayout
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
    func updateCellWith(row: [Movie]) {
        self.rowWithMovies = row
        self.MovieCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell
        print("I'm tapping the \(indexPath.item)")
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.MovieCollectionLabel.text = self.rowWithMovies?[indexPath.item].title ?? ""
        let path = self.rowWithMovies?[indexPath.item].poster_path
        let url = "https://image.tmdb.org/t/p/w500"
        let url2 = URL(string: url + path!)
        if let data = try? Data(contentsOf: url2!) {
               // Create Image and Update Image View
            cell.MovieCollectionImage.image = UIImage(data: data)
           }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rowWithMovies?.count ?? 0
    }
    
    }

