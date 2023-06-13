class EnumHelper {
  static useEnum<T extends Enum?>(T value, Map<T, dynamic> json) {
    if (value == null) return null;

    return json[value];
  }
}
