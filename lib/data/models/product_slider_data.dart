import './product_slider_model.dart';

class ProductSliderData {
  String? msg;
  List<ProductSliderModel>? productSliderModel;

  ProductSliderData({this.msg, this.productSliderModel});

  ProductSliderData.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      productSliderModel = <ProductSliderModel>[];
      json['data'].forEach((v) {
        productSliderModel!.add(ProductSliderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> productslidermodel = {};
    productslidermodel['msg'] = msg;
    if (productSliderModel != null) {
      productslidermodel['data'] =
          productSliderModel!.map((v) => v.toJson()).toList();
    }
    return productslidermodel;
  }
}
