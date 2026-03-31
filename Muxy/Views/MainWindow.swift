import SwiftUI

struct MainWindow: View {
    @Environment(AppState.self) private var appState
    @Environment(ProjectStore.self) private var projectStore

    var body: some View {
        VStack(spacing: 0) {
            TabStrip(project: activeProject, onAddProject: addProject)
            Rectangle().fill(MuxyTheme.border).frame(height: 1)

            HStack(spacing: 0) {
                Sidebar()
                Rectangle().fill(MuxyTheme.border).frame(width: 1)

                ZStack {
                    MuxyTheme.bg
                    ForEach(projectStore.projects) { project in
                        let isActive = project.id == appState.activeProjectID
                        TerminalArea(project: project)
                            .opacity(isActive ? 1 : 0)
                            .allowsHitTesting(isActive)
                    }
                    if activeProject == nil {
                        WelcomeView()
                    }
                }
            }
        }
        .background(MuxyTheme.bg)
        .edgesIgnoringSafeArea(.top)
    }

    private var activeProject: Project? {
        guard let pid = appState.activeProjectID else { return nil }
        return projectStore.projects.first { $0.id == pid }
    }

    private func addProject() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false
        panel.message = "Select a project folder"
        guard panel.runModal() == .OK, let url = panel.url else { return }
        let project = Project(
            name: url.lastPathComponent,
            path: url.path(percentEncoded: false),
            sortOrder: projectStore.projects.count
        )
        projectStore.add(project)
        appState.activeProjectID = project.id
    }
}
