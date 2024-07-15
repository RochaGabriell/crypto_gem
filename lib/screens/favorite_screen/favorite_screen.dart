import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:crypto_gem/domain/models/coins.dart';
import 'package:crypto_gem/domain/stores/coins.dart';
import 'package:crypto_gem/theme/app_pallete.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late CoinsStore _coinsStore;

  @override
  void initState() {
    super.initState();
    _coinsStore = Provider.of<CoinsStore>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_coinsStore.coins == null) _loadCoins();
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> _loadCoins({int? page}) async {
    await _coinsStore.getCoins(page: page);
  }

  @override
  Widget build(BuildContext context) {
    CoinModel? coin = _coinsStore.favoritesList.isNotEmpty
        ? _coinsStore.favoritesList.first
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Moedas')),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: AppPallete.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 312,
                height: 179,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: AppPallete.selectedColor,
                      offset: Offset(0, 4),
                      blurRadius: 6,
                    ),
                  ],
                  gradient: AppPallete.gradient,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'R\$ ${coin?.currentPrice.toStringAsFixed(2) ?? '0.00'}',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppPallete.backgroundColor,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.monetization_on_rounded,
                          color: AppPallete.backgroundColor,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Text(
                      coin?.name ?? 'Nome da Moeda',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppPallete.backgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        SizedBox(
                          width: 130,
                          child: Text(
                            'Variação 24h\nR\$ ${coin?.priceChange24H.toString() ?? '0.00'}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppPallete.backgroundColor,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Porc. Variação\nR\$ ${coin?.athChangePercentage.toStringAsFixed(2) ?? '0.00'}%',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppPallete.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 400,
                child: Consumer<CoinsStore>(
                  builder: (_, store, __) {
                    if (store.loading == true) {
                      return const Center(child: LinearProgressIndicator());
                    }

                    if (store.errorMessage.isNotEmpty) {
                      return Center(child: Text(store.errorMessage));
                    }

                    if (store.coins == null) {
                      return const Center(
                        child: Text('Nenhuma criptomoeda encontrada'),
                      );
                    }

                    final crypto = store.favoritesList;

                    return ListView.builder(
                      itemCount: crypto.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final coin = crypto[index];
                        return Container(
                          decoration: const BoxDecoration(
                            color: AppPallete.backgroundColor,
                          ),
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                color:
                                    AppPallete.selectedColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Image.network(coin.image),
                            ),
                            title: Text(
                              coin.symbol.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(coin.athChangePercentage.toString()),
                            trailing: _favoriteIcon(store, coin),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton _favoriteIcon(CoinsStore store, CoinModel crypto) {
    return IconButton(
      icon: Icon(
        store.favoritesList.contains(crypto) ? Icons.star : Icons.star_border,
        color: AppPallete.selectedColor,
      ),
      onPressed: () {
        if (store.favoritesList.contains(crypto)) {
          store.removeFavoritesList(crypto);
        } else {
          store.setFavoritesList(crypto);
        }
        setState(() {});
      },
    );
  }
}
