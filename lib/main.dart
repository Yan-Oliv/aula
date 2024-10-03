import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Produtos',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    ProdutosScreen(),
    CarrinhoScreen(),
    PerfilScreen(),
    AjudaScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Produtos'),
      ),
      body: _children[_currentIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Produtos'),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text('Carrinho'),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ajuda'),
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Tela de Produtos
class Produto {
  final int id;
  final String nome;
  final String valor;
  final int quantidade;

  Produto(
      {required this.id,
      required this.nome,
      required this.valor,
      required this.quantidade});
}

class ProdutosScreen extends StatefulWidget {
  @override
  _ProdutosScreenState createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<Produto> _produtos = [];
  String _nomeProduto = '';
  String _valorProduto = '';
  int _quantidadeProduto = 0;
  int _idCounter = 0; // Contador para gerar IDs únicos

  void _cadastrarProduto() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _idCounter++;
        _produtos.add(Produto(
          id: _idCounter,
          nome: _nomeProduto,
          valor: _valorProduto,
          quantidade: _quantidadeProduto,
        ));
        _formKey.currentState!.reset();
        _nomeProduto = '';
        _valorProduto = '';
        _quantidadeProduto = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome do Produto'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome do produto';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _nomeProduto = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Valor do Produto'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o valor do produto';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _valorProduto = value;
                    });
                  },
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Quantidade do Produto'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a quantidade do produto';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _quantidadeProduto = int.tryParse(value) ?? 0;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _cadastrarProduto,
                  child: Text('Cadastrar Produto'),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _produtos.length,
              itemBuilder: (context, index) {
                final produto = _produtos[index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle: Text(
                      'Valor: ${produto.valor}, Quantidade: ${produto.quantidade}'),
                  trailing: Text('ID: ${produto.id}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Tela de Carrinho
class CarrinhoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tela do Carrinho'),
    );
  }
}

// Tela de Perfil
class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tela de Perfil'),
    );
  }
}

// Tela de Ajuda
class AjudaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tela de Ajuda'),
    );
  }
}
