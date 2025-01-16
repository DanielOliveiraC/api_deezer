import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ResultsPage extends StatelessWidget {
  final List<dynamic> results;  // Lista de resultados recebida

  ResultsPage({required this.results});  // Recebe os resultados como parâmetro

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultados da Pesquisa"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            var track = results[index];
            return ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
              title: Text(track['title']),  // Título da música
              subtitle: Text('Artista: ${track['artist']['name']}'),  // Nome do artista
              trailing: Image.network(
                track['album']['cover_medium'],  // Capa do álbum
                width: 50,
                height: 50,
              ),
              onTap: () {
                int id = track['id'];
                final url = 'https://deezer.com/track/$id';
                _launchURL(url);
                print('$id');
              },
            );
          },
        ),
      ),
    );
  }
}

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Não foi possível abrir o link: $url');
  }
}