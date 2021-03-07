import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/appbar/pokeDetailAppBar.dart';
import 'package:pokedex/controller/opacityControl.dart';
import 'package:pokedex/controller/pokeball_control.dart';
import 'package:pokedex/models/pokeApi.dart';
import 'package:pokedex/stores/pokeApiStore.dart';

class PokemonControl extends StatefulWidget {
  final int index;
  PokemonControl({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  _PokemonControlState createState() => _PokemonControlState();
}

class _PokemonControlState extends State<PokemonControl>
    with TickerProviderStateMixin {
  PageController _pageController;
  PokemonDetailAppBar _pokemonDetailAppBar;
  PokeApiStore _pokemonStore;
  Animation<double> _pokeAnimation;
  AnimationController _pokeController;
  RotationController _rotationController;
  OpacityControl _opacityControl;
  Pokemon _pokemon;
  @override
  void initState() {
    super.initState();
    _pokeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pokeController.forward();
    _pokeAnimation = CurvedAnimation(
      parent: _pokeController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    _pokemonDetailAppBar =
        PokemonDetailAppBar(_pokemon, _pokemonStore, widget.index);
    _pageController = PageController(initialPage: widget.index);
    _pokemonStore = GetIt.instance<PokeApiStore>();
    _rotationController = RotationController();
    _opacityControl = OpacityControl();

    return Container(
      child: Observer(
        builder: (context) {
          return Container(
            color: _pokemonStore.corPokemon,
            child: Container(
              color: _pokemonStore.corPokemon,
              height: MediaQuery.of(context).size.height / 3,
              child: Stack(
                children: <Widget>[
                  _opacityControl,
                  Padding(
                    padding: EdgeInsets.only(top: 165),
                    child: SizedBox(
                      height: 200,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          _pokemonStore.setPokemonAtual(index: index);
                          _pokemonDetailAppBar.setPokemon(
                            _pokemonStore.getPokemonAtual(),
                          );
                        },
                        itemCount: _pokemonStore.pokeApi.pokemon.length,
                        itemBuilder: (BuildContext context, int count) {
                          Pokemon _pokeItem =
                              _pokemonStore.getPokemon(index: count);
                          return Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Hero(
                                  tag: count.toString(),
                                  child: _rotationController),
                              Container(
                                child: Observer(
                                  builder: (context) {
                                    return Opacity(
                                      opacity: 1.0,
                                      child: Stack(
                                        children: <Widget>[
                                          _opacityControl,
                                          Center(
                                            child: ScaleTransition(
                                              scale: _pokeAnimation,
                                              child: AnimatedPadding(
                                                duration: Duration(
                                                    milliseconds: 1500),
                                                padding: EdgeInsets.all(count ==
                                                        _pokemonStore
                                                            .posicaoAtual
                                                    ? 0
                                                    : 60),
                                                child: CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      new Container(
                                                    color: Colors.transparent,
                                                  ),
                                                  height: 170,
                                                  width: 170,
                                                  color: count ==
                                                          _pokemonStore
                                                              .posicaoAtual
                                                      ? null
                                                      : Colors.black
                                                          .withOpacity(0.5),
                                                  imageUrl:
                                                      'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeItem.numero}.png',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
