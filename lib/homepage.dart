import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/consts/consts.dart';
import 'package:pokedex/controller/poke_control.dart';
import 'package:pokedex/stores/pokeApiStore.dart';
import 'package:pokedex/stores/pokeItem.dart';
import 'appbar/appBar.dart';
import 'models/pokeApi.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  int index;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore _pokemonStore;

  @override
  void initState() {
    super.initState();
    _pokemonStore = GetIt.instance<PokeApiStore>();
    if (_pokemonStore.pokeApi == null) {
      _pokemonStore.fetchPokemonList();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: -(270 / 3),
            left: screenWidth - (240 / 1.2),
            child: Opacity(
              opacity: 0.25,
              child: Image.asset(ConstsApp.redPokeball),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: (statusWidth),
                ),
                AppBarHome(),
                Container(
                  color: Colors.transparent,
                  child: Observer(
                    name: 'ListaHomePage',
                    builder: (BuildContext context) {
                      PokeApi _pokeApi = _pokemonStore.pokeApi;
                      return (_pokeApi != null)
                          ? AnimationLimiter(
                              child: SizedBox(
                                height: 399,
                                child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.all(5),
                                  addAutomaticKeepAlives: true,
                                  gridDelegate:
                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount:
                                      _pokemonStore.pokeApi.pokemon.length,
                                  itemBuilder: (context, index) {
                                    Pokemon pokemon =
                                        _pokemonStore.getPokemon(index: index);
                                    var animationConfiguration =
                                        AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      columnCount: 2,
                                      child: ScaleAnimation(
                                        child: GestureDetector(
                                          child: PokeItem(
                                            types: pokemon.type,
                                            index: index,
                                            name: pokemon.name,
                                            numero: pokemon.numero,
                                          ),
                                          onTap: () {
                                            _pokemonStore.setPokemonAtual(
                                                index: index);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        PokemonControl(
                                                  index: index,
                                                ),
                                                fullscreenDialog: true,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                    return animationConfiguration;
                                  },
                                ),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
