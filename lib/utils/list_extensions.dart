extension ListExtensions<T> on List<T> {
  T? at(int index) {
    return this.length > index ? this[index] : null;
  }
}
