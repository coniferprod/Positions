import UIKit
import CoreLocation

import LCDView

class ViewController: UIViewController {

    @IBOutlet weak var latitudeDisplay: LCDView!
    @IBOutlet weak var longitudeDisplay: LCDView!
    @IBOutlet weak var altitudeDisplay: LCDView!
    
    var lastKnownLocation: CLLocation? = nil
    var positionCount = 1
    
    lazy var locationManager: CLLocationManager = {
        $0.delegate = self
        return $0
    }(CLLocationManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latitudeDisplay.caption += "\u{00B0}"
        longitudeDisplay.caption += "\u{00B0}"
        
        locationManager.requestWhenInUseAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addPosition(_ sender: Any) {
        debugPrint("addPosition tapped")
        
        guard let savedLocation = lastKnownLocation else {
            return
        }
        
        let latitude = savedLocation.coordinate.latitude
        let longitude = savedLocation.coordinate.longitude
        let latitudeString = String(format: "%.5f", latitude)
        let longitudeString = String(format: "%.5f", longitude)
        
        let alert = UIAlertController(
            title: "Save Position",
            message: "Save \(latitudeString), \(longitudeString) ?",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive) { action in
            debugPrint("User cancelled save")
        })
        
        alert.addAction(UIAlertAction(title: "Save", style: .destructive) { action in
            guard let fields = alert.textFields, fields.count == 1 else {
                return
            }
            
            let textField = fields[0]
            var positionDescription = ""
            if let text = textField.text, text.count > 0 {
                positionDescription = text
            }
            else {
                positionDescription = textField.placeholder ?? "Position"
            }
            
            let timestamp = Int(savedLocation.timestamp.timeIntervalSince1970.rounded())
            
            let position = Position(latitude: latitude, longitude: longitude, altitude: savedLocation.altitude, timestamp: timestamp, description: positionDescription)
            debugPrint("Pretending to save position \(self.positionCount): \(position)")
            
            self.positionCount += 1
        })
        
        alert.addTextField { text in
            text.placeholder = "Position \(self.positionCount)"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPosition" {
            let vc = segue.destination as! PositionViewController
            
            guard let savedLocation = lastKnownLocation else {
                return
            }
            
            let timestamp = Int(savedLocation.timestamp.timeIntervalSince1970.rounded())
            
            let latitude = savedLocation.coordinate.latitude
            let longitude = savedLocation.coordinate.longitude
            let positionDescription = "Position 1"
            let position = Position(latitude: latitude, longitude: longitude, altitude: savedLocation.altitude, timestamp: timestamp, description: positionDescription)
            debugPrint("Pretending to save position \(self.positionCount): \(position)")

            vc.position = position
            vc.positionCount = positionCount
            vc.delegate = self
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!

        lastKnownLocation = location
        
        debugPrint("didUpdateLocations: \(location)")
        
        let latitudeString = String(format: "%.5f", location.coordinate.latitude)
        latitudeDisplay.caption = "\(latitudeString)\u{00B0}"
        
        let longitudeString = String(format: "%.5f", location.coordinate.longitude)
        longitudeDisplay.caption = "\(longitudeString)\u{00B0}"
        
        let altitudeString = String(format: "%.2f", location.altitude)
        altitudeDisplay.caption = "\(altitudeString) m"
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        debugPrint("didChangeAuthorization")
        
        guard CLLocationManager.locationServicesEnabled(),
            [.authorizedAlways, .authorizedWhenInUse].contains(CLLocationManager.authorizationStatus())
            else { return }
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error)
    }
}

/*
 If you don't provide rationale for using the location, the location manager
 will not work, and you will get a console message:
 
 "This app has attempted to access privacy-sensitive data without a usage description. The app's Info.plist must contain an NSLocationWhenInUseUsageDescription key with a string value explaining to the user how the app uses this data"
*/

extension ViewController: PositionViewDelegate {
    func save(position: Position) {
        debugPrint("Pretending to save position \(position)")
        
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
        positionCount += 1
    }
    
    func cancel() {
        debugPrint("User cancelled")
    }
}
