import UIKit

class movieDetailsVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblreleaseDate: UILabel!
    
    @IBOutlet weak var lblOverView: UILabel!
    
    @IBOutlet weak var lblGenre: UILabel!
    
    var movie: Movie?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.image = image ?? UIImage(systemName: "photo")
        lblTitle.text = "Name: \(movie?.title ?? "Unknown")"
        lblreleaseDate.text = "Released At: \(movie?.release_date ?? "Unknown")"
        lblGenre.text = "Genres: \(Helpers.convertGenreIdsToString(ids: (movie?.genre_ids)!) ?? "Unknown")"
        lblOverView.text = "Overview: \(movie?.overview ?? "Unknown")"
        
    }
    

}
