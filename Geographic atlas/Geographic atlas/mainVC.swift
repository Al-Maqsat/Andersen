import UIKit

class mainVC: UIViewController {

    var tableView = UITableView()
    var countries = [Country]()
    
    struct Cells{
        static let tableView = "tableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        title = "World Countries"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        configureTableView()
        obtainingTheDataFromAPI()
        // Do any additional setup after loading the view.
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 72
        tableView.register(tableViewCell.self, forCellReuseIdentifier: Cells.tableView)
        tableView.pin(to: view)
     }
    
    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func obtainingTheDataFromAPI() {
        let urlString = "https://restcountries.com/v2/all"

        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    // Handle error condition
                    return
                }

                if let data = data {
                    self.parse(json: data)
                }
            }
            task.resume()
        }
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()

        do {
            let jsonInfo = try decoder.decode([Country].self, from: json)
            DispatchQueue.main.async {
                self.countries = jsonInfo
                self.tableView.reloadData()
            }
        } catch {
            print("Error decoding JSON: \(error)")
            // Handle error condition
        }
    }

    
}

extension mainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.tableView) as! tableViewCell
        let country = countries[indexPath.row]
        cell.set(country: country)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryDetails = CountryDetails()
        countryDetails.country = countries[indexPath.row]
        countryDetails.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(countryDetails, animated: true)

    }
        
}

