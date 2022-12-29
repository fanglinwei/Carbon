import SwiftUI
import UIKit

@available(iOS 13.0, *)
final class HostingController<Content: View>: UIHostingController<Content> {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
}
