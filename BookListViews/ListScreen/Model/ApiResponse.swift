//
//  ApiResponse.swift
//  BookListViews
//
//  Created by Colin Murphy on 9/22/20.
//

import Foundation

struct ApiResponse: Decodable {
    var bookKind: String?
    var totalItems: Int?
    var items: [ItemInfo]?
    
    enum CodingKeys: String, CodingKey {
        case bookKind = "kind"
        case totalItems
        case items
    }
}

struct ItemInfo: Decodable {
    var itemKind: String?
    var itemId: String?
    var eTag: String?
    var selfLink: String?
    var volumeInfo: VolumeInfo?
    var saleInfo: SalesInfo?
    var accessInfo: AccessInfo?
    var searchInfo: SearchInfo?
    
    enum CodingKeys: String, CodingKey {
        case itemKind = "kind"
        case itemId = "id"
        case eTag = "etag"
        case selfLink
        case volumeInfo
        case saleInfo
        case accessInfo
        case searchInfo
    }
}

struct SearchInfo: Decodable {
    var textSnippet: String?
}

struct SalesInfo: Decodable {
    var country: String?
    var saleability: String?
    var isEbook: Bool?
    var listPrice: Price?
    var retailPrice: Price?
    var buyLink: String?
    var offers: [Offer]?
}

struct Offer: Decodable {
    var finskyOfferType: Int?
    var listPrice: Price?
    var retailPrice: Price?
    var giftable: Bool?
}

struct Price: Decodable {
    var amount: Double?
    var currencyCode: String?
}

struct VolumeInfo: Decodable {
    var title: String?
    var subTitle: String?
    var authors: [String]?
    var publisher: String?
    var publisherDate: String?
    var description: String?
    var industryIdentifiers: [IndustryIdentifier]?
    var readingModes: ReadingMode?
    var pageCount: Int?
    var printType: String?
    var categories: [String]?
    var averageRating: Double?
    var ratingsCount: Int?
    var maturityRating: String?
    var allowAnonLogging: Bool?
    var contentVersion: String?
    var panelizationSummary: PanelizationSummary?
    var imageLinks: ImageLinks?
    var language: String?
    var previewLink: String?
    var infoLink: String?
    var canonicalVolumeLink: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case subTitle = "subtitle"
        case authors
        case publisher
        case publisherDate
        case description
        case industryIdentifiers
        case readingModes
        case pageCount
        case printType
        case categories
        case averageRating
        case ratingsCount
        case maturityRating
        case allowAnonLogging
        case contentVersion
        case panelizationSummary
        case imageLinks
        case language
        case previewLink
        case infoLink
        case canonicalVolumeLink
    }
    
    func getNonNilItems() -> [(String, Any)] {
        
        var items: [(String, Any)] = []
        
        if let title = title {
            items.append(("Title:", title))
        }
        if let subTitle = subTitle {
            items.append(("Subtitle:", subTitle))
        }
        if let authors = authors {
            if authors.count > 0 {
                items.append(("Authors:", authors))
            }
        }
        if let publisher = publisher {
            items.append(("Publisher:", publisher))
        }
        if let publisherDate = publisherDate {
            items.append(("Publisher Date:", publisherDate))
        }
        if let description = description {
            items.append(("Desciption:", description))
        }
        if let pageCount = pageCount {
            items.append(("Page Count:", pageCount))
        }
        
        return items
    }
}

struct IndustryIdentifier: Decodable {
    var type: String?
    var identifier: String?
}

struct ReadingMode: Decodable {
    var text: Bool?
    var image: Bool?
}

struct PanelizationSummary: Decodable {
    var containsEpubBubbles: Bool?
    var containsImageBubbles: Bool?
}

struct ImageLinks: Decodable {
    var smallThumbnail: String?
    var thumbNail: String?
    
    enum CodingKeys: String, CodingKey {
        case smallThumbnail
        case thumbNail = "thumbnail"
    }
}

struct AccessInfo: Decodable {
    var country: String?
    var viewability: String?
    var embeddable: Bool?
    var publicDomain: Bool?
    var textToSpeechPermission: String?
    var epub: Epub?
    var pdfInfo: PdfInfo?
    var webReaderLink: String?
    var accessViewStatus: String?
    var quoteSharingAllowed: Bool?
    
    enum CodingKeys: String, CodingKey {
        case country
        case viewability
        case embeddable
        case publicDomain
        case textToSpeechPermission
        case epub
        case pdfInfo = "pdf"
        case webReaderLink
        case accessViewStatus
        case quoteSharingAllowed
    }
}

struct Epub: Decodable {
    var isAvailable: Bool?
}

struct PdfInfo: Decodable {
    var acsTokenLink: Bool?
    enum CodingKeys: String, CodingKey {
        case acsTokenLink = "isAvailable"
    }
}
