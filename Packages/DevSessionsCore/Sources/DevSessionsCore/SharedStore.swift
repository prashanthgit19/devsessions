import Foundation

public enum AppGroup {
    /// Derived at build time from the signing team. The fallback keeps the
    /// core checks and older builds working.
    public static let identifier: String = {
        if let group = Bundle.main.object(
            forInfoDictionaryKey: "DevSessionsAppGroup"
        ) as? String, !group.isEmpty {
            return group
        }
        return "67Z29VG25Z.com.devsessions.shared2"
    }()
}

public struct SharedStore: Sendable {
    public let directoryURL: URL

    public var fileURL: URL {
        directoryURL.appendingPathComponent("state.json")
    }

    public init(directoryURL: URL) {
        self.directoryURL = directoryURL
    }

    public static func appGroup() -> SharedStore? {
        guard let container = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: AppGroup.identifier
        ) else {
            return nil
        }
        return SharedStore(
            directoryURL: container.appendingPathComponent("DevSessions", isDirectory: true)
        )
    }

    public func load() throws -> SharedState {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(SharedState.self, from: data)
    }

    public func save(_ state: SharedState) throws {
        try FileManager.default.createDirectory(
            at: directoryURL,
            withIntermediateDirectories: true
        )
        try FileManager.default.setAttributes(
            [.posixPermissions: 0o700],
            ofItemAtPath: directoryURL.path
        )

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(state)
        try data.write(to: fileURL, options: .atomic)
        try FileManager.default.setAttributes(
            [.posixPermissions: 0o600],
            ofItemAtPath: fileURL.path
        )
    }

    public var widgetThemeURL: URL {
        directoryURL.appendingPathComponent("widget-theme.json")
    }

    public func loadWidgetTheme() -> WidgetTheme {
        guard let data = try? Data(contentsOf: widgetThemeURL),
              let theme = try? JSONDecoder().decode(
                  WidgetTheme.self,
                  from: data
              ) else {
            return .midnight
        }
        return theme
    }

    public func saveWidgetTheme(_ theme: WidgetTheme) throws {
        try FileManager.default.createDirectory(
            at: directoryURL,
            withIntermediateDirectories: true
        )
        try FileManager.default.setAttributes(
            [.posixPermissions: 0o700],
            ofItemAtPath: directoryURL.path
        )

        let data = try JSONEncoder().encode(theme)
        try data.write(to: widgetThemeURL, options: .atomic)
        try FileManager.default.setAttributes(
            [.posixPermissions: 0o600],
            ofItemAtPath: widgetThemeURL.path
        )
    }
}
