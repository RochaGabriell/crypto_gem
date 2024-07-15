class CoinModel {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;
  int marketCap;
  int marketCapRank;
  int fullyDilutedValuation;
  int totalVolume;
  double high24H;
  double low24H;
  double priceChange24H;
  double priceChangePercentage24H;
  double marketCapChange24H;
  double marketCapChangePercentage24H;
  double circulatingSupply;
  double totalSupply;
  double? maxSupply;
  double ath;
  double athChangePercentage;
  DateTime athDate;
  double atl;
  double atlChangePercentage;
  DateTime atlDate;
  Roi? roi;
  DateTime lastUpdated;

  CoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.marketCapChange24H,
    required this.marketCapChangePercentage24H,
    required this.circulatingSupply,
    required this.totalSupply,
    this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.roi,
    required this.lastUpdated,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: json['current_price']?.toDouble() ?? 0,
      marketCap: json['market_cap'] ?? 0,
      marketCapRank: json['market_cap_rank'] ?? 0,
      fullyDilutedValuation: json['fully_diluted_valuation'] ?? 0,
      totalVolume: json['total_volume'] ?? 0,
      high24H: json['high_24h']?.toDouble() ?? 0,
      low24H: json['low_24h']?.toDouble() ?? 0,
      priceChange24H: json['price_change_24h']?.toDouble() ?? 0,
      priceChangePercentage24H:
          json['price_change_percentage_24h']?.toDouble() ?? 0,
      marketCapChange24H: json['market_cap_change_24h']?.toDouble() ?? 0,
      marketCapChangePercentage24H:
          json['market_cap_change_percentage_24h']?.toDouble() ?? 0,
      circulatingSupply: json['circulating_supply']?.toDouble() ?? 0,
      totalSupply: json['total_supply']?.toDouble() ?? 0,
      maxSupply: json['max_supply']?.toDouble() ?? 0,
      ath: json['ath']?.toDouble() ?? 0,
      athChangePercentage: json['ath_change_percentage']?.toDouble() ?? 0,
      athDate: DateTime.parse(json['ath_date']),
      atl: json['atl']?.toDouble() ?? 0,
      atlChangePercentage: json['atl_change_percentage']?.toDouble() ?? 0,
      atlDate: DateTime.parse(json['atl_date']),
      roi: json['roi'] == null ? null : Roi.fromJson(json['roi']),
      lastUpdated: DateTime.parse(json['last_updated']),
    );
  }
}

class Roi {
  double? times;
  String? currency;
  double? percentage;

  Roi({
    required this.times,
    required this.currency,
    required this.percentage,
  });

  factory Roi.fromJson(Map<String, dynamic> json) {
    return Roi(
      times: json['times']?.toDouble() ?? 0,
      currency: json['currency'] ?? '',
      percentage: json['percentage']?.toDouble() ?? 0,
    );
  }
}
