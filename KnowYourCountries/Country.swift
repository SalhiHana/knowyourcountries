//
//  Country.swift
//  KnowYourCountries
//
//  Created by Hana Salhi on 2022-06-04.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let countries = try? newJSONDecoder().decode(Countries.self, from: jsonData)

struct Country: Codable {
    let name: String
    let topLevelDomain: [String]
    let alpha2Code, alpha3Code: String
    let callingCodes: [String]
    let capital: String?
    let altSpellings: [String]?
    let subregion: String
    let region: Region
    let population: Int
    let latlng: [Double]?
    let demonym: String
    let area: Double?
    let timezones: [String]
    let borders: [String]?
    let nativeName, numericCode: String
    let flags: Flags
    let currencies: [Currency]?
    let languages: [Language]
    let translations: Translations
    let flag: String
    let regionalBlocs: [RegionalBloc]?
    let cioc: String?
    let independent: Bool
    let gini: Double?
}

// MARK: - Currency
struct Currency: Codable {
    let code, name, symbol: String
}

// MARK: - Flags
struct Flags: Codable {
    let svg: String
    let png: String
}

// MARK: - Language
struct Language: Codable {
    let iso6391: String?
    let iso6392, name: String
    let nativeName: String?

    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name, nativeName
    }
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case antarcticOcean = "Antarctic Ocean"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
    case polar = "Polar"
}

// MARK: - RegionalBloc
struct RegionalBloc: Codable {
    let acronym: Acronym
    let name: Name
    let otherNames: [String]?
    let otherAcronyms: [OtherAcronym]?
}

enum Acronym: String, Codable {
    case al = "AL"
    case asean = "ASEAN"
    case au = "AU"
    case cais = "CAIS"
    case caricom = "CARICOM"
    case cefta = "CEFTA"
    case eeu = "EEU"
    case efta = "EFTA"
    case eu = "EU"
    case nafta = "NAFTA"
    case pa = "PA"
    case saarc = "SAARC"
    case usan = "USAN"
}

enum Name: String, Codable {
    case africanUnion = "African Union"
    case arabLeague = "Arab League"
    case associationOfSoutheastAsianNations = "Association of Southeast Asian Nations"
    case caribbeanCommunity = "Caribbean Community"
    case centralAmericanIntegrationSystem = "Central American Integration System"
    case centralEuropeanFreeTradeAgreement = "Central European Free Trade Agreement"
    case eurasianEconomicUnion = "Eurasian Economic Union"
    case europeanFreeTradeAssociation = "European Free Trade Association"
    case europeanUnion = "European Union"
    case northAmericanFreeTradeAgreement = "North American Free Trade Agreement"
    case pacificAlliance = "Pacific Alliance"
    case southAsianAssociationForRegionalCooperation = "South Asian Association for Regional Cooperation"
    case unionOfSouthAmericanNations = "Union of South American Nations"
}

enum OtherAcronym: String, Codable {
    case eaeu = "EAEU"
    case sica = "SICA"
    case unasul = "UNASUL"
    case unasur = "UNASUR"
    case uzan = "UZAN"
}

enum OtherName: String, Codable {
    case accordDeLibre??ChangeNordAm??Ricain = "Accord de Libre-????change Nord-Am????ricain"
    case alianzaDelPac??Fico = "Alianza del Pac??\u{ad}fico"
    case caribischeGemeenschap = "Caribische Gemeenschap"
    case communaut??Carib??Enne = "Communaut???? Carib????enne"
    case comunidadDelCaribe = "Comunidad del Caribe"
    case j??Mi??AtAdDuwalAl??Arab??Yah = "J??\u{81}mi????at ad-Duwal al-????Arab????yah"
    case leagueOfArabStates = "League of Arab States"
    case sistemaDeLaIntegraci??NCentroamericana = "Sistema de la Integraci????n Centroamericana,"
    case southAmericanUnion = "South American Union"
    case tratadoDeLibreComercioDeAm??RicaDelNorte = "Tratado de Libre Comercio de Am????rica del Norte"
    case umojaWaAfrika = "Umoja wa Afrika"
    case unieVanZuidAmerikaanseNaties = "Unie van Zuid-Amerikaanse Naties"
    case unionAfricaine = "Union africaine"
    case uni??NAfricana = "Uni????n Africana"
    case uni??NDeNacionesSuramericanas = "Uni????n de Naciones Suramericanas"
    case uni??OAfricana = "Uni????o Africana"
    case uni??ODeNa??????esSulAmericanas = "Uni????o de Na????????es Sul-Americanas"
    case ???????????????????????????????????? = "????????????????????? ?????????????????????? ?????????????????????????????"
    case ???????????????????????????????????? = "???????????????????\u{ad}???????? ???????????????\u{81}?????????????????"
}

// MARK: - Translations
struct Translations: Codable {
    let br, pt, nl, hr: String
    let fa: String?
    let de, es, fr, ja: String
    let it, hu: String
}

typealias Countries = [Country]
