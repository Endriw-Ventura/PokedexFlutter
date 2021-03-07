import 'package:flutter/material.dart';
import 'package:pokedex/models/pokeApi.dart';
import 'package:pokedex/stores/pokeApiStore.dart';

// ignore: must_be_immutable
class PokemonDetailAppBar extends StatefulWidget {
  Pokemon _pokemon;
  PokeApiStore _pokemonStore;
  int index;
  _PokemonDetailAppBarState pokemonDetail = _PokemonDetailAppBarState();
  PokemonDetailAppBar(this._pokemon, this._pokemonStore, this.index);

  void setPokemon(Pokemon pokemon) {
    this._pokemon = pokemon;
    // ignore: invalid_use_of_protected_member
    pokemonDetail.setState(() {});
  }

  @override
  _PokemonDetailAppBarState createState() => pokemonDetail;
}

class _PokemonDetailAppBarState extends State<PokemonDetailAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Opacity(
          opacity: 0.5,
          child: Text(
            widget._pokemon.name,
            style: TextStyle(
                fontFamily: 'Google',
                fontWeight: FontWeight.bold,
                fontSize: 21),
          )),
      elevation: 0,
      backgroundColor: widget._pokemonStore.corPokemon,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: () {
            widget._pokemonStore.setPokemonAtual(index: widget.index);
          },
        ),
      ],
    );
  }
}
