import Foundation
import Publish
import Plot

struct Davma: Website {
    enum SectionID: String, WebsiteSectionID {
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {}

    var url = URL(string: "https://dav.ma")!
    var name = "dm"
    var description = "Landing page"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

try Davma().publish(using: [
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .morningView),
    .generateSiteMap(),
    .deploy(using: .gitHub("D62/davma", branch: "gh-pages"))
])
