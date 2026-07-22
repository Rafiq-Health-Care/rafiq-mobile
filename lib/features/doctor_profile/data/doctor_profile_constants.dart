/// Languages the doctor can pick from when editing their basic info.
///
/// There's no backend endpoint (yet) to fetch the valid language enum
/// values the way there is for `specialization`, so this is a reasonable
/// fixed starter list — worth swapping for a real endpoint later.
const List<String> kDoctorProfileLanguageOptions = [
  'ENGLISH',
  'ARABIC',
  'FRENCH',
  'GERMAN',
  'SPANISH',
  'ITALIAN',
  'RUSSIAN',
  'CHINESE',
];
