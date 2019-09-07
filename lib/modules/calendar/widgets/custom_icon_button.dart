part of calendar;

class _CustomIconButton extends StatelessWidget {

  final Icon icon;
  final VoidCallback onTap;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const _CustomIconButton({
    Key key,
    @required this.icon,
    @required this.onTap,
    this.margin,
    this.padding,
  })  : assert(icon != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: IconButton(
        padding: padding,
        onPressed: onTap,
        icon: icon,
      ),
    );
  }
  
}
