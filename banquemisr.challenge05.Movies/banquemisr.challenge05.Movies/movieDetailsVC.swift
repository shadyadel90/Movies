import UIKit

class movieDetailsVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblreleaseDate: UILabel!
    
    @IBOutlet weak var txtOverView: UITextView!
    
    @IBOutlet weak var lblGenre: UILabel!
    
    var movie: Movie?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.image = image
        lblTitle.text = movie?.title
        lblreleaseDate.text = movie?.release_date
        lblGenre.text = "\(String(describing: movie?.genre_ids))"
        txtOverView.text = movie?.overview
    }
    

}
