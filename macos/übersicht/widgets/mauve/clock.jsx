import { getWidgetStyles } from './lib/widgets';
import Box from './lib/Box';
import palette from './lib/palette';

export const command = 'date +"%a, %b %d %H:%M"';

export const refreshFrequency = 60000;

export const render = ({ output }) => (
  <Box backgroundColor={palette.color0D}>{output}</Box>
);

export const className = `
  ${getWidgetStyles('clock')};
`;
