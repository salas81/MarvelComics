//
//  StubbedComic.swift
//  MarvelComicsTests
//
//  Created by Lorenzo Decaria on 4/17/24.
//

import Foundation

struct StubbedComic {
    private static let jsonString = """
{
  "code": 200,
  "data": {
    "results": [
      {
        "title": "Official Handbook of the Marvel Universe (2004) #13 (TEAMS)",
        "textObjects": [
          {
            "type": "issue_solicit_text",
            "language": "en-us",
            "text": "Heavy-hitting heroes unite! This Official Handbook contains in-depth bios on more than 30 of the Marvel Universe's most awesome assemblages - including the Defenders, Power Pack and the New Thunderbolts! Plus: An all-new cover by superstar artist Tom Grummett, digitally painted by Morry Hollowell."
          }
        ],
        "thumbnail": {
          "path": "http://i.annihil.us/u/prod/marvel/i/mg/f/20/4bc63a47b8dcb",
          "extension": "jpg"
        }
      }
    ]
  }
}
"""
    static var data: Data {
        jsonString.data(using: .utf8)!
    }
}
