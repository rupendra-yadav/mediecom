abstract class ApiConstants {
  const ApiConstants();

  /// Base URL
  static const _baseUrl = 'https://www.subhlaxmimedical.com/myadmin/Api';
  static const sliderBase =
      "https://www.subhlaxmimedical.com/myadmin/uploads/slider/";

  // ================================================================
  // AUTHENTICATION
  // ================================================================
  static const signUp = "$_baseUrl/signup_user";
  static const sendOtp = "$_baseUrl/send_otp";
  static const verifyOtp = "$_baseUrl/verify_otp";

  // ================================================================
  // USER
  // ================================================================
  static const userDetails = "$_baseUrl/user_details";
  static const updateProfile = "$_baseUrl/update_profile";
  static const updatePhoto = "$_baseUrl/update_photo";
  static const updateFcm = "$_baseUrl/update_fcm";
  static const notification = "$_baseUrl/notification";

  // ================================================================
  // APPLICATION INFO
  // ================================================================
  static const application = "$_baseUrl/application";

  // ================================================================
  // BANNERS INFO
  // ================================================================
  static const slider = "$_baseUrl/slider";

  // ================================================================
  // PRODUCT & CATEGORY
  // ================================================================
  static const category = "$_baseUrl/category";
  static const subcategory = "$_baseUrl/subcategory";
  static const product = "$_baseUrl/product";

  // ================================================================
  // ORDERS
  // ================================================================
  static const insertOrder = "$_baseUrl/insert_order";
  static const orderList = "$_baseUrl/order_list";
  static const orderDetails = "$_baseUrl/order_details";
  static const orderHistoryList = "$_baseUrl/order_history_list";
  static const updateOrderStatus = "$_baseUrl/update_order_status";

  // ================================================================
  // MYSQL FALLBACK URLS (if used)
  // ================================================================
  static const sqlexecc = 'https://www.myadsworld.in/api/mysql/sqlexecc.php';
  static const insertData =
      'https://www.myadsworld.in/api/mysql/insertsqlexe.php';
  static const ssqlUrl = 'https://www.myadsworld.in/api/mysql/ssql.php';
  static const uploadFile =
      'https://www.myadsworld.in/api/mysql/uploadfile.php';
}
