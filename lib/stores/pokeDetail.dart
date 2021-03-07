import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/appbar/pokeDetailAppBar.dart';
import 'package:pokedex/controller/poke_control.dart';
import 'package:pokedex/models/pokeApi.dart';
import 'package:pokedex/stores/pokeApiStore.dart';

// ignore: must_be_immutable
class PokeDetailPage extends StatefulWidget {
  int index;
  @override
  _PokeDetailPageState createState() => _PokeDetailPageState();
}

class _PokeDetailPageState extends State<PokeDetailPage>
    with TickerProviderStateMixin {
  PokemonDetailAppBar _pokemonDetailAppBar;
  Pokemon _pokemon;
  PokeApiStore _pokemonStore;

  // ignore: unused_field
  PokemonControl _pokemonControl;

  //pokemon animation

  @override
  void initState() {
    super.initState();

    _pokemonStore = GetIt.instance<PokeApiStore>();
    _pokemon = _pokemonStore.pokemonAtual;
    _pokemonControl = PokemonControl();

    _pokemonDetailAppBar =
        PokemonDetailAppBar(_pokemon, _pokemonStore, widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Observer(
          builder: (BuildContext context) {
            return _pokemonDetailAppBar;
          },
        ),
      ),
      body: _pokemonControl,
    );
  }
}
