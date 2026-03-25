part of 'imports/intro_imports.dart';

class IntroComponentWidget extends StatefulWidget {
  final bool? isDragComplete;
  final List<String> imagePathesYouNeedToShowInSideOfPage;
  final int index;

  const IntroComponentWidget({
    super.key,
    this.isDragComplete = false,
    this.imagePathesYouNeedToShowInSideOfPage = const [],
    required this.index,
  });

  @override
  State<StatefulWidget> createState() => _IntroComponentWidgetState();
}

class _IntroComponentWidgetState extends State<IntroComponentWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  int rotationRadius = 300;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController.unbounded(vsync: this);
    _rotationAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDragComplete = widget.isDragComplete ?? false;
    if (isDragComplete && widget.index != _currentIndex) {
      _currentIndex = widget.index;
      final double nextAnimState = widget.index / 3;
      _animationController.animateTo(
        nextAnimState,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _buildAssetWithDefaultAngle(0, 240),
          _buildAssetWithDefaultAngle(1, 30),
          _buildAssetWithDefaultAngle(2, 180),
        ],
      ),
    );
  }

  Widget _buildAssetWithDefaultAngle(int index, double degreeAngle) {
    final double radianAngle = degreeAngle / 180 * pi;
    return AnimatedOpacity(
      opacity: index == _currentIndex % 3 ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: RotationTransition(
        turns: _rotationAnimation,
        child: Transform.translate(
          offset: Offset(
            rotationRadius * cos(radianAngle),
            rotationRadius * sin(radianAngle),
          ),
          child: SvgPicture.asset(
            widget.imagePathesYouNeedToShowInSideOfPage.elementAt(index),
            width: AppSize.sW60,
            height: AppSize.sH60,
          ),
        ),
      ),
    );
  }
}
