import UIKit

class NowPlayingVC: UITableViewController {
    
    private var viewModel = NowPlayingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        
        viewModel.reloadTable = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.fetchNowPlayingMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Now Playing"
        Helpers.configureTabBarAppearance(for: tabBarItem)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        let movie = viewModel.movies[indexPath.row]
        cell.lblTitle.text = movie.title
        cell.lblReleaseDate.text = movie.release_date

        if indexPath.row < viewModel.imgs.count {
            cell.img.image = viewModel.imgs[indexPath.row]
        } else {
            cell.img.image = UIImage(systemName: "photo")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "movieDetailsVC") as! movieDetailsVC
        detailsVC.movie = viewModel.movies[indexPath.row]
        detailsVC.image = viewModel.imgs[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
