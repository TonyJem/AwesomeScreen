import Foundation

/// `ControlUnits` is an empty struct intended to delimit the namespace.
struct ControlUnits {
    private init() {
        // Intentionally unimplemented. This struct is needed to delimit the namespace only.
    }
}

extension ControlUnits {

    struct ControlUnitDomainModel {

        enum Status {
            case ok
            case faulty
            case notReachable
            case other
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
