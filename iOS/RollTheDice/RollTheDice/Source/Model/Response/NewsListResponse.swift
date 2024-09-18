// API Test

import Foundation

// MARK: - NewsElement
// data는 옵셔널처리. JSONNull 사용 X
//struct NewsResponse: Codable {
//    let newsResponse: [News]?
//}

struct NewsList: Codable {
    let status: Int?
    let message: String?
    let data: [NewsListDatum]?
}

struct NewsListDatum: Codable, Identifiable {
    let id = UUID().uuidString // 이건 앱자체에서
    let newsId: Int
    let title: String?
    let thumbnailUrl: String?
    let postDate: String?
    let isBookmarked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case newsId = "id"
        case title, thumbnailUrl, postDate, isBookmarked
    }
}
