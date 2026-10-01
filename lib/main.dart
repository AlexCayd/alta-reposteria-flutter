import 'package:flutter/material.dart';

void main() {
  runApp(const PostresAltaCocinaApp());
}

class PostresAltaCocinaApp extends StatelessWidget {
  const PostresAltaCocinaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alta Cocina',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.black38,
      ),
      home: const CatalogoScreen(),
    );
  }
}

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  int _indiceActual = 0;

  // Catalogo
  final List<Map<String, String>> _secciones = [
    {
      'titulo': 'Esfera de Chocolate',
      'descripcion': 'Cobertura de chocolate oscuro rellena de mousse de avellana',
      'imagen': 'https://images.unsplash.com/photo-1605807646983-377bc5a76493?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
    },
    {
      'titulo': 'Tarta Ópera',
      'descripcion': 'Un clásico francés con capas de bizcocho de almendra y ganache de chocolate.',
      'imagen': 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
    },
    {
      'titulo': 'Macarons de Frambuesa',
      'descripcion': 'Galletas de almendra ligeras y crujientes con ganache de chocolate blanco y frambuesa fresca.',
      'imagen': 'https://images.unsplash.com/photo-1569864358642-9d1684040f43?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
    },
  ];

  void _cambiarSeccion(int index) {
    setState(() {
      _indiceActual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemActual = _secciones[_indiceActual];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alta repostería'),
        centerTitle: true,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(5),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.brown),
              child: Text(
                'Opciones de postres',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            _crearItemDrawer(0, 'Esfera de chocolate', Icons.cookie),
            _crearItemDrawer(1, 'Tarta ópera', Icons.cake),
            _crearItemDrawer(2, 'Macarons', Icons.bakery_dining),
          ],
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: OrientationBuilder(
            builder: ((context, orientation) {
              if(orientation == Orientation.portrait) {
                return _layoutVertical(itemActual);
              } else {
                return _layoutHorizontal(itemActual);
              }
            }),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceActual,
        onTap: _cambiarSeccion,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white30,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.cookie),
            label: 'Esfera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            label: 'Ópera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bakery_dining),
            label: 'Macarons',
          ),
        ],
      ),
    );
  }

  Widget _crearItemDrawer(int index, String titulo, IconData icono) {
    return ListTile(
      leading: Icon(icono),
      title: Text(titulo),
      selected: _indiceActual == index,
      onTap: () {
        _cambiarSeccion(index);
        Navigator.pop(context); // Cierra el drawer tras seleccionar
      },
    );
  }

  Widget _layoutVertical(Map<String, String> item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: _imagenBorderRadius(item['imagen']!),
        ),
        const SizedBox(height: 20),
        Expanded(
          flex: 1,
          child: _textoDescriptivo(item['titulo']!, item['descripcion']!),
        ),
      ],
    );
  }

  Widget _layoutHorizontal(Map<String, String> item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: _imagenBorderRadius(item['imagen']!),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 1,
          child: Center(
            child: _textoDescriptivo(item['titulo']!, item['descripcion']!),
          ),
        ),
      ],
    );
  }

  Widget _imagenBorderRadius(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Center(child: Icon(Icons.broken_image, size: 50)),
      ),
    );
  }

  Widget _textoDescriptivo(String titulo, String descripcion) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          descripcion,
          style: const TextStyle(
            fontSize: 16,
            height: 1.4,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
