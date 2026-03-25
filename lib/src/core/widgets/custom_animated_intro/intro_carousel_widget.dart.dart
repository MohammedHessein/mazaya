part of 'imports/intro_imports.dart';

class IntroCarouselWidget extends StatefulWidget {
  final List<Widget> children;
  final List<String> imagePathesYouNeedToShowInSideOfPage;

  const IntroCarouselWidget({
    super.key,
    required this.children,
    this.imagePathesYouNeedToShowInSideOfPage = const [],
  });

  @override
  IntroCarouselWidgetState createState() => IntroCarouselWidgetState();
}

class IntroCarouselWidgetState extends State<IntroCarouselWidget>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  int? _dragIndex;
  Offset _dragOffset = Offset.zero;
  double _dragDirection = 0;
  bool _dragCompleted = false;
  final ValueNotifier<int> indexNotifier = ValueNotifier<int>(0);
  IntroEdgeOperation edge = IntroEdgeOperation(count: 25);
  late Ticker _ticker;
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    _ticker = createTicker(_tick)..start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _tick(Duration duration) {
    edge.tick(duration);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final int length = widget.children.length;
    return GestureDetector(
      key: key,
      onPanDown: (details) => _handlePanDown(details, _getSize()),
      onPanUpdate: (details) => _handlePanUpdate(details, _getSize()),
      onPanEnd: (details) => _handlePanEnd(details, _getSize()),
      child: Stack(
        children: <Widget>[
          widget.children[_index % length],
          _dragIndex == null
              ? const SizedBox.shrink()
              : ClipPath(
                  clipBehavior: Clip.hardEdge,
                  clipper: IntroClipper(edge, margin: 10.0),
                  child: widget.children[_dragIndex! % length],
                ),
          Positioned(
            bottom: AppMargin.mH18,
            right: AppMargin.mW12,
            left: AppMargin.mW12,
            child: ValueListenableBuilder(
              valueListenable: indexNotifier,
              builder: (context, value, child) {
                return DefaultButton(
                  title: value % length == 2
                      ? LocaleKeys.introStartnow
                      : LocaleKeys.introNext,
                  onTap: () => value % length == 2
                      ? Go.to(const HomeScreen())
                      // ? Go.to(const LoginScreen())
                      : _animateToNextPage(),
                );
              },
            ),
          ),
          if (widget.imagePathesYouNeedToShowInSideOfPage.isNotEmpty) ...[
            IntroComponentWidget(
              index: _dragIndex ?? 0,
              isDragComplete: _dragCompleted,
              imagePathesYouNeedToShowInSideOfPage:
                  widget.imagePathesYouNeedToShowInSideOfPage,
            ),
          ],
        ],
      ),
    );
  }

  //---------------------------> Operations <------------------------------
  Size _getSize() {
    final RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    return box?.size ?? Size.zero;
  }

  void _handlePanDown(DragDownDetails details, Size size) {
    if (_dragIndex != null && _dragCompleted) {
      _index = _dragIndex!;
      indexNotifier.value = _index;
    }
    _dragIndex = null;
    _dragOffset = details.localPosition;
    _dragCompleted = false;
    _dragDirection = 0;

    edge.farEdgeTension = 0.0;
    edge.edgeTension = 0.01;
    edge.reset();
  }

  void _handlePanUpdate(DragUpdateDetails details, Size size) {
    double dx = details.localPosition.dx - _dragOffset.dx;

    if (!_isSwipeActive(dx)) {
      return;
    }
    if (_isSwipeComplete(dx, size.width)) {
      return;
    }

    if (_dragDirection == -1) {
      dx = size.width + dx;
    }
    edge.applyTouchOffset(Offset(dx, details.localPosition.dy), size);
  }

  bool _isSwipeActive(double dx) {
    // check if a swipe is just starting:
    if (_dragDirection == 0.0 && dx.abs() > 20.0) {
      _dragDirection = dx.sign;
      edge.side = _dragDirection == 1.0 ? Side.left : Side.right;
      setState(() {
        final int swipDirectionDependOnLanguage =
            Languages.currentLanguage.languageCode == "ar" ? -1 : 1;
        _dragIndex =
            _index - _dragDirection.toInt() * swipDirectionDependOnLanguage;
      });
    }
    return _dragDirection != 0.0;
  }

  bool _isSwipeComplete(double dx, double width) {
    if (_dragDirection == 0.0) {
      return false;
    } // not started
    if (_dragCompleted) {
      return true;
    } // already done

    // check if swipe is just completed:
    double availW = _dragOffset.dx;
    if (_dragDirection == 1) {
      availW = width - availW;
    }
    final double ratio = dx * _dragDirection / availW;

    if (ratio > 0.8 && availW / width > 0.5) {
      _dragCompleted = true;
      edge.farEdgeTension = 0.01;
      edge.edgeTension = 0.0;
      edge.applyTouchOffset();
    }
    return _dragCompleted;
  }

  void _handlePanEnd(DragEndDetails details, Size size) {
    edge.applyTouchOffset();
  }

  void _animateToNextPage() {
    final Size size = _getSize();
    if (size == Size.zero) return;

    // REVERSE the swipe direction for button tap
    // For AR: swipe LTR (positive direction)
    // For EN: swipe RTL (negative direction)
    final double swipeDirection = Languages.currentLanguage.languageCode == "ar"
        ? 1
        : -1;

    // Set starting position based on swipe direction
    // For LTR swipe: start from left side
    // For RTL swipe: start from right side
    final double startX = swipeDirection > 0
        ? size.width * 0.2
        : size.width * 0.8;
    _dragOffset = Offset(startX, size.height / 2);

    _handlePanDown(DragDownDetails(localPosition: _dragOffset), size);

    // Calculate end position
    final double endX = swipeDirection > 0
        ? size.width * 0.9
        : size.width * 0.1;
    final double totalDistance = (endX - startX).abs();

    // Trigger the swipe with enough distance to activate (more than 20.0)
    Future.delayed(const Duration(milliseconds: 16), () {
      if (!mounted) return;

      _handlePanUpdate(
        DragUpdateDetails(
          localPosition: Offset(startX + (swipeDirection * 30), _dragOffset.dy),
          delta: Offset(swipeDirection * 30, 0),
          globalPosition: Offset(
            startX + (swipeDirection * 30),
            _dragOffset.dy,
          ),
        ),
        size,
      );

      // Continue the swipe to completion with smooth animation
      for (int i = 1; i <= 15; i++) {
        Future.delayed(Duration(milliseconds: i * 12), () {
          if (mounted) {
            final double progress = i / 15.0;
            final double currentX =
                startX + (swipeDirection * totalDistance * progress);

            _handlePanUpdate(
              DragUpdateDetails(
                localPosition: Offset(currentX, _dragOffset.dy),
                delta: Offset(swipeDirection * (totalDistance / 15), 0),
                globalPosition: Offset(currentX, _dragOffset.dy),
              ),
              size,
            );
          }
        });
      }

      // End the swipe
      Future.delayed(const Duration(milliseconds: 220), () {
        if (mounted) {
          _handlePanEnd(DragEndDetails(), size);
        }
      });
    });
  }
}
