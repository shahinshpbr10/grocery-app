import 'package:get/get.dart';

import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class ProductDetailsController extends GetxController {
  late ProductModel product;

  @override
  void onInit() {
    super.onInit();
    // Check if Get.arguments is not null before assigning it to product
    if (Get.arguments != null && Get.arguments is ProductModel) {
      product = Get.arguments as ProductModel;
    } else {
      // Handle the case where arguments are not provided or invalid
      // For example, navigate back or show an error message
      Get.back();
    }
  }

  /// when the user press on add to cart button
  onAddToCartPressed() {
    if (product.quantity == 0) {
      Get.find<BaseController>().onIncreasePressed(product.id);
    }
    Get.back();
  }
}
