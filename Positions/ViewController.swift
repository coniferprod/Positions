import UIKit
import CoreLocation

import LCDView

class ViewController: UIViewController {

    @IBOutlet weak var latitudeDisplay: LCDView!
    @IBOutlet weak var longitudeDisplay: LCDView!
    @IBOutlet weak var altitudeDisplay: LCDView!
    
    var lastKnownLocation: CLLocation? = nil
    var positionCount = 1
    var savedPositions = [Position]()
    var positionViewModel: PositionViewModel?
    
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPosition" {
            let vc = segue.destination as! PositionViewController
            
            guard let savedLocation = lastKnownLocation else {
                return
            }
            
            let latitude = savedLocation.coordinate.latitude
            let longitude = savedLocation.coordinate.longitude
            let positionDescription = "Position 1"
            let position = Position(latitude: latitude, longitude: longitude, altitude: savedLocation.altitude, timestamp: savedLocation.timestamp, description: positionDescription)

            vc.position = position
            vc.positionCount = positionCount
            vc.delegate = self
        }
    }
    
    func updateDisplay(with location: CLLocation) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude

        let position = Position(latitude: latitude, longitude: longitude, altitude: location.altitude, timestamp: location.timestamp, description: "")

        positionViewModel = PositionViewModel(withPosition: position)
        if let viewModel = positionViewModel {
            (latitudeDisplay.caption, longitudeDisplay.caption) = viewModel.decimalStringPairFromCoordinates()
            altitudeDisplay.caption = viewModel.stringFromAltitude()
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!

        lastKnownLocation = location
        
        log.debug("didUpdateLocations: \(location)")
        
        updateDisplay(with: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        log.debug("didChangeAuthorization")
        
        guard CLLocationManager.locationServicesEnabled(),
            [.authorizedAlways, .authorizedWhenInUse].contains(CLLocationManager.authorizationStatus())
            else { return }
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        log.error(error)
    }
}

/*
 If you don't provide rationale for using the location, the location manager
 will not work, and you will get a console message:
 
 "This app has attempted to access privacy-sensitive data without a usage description. The app's Info.plist must contain an NSLocationWhenInUseUsageDescription key with a string value explaining to the user how the app uses this data"
*/

extension ViewController: PositionViewDelegate {
    func save(position: Position) {
        log.debug("Saving position \(position)")
        
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
        try! dbQueue.inDatabase { db in
            try position.insert(db)
        }
        
        savedPositions.append(position)
        positionCount += 1
    }
}
