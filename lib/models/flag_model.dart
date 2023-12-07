import 'dart:convert';

// To parse this JSON data, do
//
//     final flags = flagsFromJson(jsonString);

List<Flags> flagsFromJson(String str) => List<Flags>.from(json.decode(str).map((x) => Flags.fromJson(x)));

String flagsToJson(List<Flags> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Flags {
  Name name;
  List<String> tld;
  String cca2;
  String ccn3;
  String cca3;
  String? cioc;
  bool independent;
  Status status;
  bool unMember;
  Map<String, Currency> currencies;
  Idd idd;
  List<String> capital;
  List<String> altSpellings;
  Region region;
  String subregion;
  Languages languages;
  Map<String, Translation> translations;
  List<double> latlng;
  bool landlocked;
  List<String>? borders;
  double area;
  Demonyms demonyms;
  String flag;
  Maps maps;
  int population;
  String? fifa;
  Car car;
  List<String> timezones;
  List<String> continents;
  FlagsClass flags;
  CoatOfArms coatOfArms;
  StartOfWeek startOfWeek;
  CapitalInfo capitalInfo;
  PostalCode? postalCode;

  Flags({
    required this.name,
    required this.tld,
    required this.cca2,
    required this.ccn3,
    required this.cca3,
    this.cioc,
    required this.independent,
    required this.status,
    required this.unMember,
    required this.currencies,
    required this.idd,
    required this.capital,
    required this.altSpellings,
    required this.region,
    required this.subregion,
    required this.languages,
    required this.translations,
    required this.latlng,
    required this.landlocked,
    this.borders,
    required this.area,
    required this.demonyms,
    required this.flag,
    required this.maps,
    required this.population,
    this.fifa,
    required this.car,
    required this.timezones,
    required this.continents,
    required this.flags,
    required this.coatOfArms,
    required this.startOfWeek,
    required this.capitalInfo,
    this.postalCode,
  });

  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
    name: Name.fromJson(json["name"]),
    tld: List<String>.from(json["tld"].map((x) => x)),
    cca2: json["cca2"],
    ccn3: json["ccn3"],
    cca3: json["cca3"],
    cioc: json["cioc"],
    independent: json["independent"],
    status: statusValues.map[json["status"]]!,
    unMember: json["unMember"],
    currencies: Map.from(json["currencies"]).map((k, v) => MapEntry<String, Currency>(k, Currency.fromJson(v))),
    idd: Idd.fromJson(json["idd"]),
    capital: List<String>.from(json["capital"].map((x) => x)),
    altSpellings: List<String>.from(json["altSpellings"].map((x) => x)),
    region: regionValues.map[json["region"]]!,
    subregion: json["subregion"],
    languages: Languages.fromJson(json["languages"]),
    translations: Map.from(json["translations"]).map((k, v) => MapEntry<String, Translation>(k, Translation.fromJson(v))),
    latlng: List<double>.from(json["latlng"].map((x) => x?.toDouble())),
    landlocked: json["landlocked"],
    borders: json["borders"] == null ? [] : List<String>.from(json["borders"]!.map((x) => x)),
    area: json["area"],
    demonyms: Demonyms.fromJson(json["demonyms"]),
    flag: json["flag"],
    maps: Maps.fromJson(json["maps"]),
    population: json["population"],
    fifa: json["fifa"],
    car: Car.fromJson(json["car"]),
    timezones: List<String>.from(json["timezones"].map((x) => x)),
    continents: List<String>.from(json["continents"].map((x) => x)),
    flags: FlagsClass.fromJson(json["flags"]),
    coatOfArms: CoatOfArms.fromJson(json["coatOfArms"]),
    startOfWeek: startOfWeekValues.map[json["startOfWeek"]]!,
    capitalInfo: CapitalInfo.fromJson(json["capitalInfo"]),
    postalCode: json["postalCode"] == null ? null : PostalCode.fromJson(json["postalCode"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name.toJson(),
    "tld": List<dynamic>.from(tld.map((x) => x)),
    "cca2": cca2,
    "ccn3": ccn3,
    "cca3": cca3,
    "cioc": cioc,
    "independent": independent,
    "status": statusValues.reverse[status],
    "unMember": unMember,
    "currencies": Map.from(currencies).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "idd": idd.toJson(),
    "capital": List<dynamic>.from(capital.map((x) => x)),
    "altSpellings": List<dynamic>.from(altSpellings.map((x) => x)),
    "region": regionValues.reverse[region],
    "subregion": subregion,
    "languages": languages.toJson(),
    "translations": Map.from(translations).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "latlng": List<dynamic>.from(latlng.map((x) => x)),
    "landlocked": landlocked,
    "borders": borders == null ? [] : List<dynamic>.from(borders!.map((x) => x)),
    "area": area,
    "demonyms": demonyms.toJson(),
    "flag": flag,
    "maps": maps.toJson(),
    "population": population,
    "fifa": fifa,
    "car": car.toJson(),
    "timezones": List<dynamic>.from(timezones.map((x) => x)),
    "continents": List<dynamic>.from(continents.map((x) => x)),
    "flags": flags.toJson(),
    "coatOfArms": coatOfArms.toJson(),
    "startOfWeek": startOfWeekValues.reverse[startOfWeek],
    "capitalInfo": capitalInfo.toJson(),
    "postalCode": postalCode?.toJson(),
  };
}

class CapitalInfo {
  List<double> latlng;

  CapitalInfo({
    required this.latlng,
  });

  factory CapitalInfo.fromJson(Map<String, dynamic> json) => CapitalInfo(
    latlng: List<double>.from(json["latlng"].map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "latlng": List<dynamic>.from(latlng.map((x) => x)),
  };
}

class Car {
  List<String> signs;
  Side side;

  Car({
    required this.signs,
    required this.side,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    signs: List<String>.from(json["signs"].map((x) => x)),
    side: sideValues.map[json["side"]]!,
  );

  Map<String, dynamic> toJson() => {
    "signs": List<dynamic>.from(signs.map((x) => x)),
    "side": sideValues.reverse[side],
  };
}

enum Side {
  RIGHT
}

final sideValues = EnumValues({
  "right": Side.RIGHT
});

class CoatOfArms {
  String? png;
  String? svg;

  CoatOfArms({
    this.png,
    this.svg,
  });

  factory CoatOfArms.fromJson(Map<String, dynamic> json) => CoatOfArms(
    png: json["png"],
    svg: json["svg"],
  );

  Map<String, dynamic> toJson() => {
    "png": png,
    "svg": svg,
  };
}

class Currency {
  String name;
  String symbol;

  Currency({
    required this.name,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    name: json["name"],
    symbol: json["symbol"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "symbol": symbol,
  };
}

class Demonyms {
  Eng eng;
  Eng? fra;

  Demonyms({
    required this.eng,
    this.fra,
  });

  factory Demonyms.fromJson(Map<String, dynamic> json) => Demonyms(
    eng: Eng.fromJson(json["eng"]),
    fra: json["fra"] == null ? null : Eng.fromJson(json["fra"]),
  );

  Map<String, dynamic> toJson() => {
    "eng": eng.toJson(),
    "fra": fra?.toJson(),
  };
}

class Eng {
  String f;
  String m;

  Eng({
    required this.f,
    required this.m,
  });

  factory Eng.fromJson(Map<String, dynamic> json) => Eng(
    f: json["f"],
    m: json["m"],
  );

  Map<String, dynamic> toJson() => {
    "f": f,
    "m": m,
  };
}

class FlagsClass {
  String png;
  String svg;
  String? alt;

  FlagsClass({
    required this.png,
    required this.svg,
    this.alt,
  });

  factory FlagsClass.fromJson(Map<String, dynamic> json) => FlagsClass(
    png: json["png"],
    svg: json["svg"],
    alt: json["alt"],
  );

  Map<String, dynamic> toJson() => {
    "png": png,
    "svg": svg,
    "alt": alt,
  };
}

class Idd {
  String root;
  List<String> suffixes;

  Idd({
    required this.root,
    required this.suffixes,
  });

  factory Idd.fromJson(Map<String, dynamic> json) => Idd(
    root: json["root"],
    suffixes: List<String>.from(json["suffixes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "root": root,
    "suffixes": List<dynamic>.from(suffixes.map((x) => x)),
  };
}

class Languages {
  Spa spa;
  String? bjz;
  String? eng;
  String? aym;
  String? que;
  String? cha;
  String? ber;
  String? mey;
  String? grn;
  String? fra;
  String? por;

  Languages({
    required this.spa,
    this.bjz,
    this.eng,
    this.aym,
    this.que,
    this.cha,
    this.ber,
    this.mey,
    this.grn,
    this.fra,
    this.por,
  });

  factory Languages.fromJson(Map<String, dynamic> json) => Languages(
    spa: spaValues.map[json["spa"]]!,
    bjz: json["bjz"],
    eng: json["eng"],
    aym: json["aym"],
    que: json["que"],
    cha: json["cha"],
    ber: json["ber"],
    mey: json["mey"],
    grn: json["grn"],
    fra: json["fra"],
    por: json["por"],
  );

  Map<String, dynamic> toJson() => {
    "spa": spaValues.reverse[spa],
    "bjz": bjz,
    "eng": eng,
    "aym": aym,
    "que": que,
    "cha": cha,
    "ber": ber,
    "mey": mey,
    "grn": grn,
    "fra": fra,
    "por": por,
  };
}

enum Spa {
  SPANISH
}

final spaValues = EnumValues({
  "Spanish": Spa.SPANISH
});

class Maps {
  String googleMaps;
  String openStreetMaps;

  Maps({
    required this.googleMaps,
    required this.openStreetMaps,
  });

  factory Maps.fromJson(Map<String, dynamic> json) => Maps(
    googleMaps: json["googleMaps"],
    openStreetMaps: json["openStreetMaps"],
  );

  Map<String, dynamic> toJson() => {
    "googleMaps": googleMaps,
    "openStreetMaps": openStreetMaps,
  };
}

class Name {
  String common;
  String official;
  Map<String, Translation> nativeName;

  Name({
    required this.common,
    required this.official,
    required this.nativeName,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    common: json["common"],
    official: json["official"],
    nativeName: Map.from(json["nativeName"]).map((k, v) => MapEntry<String, Translation>(k, Translation.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "common": common,
    "official": official,
    "nativeName": Map.from(nativeName).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Translation {
  String official;
  String common;

  Translation({
    required this.official,
    required this.common,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    official: json["official"],
    common: json["common"],
  );

  Map<String, dynamic> toJson() => {
    "official": official,
    "common": common,
  };
}

class PostalCode {
  String format;
  String regex;

  PostalCode({
    required this.format,
    required this.regex,
  });

  factory PostalCode.fromJson(Map<String, dynamic> json) => PostalCode(
    format: json["format"],
    regex: json["regex"],
  );

  Map<String, dynamic> toJson() => {
    "format": format,
    "regex": regex,
  };
}

enum Region {
  AFRICA,
  AMERICAS,
  EUROPE,
  OCEANIA
}

final regionValues = EnumValues({
  "Africa": Region.AFRICA,
  "Americas": Region.AMERICAS,
  "Europe": Region.EUROPE,
  "Oceania": Region.OCEANIA
});

enum StartOfWeek {
  MONDAY
}

final startOfWeekValues = EnumValues({
  "monday": StartOfWeek.MONDAY
});

enum Status {
  OFFICIALLY_ASSIGNED
}

final statusValues = EnumValues({
  "officially-assigned": Status.OFFICIALLY_ASSIGNED
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
