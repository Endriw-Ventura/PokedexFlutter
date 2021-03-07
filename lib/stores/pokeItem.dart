import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/consts/consts.dart';
import 'package:pokedex/consts/constsapi.dart';

class PokeItem extends StatelessWidget {
  final String name;
  final int index;
  final Color color;
  final String numero;
  final List<String> types;

  Widget setTypes() {
    List<Widget> lista = [];
    types.forEach(
      (nome) {
        lista.add(
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    nome.trim(),
                    style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        );
      },
    );
    return Column(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.end,
    );
  }

  const PokeItem(
      {Key key, this.name, this.index, this.color, this.numero, this.types});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, top: 8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Hero(
                tag: index.toString(),
                child: Opacity(
                  child: Image.asset(
                    ConstsApp.whitePokeball,
                    height: 90,
                    width: 90,
                  ),
                  opacity: 0.3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 13, bottom: 13),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CachedNetworkImage(
                    height: 65,
                    width: 65,
                    placeholder: (context, url) => new Container(
                      color: Colors.transparent,
                    ),
                    imageUrl:
                        'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Google',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 35),
                  child: setTypes(),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: ConstsApi.getColorType(
            type: types[0],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
    );
  }
}
