import SwiftUI

struct TerminalArea: View {
    let project: Project
    let isActiveProject: Bool
    @Environment(AppState.self) private var appState

    var body: some View {
        if let root = appState.workspaceRoot(for: project.id) {
            PaneNode(
                node: root,
                focusedAreaID: appState.focusedAreaID[project.id],
                isActiveProject: isActiveProject,
                onFocusArea: { areaID in appState.focusArea(areaID, projectID: project.id) },
                onCloseTab: { areaID, tabID in appState.closeTabInArea(tabID, areaID: areaID, projectID: project.id) },
                onSplit: { areaID, dir in appState.splitArea(areaID, direction: dir, projectID: project.id, projectPath: project.path) },
                onCloseArea: { areaID in appState.closeArea(areaID, projectID: project.id) }
            )
        }
    }
}
