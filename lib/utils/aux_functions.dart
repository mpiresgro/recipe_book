
  String timeFormatter(Duration time) {
    return [time.inHours, time.inMinutes]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join('h');
  }
