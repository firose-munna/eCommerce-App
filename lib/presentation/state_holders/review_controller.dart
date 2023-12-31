import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/product_review_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class ReviewController extends GetxController {
  bool _getReviewIsInProgress = false;
  String _errorMessage = '';
  ReviewModel _reviewModel = ReviewModel();

  bool get getReviewIsInProgress => _getReviewIsInProgress;
  String get errorMessage => _errorMessage;
  ReviewModel get reviewModel => _reviewModel;

  Future<bool> getReviews(int productId) async {
    late bool isSuccess;
    _getReviewIsInProgress = true;
    update();

    final NetworkResponse networkResponse =
        await NetworkCaller().getRequest(Urls.productReviewById(productId));
    _getReviewIsInProgress = false;
    update();

    if (networkResponse.isSuccess) {
      _reviewModel = ReviewModel.fromJson(networkResponse.responseJson ?? {});
      isSuccess = true;
    } else {
      _errorMessage = 'Review list data fetch failed';
      isSuccess = false;
    }
    update();
    return isSuccess;
  }

  Future<bool> addReview(
      {required int productId,
      required String review,
      required String productRating}) async {
    late bool isSuccess;
    _getReviewIsInProgress = true;
    update();
    final Map<String, dynamic> reviewData = {
      "product_id": productId,
      "description": review,
      "rating": int.parse(productRating),
    };
    final NetworkResponse networkResponse = await NetworkCaller().postRequest(
      Urls.createReview,
      reviewData,
      loginRequired: true,
    );
    _getReviewIsInProgress = false;
    update();

    if (networkResponse.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = 'Review added failed!';
      isSuccess = false;
    }
    update();
    return isSuccess;
  }
}
