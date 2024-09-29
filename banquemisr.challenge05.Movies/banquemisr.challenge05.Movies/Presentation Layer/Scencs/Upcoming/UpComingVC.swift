import UIKit

class UpComingVC: UITableViewController {
    private var viewModel = UpcomingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")

        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.fetchUpcomingMovies() 
        
        viewModel.showError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.presentErrorAlert(message: errorMessage)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Upcoming"
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
        cell.titleLabel.text = movie?.title ?? "Unknown"
        cell.releaseDateLabel.text = movie?.release_date ?? "Unknown"
        cell.posterImageView.image = viewModel.didSelectImage(at: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as? MovieDetailsVC else { return }
        detailsVC.movie = viewModel.didSelectMovie(at: indexPath.row)
        detailsVC.image = viewModel.didSelectImage(at: indexPath.row)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
