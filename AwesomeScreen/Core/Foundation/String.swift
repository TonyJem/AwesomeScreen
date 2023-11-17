import Foundation

// TODO: Need to look at whole project later and decide if I should to add "public var", "public class" and etc.
// with intention to show that it is ready to be expandable (if into few modules it will be vissible everywhere)

extension String {

    /// Returns the localized `self`.
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }

}
