/// Simple country model used for the "Country or region" dropdown.
class Country {
  final String code;
  final String name;
  final String flagEmoji;

  const Country({
    required this.code,
    required this.name,
    required this.flagEmoji,
  });

  @override
  bool operator ==(Object other) => other is Country && other.code == code;

  @override
  int get hashCode => code.hashCode;
}

/// Dummy country list for the picker. Replace with a real dataset /
/// package (e.g. `country_picker`) when wiring up a backend.
class CountryData {
  CountryData._();

  static const List<Country> countries = [
    Country(code: 'EG', name: 'Egypt', flagEmoji: '🇪🇬'),
    Country(code: 'US', name: 'United States', flagEmoji: '🇺🇸'),
    Country(code: 'GB', name: 'United Kingdom', flagEmoji: '🇬🇧'),
    Country(code: 'SA', name: 'Saudi Arabia', flagEmoji: '🇸🇦'),
    Country(code: 'AE', name: 'United Arab Emirates', flagEmoji: '🇦🇪'),
    Country(code: 'DE', name: 'Germany', flagEmoji: '🇩🇪'),
    Country(code: 'FR', name: 'France', flagEmoji: '🇫🇷'),
    Country(code: 'CA', name: 'Canada', flagEmoji: '🇨🇦'),
  ];

  /// Default selection shown on screen load.
  static Country get defaultCountry => countries.first; // Egypt
}
