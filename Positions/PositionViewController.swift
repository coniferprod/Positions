import UIKit

import Eureka

protocol PositionViewDelegate {
    func save(position: Position)
    func cancel()
}

class PositionViewController: FormViewController {
    var position: Position?
    var positionCount = 1
    var delegate: PositionViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section("Position")
            <<< TextRow() { row in
                row.title = "Description"
                row.placeholder = "Position \(self.positionCount)"
                row.tag = "description"
            }
            <<< TextRow() { row in
                row.title = "Latitude"
                if let position = self.position {
                    row.value = String(position.latitude)
                }
                else {
                    row.placeholder = "Enter latitude"
                }
                row.tag = "latitude"
            }
            <<< TextRow() { row in
                row.title = "Longitude"
                if let position = self.position {
                    row.value = String(position.longitude)
                }
                else {
                    row.placeholder = "Enter longitude"
                }
                row.tag = "longitude"
            }
            <<< TextRow() { row in
                row.title = "Altitude"
                if let position = self.position {
                    row.value = String(position.altitude)
                }
                else {
                    row.placeholder = "Enter altitude"
                }
                row.tag = "altitude"
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func savePosition(_ sender: Any) {
        debugPrint("Save button tapped")
        
        let valuesDictionary = form.values()
        
        var description = ""
        if let _ = valuesDictionary["description"] {
            let row: TextRow? = form.rowBy(tag: "description")
            description = row?.placeholder ?? ""
            
        }

        // TODO: Check if the user has changed the coordinates
        let latitude = self.position?.latitude
        let longitude = self.position?.longitude
        let altitude = self.position?.altitude

        let position = Position(latitude: latitude!, longitude: longitude!, altitude: altitude!, timestamp: Int(Date().timeIntervalSince1970.rounded()), description: description)
        self.delegate?.save(position: position)
    }
    
}
