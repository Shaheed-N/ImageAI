//
//  Image.swift
//  ImageAI
//
//  Created by Shahid on 02.12.22.
//

import Foundation

struct ImageGenerationResponse: Codable {
    struct ImageResponse: Codable {
        let url: URL
    }

    let created: Int
    let data: [ImageResponse]
}
