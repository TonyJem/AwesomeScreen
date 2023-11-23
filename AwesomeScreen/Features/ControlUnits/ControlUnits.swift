import Foundation

/// `ControlUnits` is an empty struct intended to delimit the namespace.
struct ControlUnits {
    private init() {
        // Intentionally unimplemented. This struct is needed to delimit the namespace only.
    }
}

extension ControlUnits {

    // TODO: Conform to protocol Iterable in order by naming
    // and put comment that orer is important
    enum SortingRule {

        case byId
        case byName
        case byStatus

    }

}
