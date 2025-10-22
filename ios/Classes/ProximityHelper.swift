import UIKit

class ProximityHelper {
    static func enableProximityMonitoring(_ enabled: Bool) {
        do {
            UIDevice.current.isProximityMonitoringEnabled = enabled
        } catch {

        }
    }
}
