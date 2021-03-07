import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/consts/constsapi.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/controller/poke_control.dart';
import 'package:pokedex/models/pokeApi.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/stores/pokeDetail.dart';
part 'pokeApiStore.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  @observable
  PokeApi pokeApi;

  @observable
  PokemonControl pokemonControl;

  @observable
  PokeDetailPage pokeDetailPage;

  @observable
  dynamic corPokemon;

  @observable
  Pokemon _pokemonAtual;

  @observable
  int posicaoAtual;

  @computed
  PokeApi get pokeAPI => pokeApi;

  @computed
  Pokemon get pokemonAtual => _pokemonAtual;

  @action
  fetchPokemonList() {
    pokeApi = null;
    loadPokeApi().then((pokeList) {
      pokeApi = pokeList;
    });
  }

  Pokemon getPokemon({int index}) {
    return pokeApi.pokemon[index];
  }

  @action
  setPokemonAtual({int index}) {
    _pokemonAtual = pokeApi.pokemon[index];
    corPokemon = ConstsApi.getColorType(type: _pokemonAtual.type[0]);
    posicaoAtual = index;
  }

  @action
  getPokemonAtual() {
    return _pokemonAtual;
  }

  @action
  Widget getImage({String numero}) {
    return CachedNetworkImage(
      placeholder: (context, url) => new Container(
        color: Colors.transparent,
      ),
      imageUrl:
          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
    );
  }

  Future<PokeApi> loadPokeApi() async {
    try {
      final response = await http.get(ConstsApi.pokeApiURL);
      var decodeJson = jsonDecode(response.body);
      return PokeApi.fromJson(decodeJson);
    } catch (error) {
      print("Erro ao carregar lista");
      return null;
    }
  }
}
