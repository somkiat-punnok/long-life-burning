part of providers;

class NavBarProvider extends ValueNotifier<int> {
  NavBarProvider({int value = 0}) : super(value);
  void reset() {
    super.value = 0;
  }
}
