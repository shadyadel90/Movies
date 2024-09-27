import UIKit

class UpComingVC: UITableViewController {
    var movies: [Movie] = []
    var imgs: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        NetworkService.fetchDataFromApi(movieListType: .upcoming) { [weak self] result, error in
            guard let self = self else { return }
            if let moviesResult = result {
                self.movies = moviesResult
                for movie in self.movies {
                    if let posterPath = movie.poster_path {
                        NetworkService.downloadImage(imageUrl: posterPath) { [weak self] img, error in
                            guard let self = self else { return }
                            if let downloadedImage = img {
                                self.imgs.append(downloadedImage)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            } else {
                print("Error fetching data: \(String(describing: error))")
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Upcoming"
       
        Helpers.configureTabBarAppearance(for: tabBarItem)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        let movie = movies[indexPath.row]
        cell.lblTitle.text = movie.title
        cell.lblReleaseDate.text = movie.release_date

        if indexPath.row < imgs.count {
            cell.img.image = imgs[indexPath.row]
        } else {
            cell.img.image = UIImage(systemName: "photo") 
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "movieDetailsVC") as! movieDetailsVC
        detailsVC.movie = movies[indexPath.row]
        detailsVC.image = imgs[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
