import { getWidgetStyles } from './lib/widgets';
import Box from './lib/Box';
import palette from './lib/palette';

export const command = `df -PH .| awk '/d*G/ {print $4}'`;

export const refreshFrequency = 300;

export const render = ({ output }) => (
  <Box backgroundColor={palette.color0E}>{output}</Box>
);

export const className = `
  ${getWidgetStyles('disk')};
`;
