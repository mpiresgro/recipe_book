String timeFormatter(List<int> time) {
  return [time[0], time[1]]
      .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
      .join('h');
}
