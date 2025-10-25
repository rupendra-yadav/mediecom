import 'package:flutter/material.dart';
// Assuming products.dart contains the buildProductCard widget
import 'package:mediecom/features/explore/presentation/widgets/products.dart';

class ProductDetailPage extends StatelessWidget {
  static const path = '/product-details';
  const ProductDetailPage({super.key, required this.tag, required this.imgUrl});
  final String tag;
  final String imgUrl;

  final List<String> imageUrls = const [
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Allows body to go behind transparent app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(); // Go back
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
              // Handle favorite button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {
              // Handle share button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Section (Hero for smooth transition)
            Hero(
              tag: tag,
              child: Container(
                height: 300, // Slightly taller for medical packaging
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit
                        .contain, // Use contain for product packaging clarity
                  ),
                  color: Colors.grey[100], // Background for the image
                ),
                alignment: Alignment.topRight, // Align star rating
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min, // Only take required space
                      children: const [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        SizedBox(width: 4),
                        Text('4.5/5', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Paracetamol 500mg Tablets', // Example medicine name
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.local_pharmacy,
                        color: Colors.grey[700],
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Pain Relief',
                        style: TextStyle(color: Colors.grey[700]),
                      ), // Category
                      const SizedBox(width: 16),
                      Icon(
                        Icons.medical_services,
                        color: Colors.grey[700],
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Brand Name',
                        style: TextStyle(color: Colors.grey[700]),
                      ), // Brand
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Effective relief from mild to moderate pain including headaches, migraine, neuralgia, toothache, sore throat, and period pain. It also relieves fever and discomfort associated with colds and flu.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Dosage & Directions'),
                  const SizedBox(height: 12),
                  const Text(
                    'Adults and children over 12 years: Take 1-2 tablets every 4-6 hours as needed. Do not exceed 8 tablets in 24 hours. Read the label carefully before use.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Active Ingredients'),
                  const SizedBox(height: 12),
                  // Active Ingredients as a list or wrap of text
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: [
                      _buildInfoChip('Paracetamol 500mg'),
                      _buildInfoChip('Caffeine 65mg (if applicable)'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Warnings & Precautions'),
                  const SizedBox(height: 12),
                  // Bullet points for warnings
                  _buildWarningPoint('Do not exceed the stated dose.'),
                  _buildWarningPoint(
                    'Consult your doctor if symptoms persist.',
                  ),
                  _buildWarningPoint('Keep out of reach of children.'),
                  _buildWarningPoint(
                    'Not suitable for children under 12 without medical advice.',
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Related Products'),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200, // Height for the horizontal list
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                      ), // Adjust padding
                      itemCount: imageUrls.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        // Using a placeholder for buildProductCard - ensure it's defined
                        // in mediecom/features/explore/presentation/widgets/products.dart
                        return buildProductCard(imageUrls[index], index);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 12); // space between items
                      },
                    ),
                  ),
                  const SizedBox(height: 20), // Extra space before bottom bar
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 2,
              ), // Smaller padding
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      // Handle decrement
                    },
                  ),
                  const Text(
                    '1', // Quantity
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.black, size: 20),
                    onPressed: () {
                      // Handle increment
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Handle Add to Cart
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .blue
                      .shade700, // Primary action color for medical apps
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add to Cart \$12.50', // Example price for medicine
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildInfoChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.blue.shade50,
      labelStyle: TextStyle(color: Colors.blue.shade800),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  Widget _buildWarningPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber, color: Colors.orange, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder for buildProductCard from 'products.dart'
// You need to ensure this widget is correctly defined in your file.
// For demonstration, here's a basic implementation:
Widget buildProductCard(String imageUrl, int index) {
  return Container(
    width: 140, // Adjust width as needed
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 3,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Related Med',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$9.99',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
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
