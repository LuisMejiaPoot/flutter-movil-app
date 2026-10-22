import 'package:flutter/material.dart';
import 'package:flutter_application_api/product_by_id/ProductByIdService.dart';
import 'package:flutter_application_api/products/Product.dart';

class ProductByIdScreen extends StatefulWidget {
  final ProductByIdService productByIdService;

  // ID a precargar (por ejemplo, el producto que se acaba de tocar en la lista)
  final int? initialId;

  const ProductByIdScreen({
    super.key,
    required this.productByIdService,
    this.initialId,
  });

  @override
  State<ProductByIdScreen> createState() => _ProductByIdScreenState();
}

class _ProductByIdScreenState extends State<ProductByIdScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  Product? _product;

  @override
  void initState() {
    super.initState();
    final initialId = widget.initialId;
    if (initialId != null) {
      _idController.text = '$initialId';
      // La búsqueda se dispara tras el primer frame, cuando el Form ya existe
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _search();
      });
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _product = null;
    });

    try {
      final product = await widget.productByIdService.getProductById(
        int.parse(_idController.text.trim()),
      );
      if (!mounted) return;
      setState(() => _product = product);
    } catch (_) {
      if (!mounted) return;
      setState(() => _errorMessage = 'No se pudo obtener el producto.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Producto por ID')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _idController,
                    decoration: const InputDecoration(labelText: 'ID del producto'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (_) => _search(),
                    validator: (value) {
                      final id = int.tryParse((value ?? '').trim());
                      if (id == null) return 'Ingresa un ID numérico';
                      if (id <= 0) return 'El ID debe ser mayor que 0';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _search,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Buscar'),
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ],
                  if (_product != null) ...[
                    const SizedBox(height: 24),
                    Card(
                      child: ListTile(
                        title: Text(_product!.title),
                        subtitle: Text('ID: ${_product!.id}'),
                        trailing: Text(
                          '\$${_product!.price.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
