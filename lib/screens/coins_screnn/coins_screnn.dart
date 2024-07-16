import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:crypto_gem/domain/models/coins.dart';
import 'package:crypto_gem/domain/stores/coins.dart';
import 'package:crypto_gem/theme/app_pallete.dart';

import 'package:crypto_gem/widgets/label_formated.dart';
import 'package:crypto_gem/widgets/coin_card.dart';

class CoinsScrenn extends StatefulWidget {
  const CoinsScrenn({super.key});

  @override
  State<CoinsScrenn> createState() => _CoinsScrennState();
}

class _CoinsScrennState extends State<CoinsScrenn> {
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

  void _selectCoin(CoinModel coin) {
    _coinsStore.setCoinSelected(coin);
  }

  void _changePage(int page) {
    if (page < 1) return;
    _coinsStore.setCurrentPage(page);
    _loadCoins(page: page);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criptomoedas'),
        surfaceTintColor: AppPallete.backgroundColor,
        scrolledUnderElevation: 0.0,
        actions: [_paginator()],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<CoinsStore>(
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

              final crypto = store.coinSelected;

              return SizedBox(
                height: 60,
                child: ListView.builder(
                  itemCount: store.coins?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final coin = store.coins?[index];
                    return Container(
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: crypto?.id == coin?.id
                                ? AppPallete.selectedColor
                                : AppPallete.backgroundColor,
                            width: 2,
                          ),
                        ),
                        color: AppPallete.backgroundColor,
                      ),
                      child: ListTile(
                        title: Text('${coin?.symbol.toUpperCase()}/BRL'),
                        selected: crypto?.id == coin?.id,
                        onTap: () => setState(() => _selectCoin(coin!)),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Consumer<CoinsStore>(
                  builder: (_, store, __) {
                    final crypto = store.coinSelected;

                    if (crypto == null) {
                      return const Center(
                        child: Text('Selecione uma criptomoeda'),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 66,
                                height: 66,
                                decoration: BoxDecoration(
                                  color:
                                      AppPallete.selectedColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Image.network(crypto.image),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    crypto.symbol.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      crypto.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: AppPallete.disabledColor,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'R\$ ${crypto.currentPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '1,00 ${crypto.symbol.toUpperCase()}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppPallete.disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              _favoriteIcon(store, crypto),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CoinCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LabelFormated(
                                  title: 'Ranking: ',
                                  value: '#${crypto.marketCapRank.toString()}',
                                  isRow: true,
                                ),
                                const SizedBox(height: 10),
                                LabelFormated(
                                  title: 'Valor de Mercado: ',
                                  value: crypto.marketCap.toString(),
                                  isRow: true,
                                ),
                                const SizedBox(height: 10),
                                LabelFormated(
                                  title: 'Moedas Circulantes: ',
                                  value:
                                      'R\$ ${crypto.circulatingSupply.toStringAsFixed(2)}',
                                ),
                                const SizedBox(height: 10),
                                LabelFormated(
                                  title: 'Fornecimento Máx: ',
                                  value: 'R\$ ${crypto.maxSupply}',
                                ),
                                const SizedBox(height: 10),
                                LabelFormated(
                                  title: 'Total de Moedas: ',
                                  value:
                                      'R\$ ${crypto.totalSupply.toStringAsFixed(2)}',
                                  isRow: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          CoinCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LabelFormated(
                                  title: 'Intervalo 24h: ',
                                  value:
                                      'R\$ ${crypto.high24H.toStringAsFixed(2)} - R\$ ${crypto.low24H.toStringAsFixed(2)}',
                                ),
                                const SizedBox(height: 10),
                                LabelFormated(
                                  title: 'Variação nas últimas 24h: ',
                                  value:
                                      '${crypto.priceChange24H.toStringAsFixed(2)} - ${crypto.priceChangePercentage24H.toStringAsFixed(2)}%',
                                ),
                                const SizedBox(height: 10),
                                LabelFormated(
                                  title: 'Porcentagem de Variação: ',
                                  value:
                                      '${crypto.athChangePercentage.toStringAsFixed(2)}%',
                                  isRow: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
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

  Container _paginator() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppPallete.disabledColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => _changePage(_coinsStore.currentPage - 1),
          ),
          Text('Página ${_coinsStore.currentPage}'),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () => _changePage(_coinsStore.currentPage + 1),
          ),
        ],
      ),
    );
  }
}
