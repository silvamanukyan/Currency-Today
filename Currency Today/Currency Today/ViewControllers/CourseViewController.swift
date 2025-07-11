//
//  CourseViewController.swift
//  Currency Today
//
//  Created by Student on 02.07.25.
//

import UIKit

class CourseOption{
    var name : String
    var currency : String
    var course : String
    var backgroundColor : UIColor
    var backgroundImage: UIImage
    
    init(name: String, currency: String, course: String, backgroundColor: UIColor,backgroundImage:UIImage) {
        self.name = name
        self.currency = currency
        self.course = course
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
    }
}

class CourseViewController: UIViewController {

    @IBOutlet weak var date: UINavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var models = [CourseOption]()
    var volues : [Double] = []
    var currencyCode:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CourseTableViewCell.self, forCellReuseIdentifier: CourseTableViewCell.identifier)
        currentData()
        fetchJson()
        configure()
    }
    
    func currentData(){
        var now = Date()
        var nowComponents = DateComponents()
        let calendar = Calendar.current
        nowComponents.year = Calendar.current.component(.year, from: now)
        nowComponents.month = Calendar.current.component(.month, from: now)
        nowComponents.day = Calendar.current.component(.day, from: now)
        nowComponents.timeZone = NSTimeZone.local
        now = calendar.date(from: nowComponents)!
        date.topItem?.title = "\(nowComponents.day!).\(nowComponents.month!).\(nowComponents.year!)"
    }
    
    func configure(){
        models.append(contentsOf: [
            CourseOption(name: "AMD", currency: "Armenia", course: "1", backgroundColor: .white, backgroundImage: UIImage(named: "Armenia")!),
            CourseOption(name: "RUB", currency: "Russia", course: "1", backgroundColor: .white, backgroundImage: UIImage(named:"Russia")!),
            CourseOption(name: "USD", currency: "USA", course: "1", backgroundColor: .white, backgroundImage: UIImage(named: "USA")!),
            CourseOption(name: "EUR", currency: "Europe", course: "1", backgroundColor: .white, backgroundImage: UIImage(named: "EUR")!),
            CourseOption(name: "GEL", currency: "Georgia", course: "1", backgroundColor: .white, backgroundImage: UIImage(named: "Georgia")!),
            CourseOption(name: "CNY", currency: "China", course: "1", backgroundColor: .white, backgroundImage: UIImage(named: "China")!),
            CourseOption(name: "JPY", currency: "Japan", course: "1", backgroundColor: .white, backgroundImage: UIImage(named: "Japan")!),
            CourseOption(name: "INR", currency: "India", course: "1", backgroundColor: .white, backgroundImage: UIImage(named: "India")!),
            CourseOption(name: "TRY", currency: "Turkey", course: "1", backgroundColor: .white, backgroundImage: UIImage(named: "Turkey")!),
            CourseOption(name: "CAD", currency: "Canada", course: "1", backgroundColor: .white, backgroundImage: UIImage(named: "Canada")!),
            CourseOption(name: "AED", currency: "UAE", course: "1", backgroundColor: .white, backgroundImage: UIImage(named: "UAE")!),
            
            
            
                   
                    
        ])
        
    }
    func fetchJson() {
            guard let url = URL(string: "https://open.er-api.com/v6/latest/AMD") else { return }
            URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                guard let safeData = data else { return }
                
                do {
                    let rezults = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
                    self.currencyCode.append(contentsOf: rezults.rates.keys)
                    self.volues.append(contentsOf: rezults.rates.values)
                    rezults.rates.forEach {(key, value) in
                        self.models = self.models.map {
                            if $0.name == key {
                                let courseKey = (Double(models[0].course) ?? 0)/value
                                $0.course = "\(Double(round(100 * courseKey) / 100))"
                            }
                            return $0
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                catch {
                    print(error)
                }
            }.resume()
        }
    
    @IBAction func Convert(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "ConvertViewController") as? ConvertViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
    
    @IBAction func Settings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
    
}

extension CourseViewController:
    UITableViewDelegate,
    UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CourseTableViewCell.identifier, for: indexPath) as? CourseTableViewCell
        else{
            return UITableViewCell()
        }
        cell.configure(with:model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    

}

