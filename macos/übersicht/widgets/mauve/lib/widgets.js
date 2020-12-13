const widgets = [
  'window',
  'tunes',
  'workspace',
  'network',
  // 'timemachine',
  'disk',
  'battery',
  'sound',
  'clock',
];

export const getWidgetOrder = id => widgets.indexOf(id);
export const getWidgetStyles = id => `position: initial;
order: ${getWidgetOrder(id)};
margin-left: 7px;
${getWidgetOrder(id) === widgets.length - 1 ? 'margin-right: 7px;' : ''}`;
