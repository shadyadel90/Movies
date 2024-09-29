import UIKit

class PopularVC: UITableViewController {
    private var viewModel = PopularViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        
        viewModel.reloadTable = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.fetchNowPlayingMovies()
        
        viewModel.showError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.presentErrorAlert(message: errorMessage)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Popular"
        Helpers.configureTabBarAppearance(for: tabBarItem)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        let movie = viewModel.didSelectMovie(at: indexPath.row)
        cell.lblTitle.text = movie?.title ?? "Unknown"
        cell.lblReleaseDate.text = movie?.release_date ?? "Unknown"

        if indexPath.row < viewModel.numberOfMovies(){
            cell.img.image = viewModel.didSelectImage(at: indexPath.row)
        } else {
            cell.img.image = UIImage(systemName: "photo")
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "movieDetailsVC") as! movieDetailsVC
        detailsVC.movie = viewModel.didSelectMovie(at: indexPath.row)
        detailsVC.image = viewModel.didSelectImage(at: indexPath.row)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
