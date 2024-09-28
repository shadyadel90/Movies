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
        if let movie = movie, let image = image{
            img.image = image
            lblTitle.text = "Name: \(movie.title ?? "")"
            lblreleaseDate.text = "Released At: \(movie.release_date ?? "")"
            lblGenre.text = "Genres: \(Helpers.convertGenreIdsToString(ids: (movie.genre_ids!)))"
            lblOverView.text = "Overview: \(movie.overview ?? "")"
        }
        
    }
    

}
