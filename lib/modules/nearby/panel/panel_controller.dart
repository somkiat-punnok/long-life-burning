part of panel;

class PanelController {

  VoidCallback _closeListener;
  VoidCallback _openListener;
  VoidCallback _hideListener;
  VoidCallback _showListener;
  Function(double value) _setPanelPositionListener;
  Function(double value) _setAnimatePanelToPositionListener;
  double Function() _getPanelPositionListener;
  bool Function() _isPanelAnimatingListener;
  bool Function() _isPanelOpenListener;
  bool Function() _isPanelClosedListener;
  bool Function() _isPanelShownListener;

  void addListeners(
    VoidCallback closeListener,
    VoidCallback openListener,
    VoidCallback hideListener,
    VoidCallback showListener,
    Function(double value) setPanelPositionListener,
    Function(double value) setAnimatePanelToPositionListener,
    double Function() getPanelPositionListener,
    bool Function() isPanelAnimatingListener,
    bool Function() isPanelOpenListener,
    bool Function() isPanelClosedListener,
    bool Function() isPanelShownListener,
  ) {
    this._closeListener = closeListener;
    this._openListener = openListener;
    this._hideListener = hideListener;
    this._showListener = showListener;
    this._setPanelPositionListener = setPanelPositionListener;
    this._setAnimatePanelToPositionListener = setAnimatePanelToPositionListener;
    this._getPanelPositionListener = getPanelPositionListener;
    this._isPanelAnimatingListener = isPanelAnimatingListener;
    this._isPanelOpenListener = isPanelOpenListener;
    this._isPanelClosedListener = isPanelClosedListener;
    this._isPanelShownListener = isPanelShownListener;
  }

  void close(){
    _closeListener();
  }

  void open(){
    _openListener();
  }

  void hide(){
    _hideListener();
  }

  void show(){
    _showListener();
  }

  void setPanelPosition(double value){
    assert(0.0 <= value && value <= 1.0);
    _setPanelPositionListener(value);
  }

  void animatePanelToPosition(double value){
    assert(0.0 <= value && value <= 1.0);
    _setAnimatePanelToPositionListener(value);
  }

  double getPanelPosition(){
    return _getPanelPositionListener();
  }

  bool isPanelAnimating(){
    return _isPanelAnimatingListener();
  }

  bool isPanelOpen(){
    return _isPanelOpenListener();
  }

  bool isPanelClosed(){
    return _isPanelClosedListener();
  }

  bool isPanelShown(){
    return _isPanelShownListener();
  }

}