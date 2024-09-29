import UIKit

class MovieDetailsVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblOverView: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    
    var movie: Movie?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        img.image = image ?? UIImage(systemName: "photo")
        
        titleLabel.text = "Name: \(movie?.title ?? "Unknown")"
        
        lblReleaseDate.text = "Released At: \(movie?.release_date ?? "Unknown")"
        
        lblOverView.text = "Overview: \(movie?.overview ?? "Unknown")"
        
        if let genreIds = movie?.genre_ids {
            lblGenre.text = "Genres: \(Helpers.convertGenreIdsToString(ids: genreIds) ?? "Unknown")"
        } else {
            lblGenre.text = "Genres: Unknown"
        }
    }
}
