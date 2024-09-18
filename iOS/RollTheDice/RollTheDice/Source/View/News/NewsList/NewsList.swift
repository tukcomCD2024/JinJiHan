// API Test

import Foundation

struct NewsList: Codable {
    
    let status: Int?
    let message: String?
    let data: [NewsData]?
}

struct NewsData: Codable, Identifiable {
    let id = UUID().uuidString // 이건 앱자체에서
    let newsId: Int
    let title, content: String?
    let thumbnailUrl: String?
    let postDate: String?
    let isBookmarked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case newsId = "id"
        case title, content, thumbnailUrl, postDate, isBookmarked
    }
}
