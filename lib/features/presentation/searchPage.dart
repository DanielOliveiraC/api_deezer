import 'package:flutter/material.dart';
import 'package:api_deezer/features/controller/ApiService.dart';  // Importando o ApiService
import 'results_page.dart'; // Importando a página de resultados

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  ApiService apiService = ApiService();

  void _performSearch(String query) async {
  setState(() {
    _isLoading = true;
  });

  try {
    List<dynamic> tracks = await apiService.search(query);  // Chama o ApiService

    setState(() {
      _isLoading = false;
    });

    // Navega para a ResultsPage e passa os resultados como parâmetro
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(results: tracks),
      ),
    );
  } catch (error) {
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao carregar os resultados: $error')),
    );
    print('Erro ao realizar a pesquisa: $error');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesquisar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Álbum, música, artista...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  _performSearch(query); // Chama a função de pesquisa
                }
              },
            ),
            SizedBox(height: 20),
            // Exibe o indicador de carregamento
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(),
          ],
        ),
      ),
    );
  }
}
