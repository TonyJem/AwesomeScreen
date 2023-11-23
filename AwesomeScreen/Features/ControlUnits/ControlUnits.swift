import Foundation

/// `ControlUnits` is an empty struct intended to delimit the namespace.
struct ControlUnits {
    private init() {
        // Intentionally unimplemented. This struct is needed to delimit the namespace only.
    }
}

extension ControlUnits {

    struct ControlUnitDomainModel {

        // Order of declaration defines the comparison result (.notReachable < .ok < .faulty)
        enum Status {

            case notReachable
            case ok
            case faulty

        }

        let id: String
        let name: String
        let status: Status
        let imageUrlString: String

    }

}

extension ControlUnits {

    // Order of declaration defines the comparison result (.byStatus < .byName < .byId)
    enum SortingRule: Comparable {

        case byStatus
        case byName
        case byId

    }

}
