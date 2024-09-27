import UIKit

class movieDetailsVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblreleaseDate: UILabel!
    
    @IBOutlet weak var txtOverView: UITextView!
    
    @IBOutlet weak var lblGenre: UILabel!
    
    var movie: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.image = UIImage(systemName: movie)
    }
    

}
