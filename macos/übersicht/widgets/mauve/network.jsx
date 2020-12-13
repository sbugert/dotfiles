import { getWidgetStyles } from './lib/widgets';
import Box from './lib/Box';
import palette from './lib/palette';

export const command = `
echo "↓ $(networksetup -getairportnetwork en0 | cut -c 24-)"
`;

export const refreshFrequency = 30000;

export const render = ({ output }) => (
  <Box backgroundColor={palette.color0C}>{output}</Box>
);

export const className = `
  ${getWidgetStyles('network')};
  margin-left: auto;
`;
