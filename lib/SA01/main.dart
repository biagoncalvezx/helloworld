import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BelezaPage(),
    );
  }
}

class BelezaPage extends StatefulWidget {
  const BelezaPage({super.key});

  @override
  State<BelezaPage> createState() => _BelezaPageState();
}


class _BelezaPageState extends State<BelezaPage> {
  // Índice da BottomNavigationBar
  int _selectedIndex = 0;

  
  final List<String> _categorias = [
    'Todos',
    'Maquiagem',
    'Skincare',
    'Cabelos',
    'Perfumes',
  ];

  
  String _categoriaSelecionada = 'Todos';

  
  final List<Map<String, dynamic>> _produtos = [
    
    {
      'nome': 'Base Líquida',
      'categoria': 'Maquiagem',
      'preco': 89.90,
      'marca': 'MAC',
      'completado': false,
    },
    {
      'nome': 'Pó Compacto',
      'categoria': 'Maquiagem',
      'preco': 65.00,
      'marca': 'Natura',
      'completado': false,
    },
    {
      'nome': 'Batom Matte',
      'categoria': 'Maquiagem',
      'preco': 45.90,
      'marca': 'Avon',
      'completado': false,
    },
    {
      'nome': 'Paleta de Sombras',
      'categoria': 'Maquiagem',
      'preco': 120.00,
      'marca': 'Boticário',
      'completado': false,
    },
    {
      'nome': 'Máscara de Cílios',
      'categoria': 'Maquiagem',
      'preco': 55.00,
      'marca': 'Maybelline',
      'completado': false,
    },

    
    {
      'nome': 'Hidratante Facial',
      'categoria': 'Skincare',
      'preco': 75.00,
      'marca': 'Nivea',
      'completado': false,
    },
    {
      'nome': 'Protetor Solar FPS 50',
      'categoria': 'Skincare',
      'preco': 85.00,
      'marca': 'La Roche',
      'completado': false,
    },
    {
      'nome': 'Sérum Antissinais',
      'categoria': 'Skincare',
      'preco': 150.00,
      'marca': 'Vichy',
      'completado': false,
    },
    {
      'nome': 'Limpeza de Pele',
      'categoria': 'Skincare',
      'preco': 40.00,
      'marca': 'Neutrogena',
      'completado': false,
    },

    
    {
      'nome': 'Shampoo Hidratante',
      'categoria': 'Cabelos',
      'preco': 35.00,
      'marca': 'Pantene',
      'completado': false,
    },
    {
      'nome': 'Condicionador Reparador',
      'categoria': 'Cabelos',
      'preco': 35.00,
      'marca': 'Pantene',
      'completado': false,
    },
    {
      'nome': 'Máscara Capilar',
      'categoria': 'Cabelos',
      'preco': 55.00,
      'marca': 'L\'Oréal',
      'completado': false,
    },
    {
      'nome': 'Óleo Reparador',
      'categoria': 'Cabelos',
      'preco': 45.00,
      'marca': 'Elseve',
      'completado': false,
    },

    
    {
      'nome': 'Perfume Floral',
      'categoria': 'Perfumes',
      'preco': 200.00,
      'marca': 'Lancôme',
      'completado': false,
    },
    {
      'nome': 'Perfume Cítrico',
      'categoria': 'Perfumes',
      'preco': 180.00,
      'marca': 'Dior',
      'completado': false,
    },
    {
      'nome': 'Colônia Leve',
      'categoria': 'Perfumes',
      'preco': 95.00,
      'marca': 'Natura',
      'completado': false,
    },
  ];

  
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();

  
  String _novaCategoria = 'Maquiagem';

  
  List<Map<String, dynamic>> _getProdutosFiltrados() {
    if (_categoriaSelecionada == 'Todos') {
      return _produtos;
    } else {
      return _produtos
          .where((produto) => produto['categoria'] == _categoriaSelecionada)
          .toList();
    }
  }

  
  double _calcularTotal() {
    double total = 0;
    for (var produto in _produtos) {
      if (produto['completado'] == true) {
        total += produto['preco'];
      }
    }
    return total;
  }

  
  int _contarComprados() {
    int count = 0;
    for (var produto in _produtos) {
      if (produto['completado'] == true) {
        count++;
      }
    }
    return count;
  }

  
  void _adicionarProduto() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Novo Produto',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE91E63),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Campo nome
                TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Produto',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.spa),
                  ),
                ),
                const SizedBox(height: 16),

                // Campo preço
                TextField(
                  controller: _precoController,
                  decoration: const InputDecoration(
                    labelText: 'Preço (R\$)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

                // Campo marca
                TextField(
                  controller: _marcaController,
                  decoration: const InputDecoration(
                    labelText: 'Marca',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.branding_watermark),
                  ),
                ),
                const SizedBox(height: 16),

                // Dropdown para categoria
                DropdownButtonFormField<String>(
                  value: _novaCategoria,
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Maquiagem',
                      child: Text('Maquiagem'),
                    ),
                    DropdownMenuItem(
                      value: 'Skincare',
                      child: Text('Skincare'),
                    ),
                    DropdownMenuItem(
                      value: 'Cabelos',
                      child: Text('Cabelos'),
                    ),
                    DropdownMenuItem(
                      value: 'Perfumes',
                      child: Text('Perfumes'),
                    ),
                  ],
                  onChanged: (valor) {
                    setState(() {
                      _novaCategoria = valor!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _nomeController.clear();
                _precoController.clear();
                _marcaController.clear();
                Navigator.pop(context);
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: _salvarProduto,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE91E63),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Adicionar',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }

  
  void _salvarProduto() {
    final nome = _nomeController.text.trim();
    final precoTexto = _precoController.text.trim();
    final marca = _marcaController.text.trim();

    if (nome.isNotEmpty && precoTexto.isNotEmpty && marca.isNotEmpty) {
      final preco = double.tryParse(precoTexto.replaceAll(',', '.'));

      if (preco != null && preco > 0) {
        setState(() {
          _produtos.add({
            'nome': nome,
            'categoria': _novaCategoria,
            'preco': preco,
            'marca': marca,
            'completado': false,
          });
        });

        
        _nomeController.clear();
        _precoController.clear();
        _marcaController.clear();

        Navigator.pop(context);

        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 10),
                const Text(
                  'Produto adicionado!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFE91E63),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Digite um preço válido!'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos!'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  
  void _alternarComprado(int index) {
    setState(() {
      _produtos[index]['completado'] = !_produtos[index]['completado'];
    });
  }

  
  void _excluirProduto(int index) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Confirmar Exclusão',
            style: TextStyle(fontSize: 24, color: Color(0xFFE91E63)),
          ),
          content: Text(
            'Tem certeza que deseja excluir "${_produtos[index]['nome']}"?',
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _produtos.removeAt(index);
                });
                Navigator.of(dialogContext).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.delete, color: Colors.white),
                        const SizedBox(width: 10),
                        const Text(
                          'Produto removido!',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(16),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFE91E63),
              ),
              child: const Text(
                'Excluir',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }


  Widget _buildResumoCompras() {
    final comprados = _contarComprados();
    final total = _calcularTotal();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🛍️ Minhas Compras',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE91E63),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Produtos de Beleza & Estética',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 30),

          // Cards de resumo
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.shopping_bag,
                          size: 40,
                          color: Color(0xFFE91E63),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${_produtos.length}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Total de Itens',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 40,
                          color: Color(0xFF4CAF50),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$comprados',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Itens Comprados',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Card de Total
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: const Color(0xFFFFF0F5),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        size: 30,
                        color: Color(0xFFE91E63),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Total Gasto',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'R\$ ${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE91E63),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

 
  Widget _buildListaProdutos() {
    final produtosFiltrados = _getProdutosFiltrados();

    if (produtosFiltrados.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.spa,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhum produto em "${_categoriaSelecionada}"',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Toque em + para adicionar!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: produtosFiltrados.length,
      itemBuilder: (context, index) {
        // Índice real na lista original
        final realIndex = _produtos.indexOf(produtosFiltrados[index]);
        final produto = _produtos[realIndex];

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Checkbox(
              value: produto['completado'],
              activeColor: const Color(0xFFE91E63),
              onChanged: (_) => _alternarComprado(realIndex),
            ),
            title: Text(
              produto['nome'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                decoration: produto['completado']
                    ? TextDecoration.lineThrough
                    : null,
                color: produto['completado'] ? Colors.grey : Colors.black87,
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                  produto['marca'],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF0F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    produto['categoria'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFE91E63),
                    ),
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'R\$ ${produto['preco'].toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: produto['completado'] ? Colors.green : Colors.black87,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                  ),
                  onPressed: () => _excluirProduto(realIndex),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildCategorias() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categorias.length,
        itemBuilder: (context, index) {
          final categoria = _categorias[index];
          final isSelected = _categoriaSelecionada == categoria;

          return GestureDetector(
            onTap: () {
              setState(() {
                _categoriaSelecionada = categoria;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE91E63) : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  categoria,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildResumoCompras();
      case 1:
        return Column(
          children: [
            _buildCategorias(),
            Expanded(child: _buildListaProdutos()),
          ],
        );
      default:
        return _buildResumoCompras();
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: const Text(
          '✨ Beleza & Estética',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFFE91E63),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('💖 Amamos beleza!'),
                  backgroundColor: Color(0xFFE91E63),
                ),
              );
            },
          ),
        ],
      ),

      // Drawer
      drawer: Drawer(
        child: ListView(
          children: [
            // Cabeçalho rosa
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE91E63), Color(0xFFF48FB1)],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.spa, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Beleza App',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Sua lista de compras de beleza',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),

            // Itens do Drawer
            ListTile(
              leading: const Icon(Icons.dashboard, size: 30, color: Color(0xFFE91E63)),
              title: const Text(
                'Resumo',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 10),

            ListTile(
              leading: const Icon(Icons.shopping_bag, size: 30, color: Color(0xFFE91E63)),
              title: const Text(
                'Produtos',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 10),

            ListTile(
              leading: const Icon(Icons.favorite, size: 30, color: Color(0xFFE91E63)),
              title: const Text(
                'Favoritos',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('💖 Seus favoritos em breve!'),
                    backgroundColor: Color(0xFFE91E63),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // Body
      body: _buildBody(),

      // Floating Action Button (adicionar)
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarProduto,
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 30),
      ),

      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: const Color(0xFFE91E63),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Resumo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Produtos',
          ),
        ],
      ),
    );
  }

  // - - - - - - - Dispose (limpar controllers) - - - - - - -
  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _marcaController.dispose();
    super.dispose();
  }
}