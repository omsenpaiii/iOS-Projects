import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var isSecondScreen = false
    var details: [String] = ["Name: Om Tomar", "Age: 20", "Qualification: BTech in Computer Science", "Role: Developer"]
    
    let firstScreenDetails: [String] = ["Name: Om Tomar", "Age: 20", "Qualification: BTech in Computer Science", "Role: Developer"]
    let secondScreenDetails: [String] = ["Name: Sharanjit Kaur", "Age: 35", "Qualification: Experienced Tutor", "Role: App Design"]

    @IBOutlet weak var rateHeading: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var changeOfText: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var tableInfo: UITableView!
    @IBOutlet weak var ratingSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    @IBAction func ratingSlider(_ sender: UISlider) {
        updateRatingLabel()
    }

    func setup() {
        view.backgroundColor = UIColor.systemGray6
        setupFirstScreen()
        
        tableInfo.register(UITableViewCell.self, forCellReuseIdentifier: "infoCell")
        tableInfo.delegate = self
        tableInfo.dataSource = self
        
        // Styling the table view
        tableInfo.layer.cornerRadius = 10
        tableInfo.layer.borderWidth = 1
        tableInfo.layer.borderColor = UIColor.systemGray4.cgColor
        tableInfo.clipsToBounds = true
        
        // Configure slider
        ratingSlider.minimumValue = 1
        ratingSlider.maximumValue = 5
        ratingSlider.value = 1
        ratingSlider.addTarget(self, action: #selector(ratingSlider(_:)), for: .valueChanged)
        
        // Initialize rating label with the slider's value
        updateRatingLabel()
    }

    @IBAction func toggle(_ sender: Any) {
        isSecondScreen.toggle()
        tableInfo.reloadData()

        if isSecondScreen {
            changeOfText.text = "About my Teammate!"
            changeOfText.font = UIFont.boldSystemFont(ofSize: 18)
            changeOfText.textColor = UIColor.white
            myImage.image = UIImage(named: "secondImage")
            view.backgroundColor = UIColor.systemIndigo
            
            details = secondScreenDetails
        } else {
            setupFirstScreen()
        }
    }

    @IBAction func submitButton(_ sender: Any) {
        let alert = UIAlertController(title: "Update Details", message: "Edit the details below:", preferredStyle: .alert)
        
        for (index, detail) in details.enumerated() {
            let detailText = detail.components(separatedBy: ": ").last ?? ""
            alert.addTextField { textField in
                textField.text = detailText
                textField.placeholder = detail.components(separatedBy: ": ").first
            }
        }
        
        let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
            if let textFields = alert.textFields {
                for (index, textField) in textFields.enumerated() {
                    if let text = textField.text, !text.isEmpty {
                        let fieldName = self.details[index].components(separatedBy: ": ").first ?? ""
                        self.details[index] = "\(fieldName): \(text)"
                    }
                }
                self.tableInfo.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(updateAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    func setupFirstScreen() {
        changeOfText.text = "About me!"
        changeOfText.font = UIFont.boldSystemFont(ofSize: 18)
        changeOfText.textColor = UIColor.white
        myImage.image = UIImage(named: "firstImage")
        view.backgroundColor = UIColor.systemTeal
        
        details = firstScreenDetails
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cell.textLabel?.textColor = UIColor.label
        cell.backgroundColor = UIColor.systemBackground
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.contentView.backgroundColor = UIColor.systemBackground
        cell.layer.borderColor = UIColor.systemGray4.cgColor
        cell.layer.borderWidth = 0.5

        cell.textLabel?.text = details[indexPath.row]
        
        return cell
    }
    
  
    
    func updateRatingLabel() {
        guard let ratingLabel = ratingLabel else {
            print("ratingLabel is not connected")
            return
        }
        
        let rating = Int(round(ratingSlider.value))
        ratingLabel.text = "Rating: \(rating)"
    }
}
