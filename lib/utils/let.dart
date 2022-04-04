// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKINect
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

T? let<T>(final dynamic input) {
  // 0. Return input if it's already the same type as T.
  if (input.runtimeType == T) return input as T;
  // 1. Return input if it's alread null.
  if (input == null) return input;
  try {
    // 2. Try casting the input.
    return input as T;
  } catch (_) {
    T? res;
    // 3. If that fails and if input is a String and T is a number, try
    // converting input to a number.
    if (input.runtimeType == String) {
      switch (T) {
        case int:
          res = int.tryParse(input) as T?;
          break;
        case double:
          res = double.tryParse(input) as T?;
          break;
        case num:
          res = num.tryParse(input) as T?;
          break;
        default:
      }
    }
    // 4. If T is a String, just call .toString() on the Object.
    if (T is String) {
      res = input.toString() as T;
    }
    return res;
  }
}
