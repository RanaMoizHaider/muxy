import Foundation

@MainActor
@Observable
final class TerminalTab: Identifiable {
    let id = UUID()
    var title: String
    let pane: TerminalPaneState

    init(title: String = "Terminal", pane: TerminalPaneState) {
        self.title = title
        self.pane = pane
    }
}
