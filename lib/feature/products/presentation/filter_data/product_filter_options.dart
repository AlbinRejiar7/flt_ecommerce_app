class ProductFilterOption {
  final String label;
  final String? category;

  const ProductFilterOption({required this.label, this.category});
}

class ProductFilterOptions {
  ProductFilterOptions._();

  static const List<ProductFilterOption> items = [
    ProductFilterOption(label: 'Clothes', category: 'clothing'),
    ProductFilterOption(label: 'Shoes', category: 'shoes'),
    ProductFilterOption(label: 'Bags', category: 'bags'),
    ProductFilterOption(label: 'Electronics', category: 'electronics'),
    ProductFilterOption(label: 'Watch', category: 'watch'),
    ProductFilterOption(label: 'Jewelry', category: 'jewelery'),
    ProductFilterOption(label: 'Kitchen', category: 'kitchen'),
    ProductFilterOption(label: 'Toys', category: 'toys'),
  ];
}
