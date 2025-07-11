//
//  ConvertViewController.swift
//  Currency Today
//
//  Created by Student on 02.07.25.
//

import UIKit

class ConvertOption{
    var name : String
    var backgroundColor : UIColor
    var backgroundImage: UIImage
    var api:String
    
    init(name: String,backgroundColor: UIColor,backgroundImage:UIImage,api:String) {
        self.name = name
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.api = api
    }
}

class ConvertViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var models = [ConvertOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ConvertTableViewCell.self, forCellReuseIdentifier: ConvertTableViewCell.identifier)
        configure()
    }
    
    func configure(){
        models.append(contentsOf:[
            ConvertOption(name: "AMD", backgroundColor: .white, backgroundImage: UIImage(named: "Armenia")!, api: "https://open.er-api.com/v6/latest/AMD"),
            ConvertOption(name: "RUB", backgroundColor: .white, backgroundImage: UIImage(named: "Russia")!, api: "https://open.er-api.com/v6/latest/RUB"),
            ConvertOption(name: "USD", backgroundColor: .white, backgroundImage: UIImage(named: "USA")!, api: "https://open.er-api.com/v6/latest/USD"),
            ConvertOption(name: "EUR", backgroundColor: .white, backgroundImage: UIImage(named: "EUR")!, api: "https://open.er-api.com/v6/latest/EUR"),
            ConvertOption(name: "GEL", backgroundColor: .white, backgroundImage: UIImage(named: "Georgia")!, api: "https://open.er-api.com/v6/latest/GEL"),
            ConvertOption(name: "CNY", backgroundColor: .white, backgroundImage: UIImage(named: "China")!, api: "https://open.er-api.com/v6/latest/CNY"),
            ConvertOption(name: "JPY", backgroundColor: .white, backgroundImage: UIImage(named: "Japan")!, api: "https://open.er-api.com/v6/latest/JPY"),
            ConvertOption(name: "INR", backgroundColor: .white, backgroundImage: UIImage(named: "India")!, api: "https://open.er-api.com/v6/latest/INR"),
            ConvertOption(name: "INR", backgroundColor: .white, backgroundImage: UIImage(named: "Turkey")!, api: "https://open.er-api.com/v6/latest/TRY"),
            ConvertOption(name: "INR", backgroundColor: .white, backgroundImage: UIImage(named: "Canada")!, api: "https://open.er-api.com/v6/latest/CAD"),
            ConvertOption(name: "INR", backgroundColor: .white, backgroundImage: UIImage(named: "UAE")!, api: "https://open.er-api.com/v6/latest/AED"),
        ])
    }
    
    @IBAction func Course(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "CourseViewController") as? CourseViewController
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

extension ConvertViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConvertTableViewCell.identifier, for: indexPath) as? ConvertTableViewCell
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
        
        if models[indexPath.item].name != "" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ComvertViewController")as!
            ComvertViewController
            vc.ap = models[indexPath.item].api
            vc.text = models[indexPath.item].name
            self.present(vc,animated: true)
        }
    }
}
