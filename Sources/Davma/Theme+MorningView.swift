import Foundation
import Publish
import Plot

public extension Theme {
    static var morningView: Self {
        Theme(
            htmlFactory: MorningViewHTMLFactory(),
            resourcePaths: ["Resources/theme/styles.css"]
        )
    }
}

private struct MorningViewHTMLFactory<Site: Website>: HTMLFactory {
    private func makeHead(title: String) -> Node<HTML.DocumentContext> {
        .head(
            .title(title),
            .meta(.charset(.utf8)),
            .meta(.name("viewport"), .content("width=device-width, initial-scale=1")),
            .link(.rel(.stylesheet), .href("/theme/styles.css"))
        )
    }

    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            makeHead(title: context.site.name),
            .body {
                Wrapper {
                    H1(index.title)
                    Div(index.body).class("page-description faded")
                }
            }
        )
    }

    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            makeHead(title: page.title),
            .body {
                Wrapper {
                    H1(page.title)
                    Div(page.body).class("page-description faded")
                }
            }
        )
    }

    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        try makeIndexHTML(for: context.index, context: context)
    }

    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        try makeIndexHTML(for: context.index, context: context)
    }

    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        nil
    }

    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
        nil
    }
}

private struct Wrapper: ComponentContainer {
    @ComponentBuilder var content: ContentProvider

    var body: Component {
        Div(content: content).class("wrapper")
    }
}
