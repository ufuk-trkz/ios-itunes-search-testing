//
//  mockJSON.swift
//  iTunes SearchTests
//
//  Created by Ufuk Türközü on 23.03.20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

let goodResultData = """
{
  "resultCount": 2,
  "results": [
        {
          "trackName": "GarageBand",
          "artistName": "Apple",
        },
        {
          "trackName": "Garage Virtual Drumset Band",
          "artistName": "Nexogen Private Limited",
        }
    ]
}
""".data(using: .utf8)!

let badResultData = """
{
  "resultCount": 2,
  "results": [
        {
          "trackName": "GarageBand",
          "artistName": "Apple",
        },
        
          "trackName": "Garage Virtual Drumset Band",
          "artistName": "Nexogen Private Limited",
        }
    ]
}
""".data(using: .utf8)!

let noResultData = """
{
  "resultCount": 0,
  "results": []
}
""".data(using: .utf8)!
