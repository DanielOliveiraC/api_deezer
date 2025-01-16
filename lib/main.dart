import 'package:api_deezer/features/presentation/searchPage.dart';
import 'package:api_deezer/features/presentation/splashPage.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

void main() async {
  runApp(MainApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/splash',  // Página inicial do aplicativo
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainAppPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/search',  // Caminho para a página de pesquisa
          builder: (BuildContext context, GoRouterState state) {
            return SearchPage();
          },
        ),
        GoRoute(path: '/splash',
          builder: (BuildContext context, GoRouterState state) {
            return SplashPage();
          },
        )
      ],
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(  // Usando MaterialApp.router para integrar com o GoRouter
      routerConfig: _router,  // Configurando o GoRouter
      debugShowCheckedModeBanner: false,  // Remover banner de debug
      title: 'App de Música',
    );
  }
}

class MainAppPage extends StatelessWidget {
  const MainAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página Principal"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Melhor App de Música do planeta Earth", style: TextStyle(fontSize: 18)),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => context.go('/search'), // Navegar para a página de pesquisa
              
              child: const Text("Ir para pesquisa"),
              
            ),
          ],
        ),
      ),
    );
  }
}

