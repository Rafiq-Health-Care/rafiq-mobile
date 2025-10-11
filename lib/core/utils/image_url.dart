class ImageUrl {
  static final ImageUrl _instance = ImageUrl._();
  factory ImageUrl() => _instance;
  ImageUrl._();

  final String splashLogo = 'assets/images/logo.png';
  final String googleSvg = 'assets/icons/google.svg';
  final String facebookSvg = 'assets/icons/facebook.svg';
}
