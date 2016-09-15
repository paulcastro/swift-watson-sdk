import PackageDescription

let package = Package(
    name: "WatsonDeveloperCloud",
    targets: [
        Target(name: "RestKit"),
        Target(name: "InsightsForWeather", dependencies: [.Target(name: "RestKit")]),
        Target(name: "NaturalLanguageClassifier", dependencies: [.Target(name: "RestKit")]),
        Target(name: "ToneAnalyzer", dependencies: [.Target(name: "RestKit")]),
        Target(name: "PersonalityInsights", dependencies: [.Target(name: "RestKit")]),
        Target(name: "Conversation", dependencies: [.Target(name: "RestKit")]),
        Target(name: "AlchemyVision", dependencies: [.Target(name: "RestKit")])
    ],
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura-net.git", majorVersion: 0, minor: 19),
        .Package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", majorVersion: 9)
    ]
)


