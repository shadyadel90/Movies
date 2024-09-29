import UIKit

class PopularVC: UITableViewController {
    private var viewModel = PopularViewModel()
    
    private let cellIdentifier = "MovieTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.fetchPopularMovies()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieTableViewCell
        
        if let movie = viewModel.didSelectMovie(at: indexPath.row) {
            cell.titleLabel.text = movie.title ?? "Unknown"
            cell.releaseDateLabel.text = movie.release_date ?? "Unknown"
            cell.posterImageView.image = viewModel.didSelectImage(at: indexPath.row) ?? UIImage(systemName: "photo")
        } else {
            cell.titleLabel.text = "Unknown"
            cell.releaseDateLabel.text = "Unknown"
            cell.posterImageView.image = UIImage(systemName: "photo")
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as? MovieDetailsVC else {
            return
        }
        
        detailsVC.movie = viewModel.didSelectMovie(at: indexPath.row)
        detailsVC.image = viewModel.didSelectImage(at: indexPath.row)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
