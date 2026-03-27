class NavigationBarEntity {
  final String icon;
  final String? activeIcon;
  final String text;

  const NavigationBarEntity({
    required this.icon,
    this.activeIcon,
    required this.text,
  });
}
