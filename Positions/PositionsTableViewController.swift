import UIKit

import GRDB


private let positionsSortedByTimestamp = Position.order(Column("timestamp").desc)

class PositionsTableViewController: UITableViewController {
    var positions: [Position]!

    var positionsController: FetchedRecordsController<Position>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        positionsController = try! FetchedRecordsController(dbQueue, request: positionsSortedByTimestamp)
        positionsController.trackChanges(
            willChange: { [unowned self] _ in
                self.tableView.beginUpdates()
            },
            onChange: { [unowned self] (controller, record, change) in
                switch change {
                case .insertion(let indexPath):
                    self.tableView.insertRows(at: [indexPath], with: .fade)
                    
                case .deletion(let indexPath):
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    
                case .update(let indexPath, _):
                    if let cell = self.tableView.cellForRow(at: indexPath) {
                        self.configure(cell, at: indexPath)
                    }
                    
                case .move(let indexPath, let newIndexPath, _):
                    let cell = self.tableView.cellForRow(at: indexPath)
                    self.tableView.moveRow(at: indexPath, to: newIndexPath)
                    if let cell = cell {
                        self.configure(cell, at: newIndexPath)
                    }
                }
            },
            didChange: { [unowned self] _ in
                self.tableView.endUpdates()
            })
        try! positionsController.performFetch()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
    }
    
    private func loadPositions() {
        positions = try! dbQueue.inDatabase { db in
            try Position.order(Column("timestamp").desc).fetchAll(db)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return positionsController.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return positionsController.sections[section].numberOfRecords
    }

    func configure(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let position = positionsController.record(at: indexPath)
        cell.textLabel?.text = position.description
        cell.detailTextLabel?.text = "\(position.latitude), \(position.longitude) (\(position.altitude) m)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PositionCell", for: indexPath)
        configure(cell, at: indexPath)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let position = positionsController.record(at: indexPath)
        try! dbQueue.inDatabase { db in
            _ = try position.delete(db)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}