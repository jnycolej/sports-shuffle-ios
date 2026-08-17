//
//  Schedule.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/11/26.
//

import Foundation

nonisolated struct Schedule: Codable, Identifiable {
    var id: String {
        "\(date)-\(time)-\(teams.sorted().joined(separator: "-"))"
    }
    let teams: [String]
    let league: League
    let conferences: [Conference]
    let sport: Sport
    let date: String
    let time: String
    let networks: [Network]
    let tag: [ScheduleTag]
}


enum Sport: String, Codable {
    case basketball
    case football
    case baseball
    case hockey
}
enum League: String, Codable {
    case ncaa = "NCAA"
    case nba = "NBA"
    case nfl = "NFL"
    case nhl = "NHL"
    case mlb = "MLB"
}

enum Conference: String, Codable {
    case aac = "AAC"
    case acc = "ACC"
    case afcEast = "AFC-East"
    case afcNorth = "AFC-North"
    case afcSouth = "AFC-South"
    case afcWest = "AFC-West"
    case american = "American"
    case americanCentral = "American-Central"
    case americanEast = "American-East"
    case americanWest = "American-West"
    case big10 = "Big10"
    case big12 = "Big12"
    case bigSky = "Big Sky"
    case caa = "CAA"
    case cusa = "CUSA"
    case mac =  "MAC"
    case meac = "MEAC"
    case missouriValley = "Missouri Valley"
    case mountainWest = "Mountain West"
    case mwc = "MWC"
    case nationalCentral = "National-Central"
    case nationalEast = "National-East"
    case nationalWest = "National-West"
    case nfcEast = "NFC-East"
    case nfcNorth = "NFC-North"
    case nfcSouth = "NFC-South"
    case nfcWest = "NFC-West"
    case northeast = "Northeast"
    case ovcBigSouth = "OVC-Big South"
    case pac12 = "Pac12"
    case patriot = "Patriot"
    case pioneer = "Pioneer"
    case sec = "SEC"
    case socon = "SoCon"
    case southern = "Southern"
    case southland = "Southland"
    case sunBelt = "Sun Belt"
    case swac = "SWAC"
    case uac = "UAC"
    case unitedAthletic = "United Athletic"
}

enum Network: String, Codable {
    case espn = "ESPN"
    case nbc = "NBC"
    case cbs = "CBS"
    case cbssn = "CBSSN"
    case espnPlus = "ESPN+"
    case accn = "ACCN"
    case fox = "FOX"
    case btn = "BTN"
    case secNetwork = "SEC Network"
    case peacock = "Peacock"
    case espnu = "ESPNU"
    case secNetworkPlus = "SEC Network+"
    case fs1 = "FS1"
    case abc = "ABC"
    case tnt = "TNT"
    case hboMax = "HBO Max"
    case espnUnlimited = "ESPN Unlimited"
    case theCW = "The CW"
    case mwPlus = "MW+"
    case usaNet = "USA Network"
    case accExtra = "ACC Extra"
    case espn2 = "ESPN2"
    case truTV = "truTV"
    case paramountPlus = "Paramount+"
    case nflNetwork = "NFL Network"
    case netflix = "Netflix"
    case primeVideo = "Prime Video"
    case mlbTv = "MLBtv"
    case mlbNet = "MLB Net"
    case tbs = "TBS"
    case appleTv = "Apple TV"
    case na = "N/A"
}

enum ScheduleTag: String, Codable {
    case bowl
    case playoff
    case regular
    case championship
    case hallOfFame
    case preseason
}
