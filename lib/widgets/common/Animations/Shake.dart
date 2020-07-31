part of 'export.dart';

class AnimatedShakeController extends ChangeNotifier {
  AnimationController _anim;

  Future<void> call({
    double distance,
    double around,
  }) {
    notifyListeners();
    return _anim.forward(from: 0);
  }
}

class AnimatedShake extends StatefulWidget {
  final Widget child;
  final double distance;
  final double around;
  final AnimatedShakeController controller;

  AnimatedShake({
    @required this.child,
    this.around = 10,
    this.distance = 10,
    this.controller,
  });

  @override
  _AnimatedShakeState createState() => _AnimatedShakeState();
}

class _AnimatedShakeState extends State<AnimatedShake>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation _anim;

  Offset get _offset => Offset(sin(_anim.value * pi) * widget.distance, 0);

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _anim = Tween<double>(begin: 0, end: widget.around).animate(controller);
    widget.controller?._anim = controller;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.translate(
        offset: _offset,
        child: child,
      ),
      child: widget.child,
    );
  }
}
