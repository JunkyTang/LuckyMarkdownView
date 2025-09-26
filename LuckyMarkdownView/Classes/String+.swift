//
//  String+.swift
//  LuckyMarkdownView
//
//  Created by mac on 2025/9/26.
//

import Foundation

extension String {
    
    static var styledHtmlUrl: URL? {
        let bundler = Bundle(for: MarkdownWebView.self)
        if let url = bundler.url(forResource: "styled", withExtension: "html") {
            return url
        }
        return bundler.url(forResource: "styled", withExtension: "html", subdirectory: "LuckyMarkdownView.bundle")
    }
    
    static var nonStyledHtmlUrl: URL? {
        let bundler = Bundle(for: MarkdownWebView.self)
        if let url = bundler.url(forResource: "non_styled", withExtension: "html") {
            return url
        }
        return bundler.url(forResource: "non_styled", withExtension: "html", subdirectory: "LuckyMarkdownView.bundle")
    }
    
}
