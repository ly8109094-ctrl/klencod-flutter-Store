import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme.dart';

class SellerSection extends StatefulWidget {
  const SellerSection({
    super.key,
    required this.todayUploads,
    required this.sellerProducts,
    required this.onAddProduct,
    required this.onDelete,
  });

  final int todayUploads;
  final List<Product> sellerProducts;
  final Function(Product) onAddProduct;
  final Function(int) onDelete;

  @override
  State<SellerSection> createState() => _SellerSectionState();
}

class _SellerSectionState extends State<SellerSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  String _selectedCategory = 'إلكترونيات';
  String _selectedCurrency = 'ريال يمني';

  final List<String> categories = const [
    'إلكترونيات',
    'أزياء',
    'المنزل',
    'إكسسوارات',
  ];

  final List<String> currencies = const [
    'ريال يمني',
    'ريال سعودي',
  ];

  static const int maxDailyUploads = 5;

  void _submit() {
    if (widget.todayUploads >= maxDailyUploads) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('عفواً، لقد استنفدت الحد المسموح به اليوم (5 منتجات فقط باليوم)'),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        id: DateTime.now().millisecondsSinceEpoch,
        name: _nameController.text.trim(),
        category: _selectedCategory,
        price: double.tryParse(_priceController.text.trim()) ?? 0,
        currency: _selectedCurrency,
        colorValue: 0xFFFFD7A8,
        description: _descController.text.trim(),
        isSellerProduct: true,
        sellerName: 'بائع معتمد',
      );

      widget.onAddProduct(newProduct);
      _nameController.clear();
      _descController.clear();
      _priceController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('تم نشر منتجك بنجاح في المتجر!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final remaining = maxDailyUploads - widget.todayUploads;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: StoreTheme.ink,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.store, color: StoreTheme.orange, size: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'بوابة البائع المستقل',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'المتبقي لك اليوم: ${remaining > 0 ? remaining : 0} من أصل $maxDailyUploads منتجات',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'إضافة منتج جديد',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'اسم المنتج',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => (v == null || v.isEmpty) ? 'الرجاء إدخال الاسم' : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: const InputDecoration(
                            labelText: 'القسم',
                            border: OutlineInputBorder(),
                          ),
                          items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                          onChanged: (v) => setState(() => _selectedCategory = v!),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedCurrency,
                          decoration: const InputDecoration(
                            labelText: 'العملة',
                            border: OutlineInputBorder(),
                          ),
                          items: currencies.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                          onChanged: (v) => setState(() => _selectedCurrency = v!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'السعر',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => (v == null || double.tryParse(v) == null) ? 'أدخل سعراً صحيحاً' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'وصف المنتج',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => (v == null || v.isEmpty) ? 'الرجاء إدخال الوصف' : null,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: remaining > 0 ? _submit : null,
                      icon: const Icon(Icons.cloud_upload_outlined),
                      label: const Text('نشر المنتج بالمتجر'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'منتجاتك المنشورة:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        if (widget.sellerProducts.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text('لم تقم بنشر أي منتجات حتى الآن.'),
            ),
          )
        else
          ...widget.sellerProducts.map(
            (p) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: p.color,
                  child: const Icon(Icons.inventory_2_outlined, color: Colors.black54),
                ),
                title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${p.price.toStringAsFixed(0)} ${p.currency} - ${p.category}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => widget.onDelete(p.id),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
