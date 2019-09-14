part of diagnose;

class SlidingRadialList extends StatelessWidget {

  final RadialListViewModel radialList;
  final SlidingRadialListController controller;
  final VoidCallback onTap;

  SlidingRadialList({
    this.radialList,
    this.controller,
    this.onTap,
  });

  List<Widget> _radialListItems() {
    int index = 0;
    return radialList.items.map((RadialListItemViewModel viewModel) {
      final listItem = _radialListItem(
        viewModel,
        controller.getItemAngle(index),
        controller.getItemOpacity(index),
      );
      ++index;
      return listItem;
    }).toList();
  }

  Widget _radialListItem(RadialListItemViewModel viewModel, double angle, double opacity) {
    final double radius = SizeConfig.setWidth(140.0);
    return Transform(
      transform: Matrix4.translationValues(
        SizeConfig.setWidth(50.0),
        SizeConfig.setHeight(315.0),
        0.0,
      ),
      child: RadialPosition(
        radius: radius + SizeConfig.setWidth(75.0),
        angle: angle,
        child: Opacity(
          opacity: opacity,
          child: RadialListItem(
            listItem: viewModel,
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Stack(
          children: _radialListItems(),
        );
      },
    );
  }

}
