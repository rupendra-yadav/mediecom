abstract class ApiConstants {
  const ApiConstants();

  ///DEVELOPMENT
  static const _baseUrl = 'https://www.myadsworld.in/app';
  static const bannerImageUrl = 'https://www.myadsworld.in/uploads/advertise/';
  static const userImageUrl = 'https://www.myadsworld.in/uploads/users/';
  static const catImageUrl = 'https://www.myadsworld.in/uploads/category/';
  static const listingImageUrl = 'https://www.myadsworld.in/uploads/listings/';

  /// SSQL URL

  static const sqlexecc = 'https://www.myadsworld.in/api/mysql/sqlexecc.php';
  static const insertData =
      'https://www.myadsworld.in/api/mysql/insertsqlexe.php';
  static const ssqlUrl = 'https://www.myadsworld.in/api/mysql/ssql.php';
  static const uploadFile =
      'https://www.myadsworld.in/api/mysql/uploadfile.php';

  ///BANNERS ///
  static const getBanners = '$_baseUrl/get_banner.php';

  ///CATEGORY ///
  static const getCategory = '$_baseUrl/get_category.php';
  static const getCategoryById = '$_baseUrl/api_admin/get-category/';

  ///LISTING ///
  static const getListing = '$_baseUrl/get_featured_listings.php';
  static const getListingById = '$_baseUrl/api_admin/get-listing/';

  ///LISTING ///
  static const getFeatures = '$_baseUrl/feature.php';

  ///SUB CATEGORIES ///
  static const getSubCategories = '$_baseUrl/api_app/get-subcategory';
  static const getSubCategoryById = '$_baseUrl/api_admin/get-subcategory/';

  ///Auth
  static const sendOtp = 'https://www.myadsworld.in/api/mysql/get_otp.php';
  static const verifyOtp = 'https://www.myadsworld.in/api/mysql/verify_otp.php';

  ///Complete Profile
  static const updateProfile = '$_baseUrl/update_user.php';
}
