import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel_app/domain/usecases/comic_usecase.dart';
import 'package:marvel_app/infrastructure/helpers/mappers/comic_maper.dart';
import 'package:marvel_app/infrastructure/repositories/comic_repository.dart';
import 'package:marvel_app/infrastructure/services/api/comics_api.dart';
import 'package:marvel_app/infrastructure/services/api/marvel_api.dart';

import 'domain/models/comic.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Comic>>? _comicsFuture;

  @override
  void initState() {
    final comicUseCase = ComicUsecase(
      ComicRepository(
        ComicsApiImp(
          MarvelApi(),
          ComicMapper(),
        ),
      ),
    );

    _comicsFuture = comicUseCase.getComics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comics'),
      ),
      body: FutureBuilder<List<Comic>>(
        future: _comicsFuture,
        builder: (context, comics) {
          switch (comics.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Text('Cargando ..'),
                  ],
                ),
              );

            case ConnectionState.done:
              return !comics.hasData
                  ? const Center(
                      child: Text('Sin fucking data!'),
                    )
                  : ListView.builder(
                      itemCount: comics.data!.length,
                      itemBuilder: (context, index) => Center(
                        child: Text(comics.data![index].title ?? 'Sin titulo'),
                      ),
                    );
            default:
              return const Center(
                child: Text('En el metodo default'),
              );
          }
          ;
        },
      ),
    );
  }
}
