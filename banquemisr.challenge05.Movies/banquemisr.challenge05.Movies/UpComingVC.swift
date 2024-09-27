import UIKit

class UpComingVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
      
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
        cell.img.image = UIImage(systemName: "calendar")
        cell.lblTitle.text = "calllll"
        cell.lblReleaseDate.text = "calender2024"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "movieDetailsVC") as! movieDetailsVC
        
        detailsVC.movie = "calendar"

        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
