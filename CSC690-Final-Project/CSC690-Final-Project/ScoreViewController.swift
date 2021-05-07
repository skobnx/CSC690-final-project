import UIKit

class ScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ScoreTableView: UITableView!
    @IBAction func CloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    let store = ScoreStore()
    
    var ScoresArray: [Score] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        ScoreTableView.delegate = self
        ScoreTableView.dataSource = self
        ScoreTableView.translatesAutoresizingMaskIntoConstraints = false
        self.ScoreTableView.backgroundColor = UIColor.black
        self.ScoresArray = store.getAllScores()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScoresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        let score = ScoresArray[indexPath.row]
        cell.textLabel?.text = score.score
        return cell
    }
    
}
