import { getWidgetStyles } from './lib/widgets';
import Box from './lib/Box';
import palette from './lib/palette';

export const command = `
if [[ $(osascript -e 'output muted of (get volume settings)') = true ]]; then
  echo "0%"
elif [[ $(osascript -e 'output muted of (get volume settings)') = 'missing value' ]]; then
  echo "digital"
else
  osascript -e 'output volume of (get volume settings)'
fi
`;

// const map = (value, x, y, u, v) => ((value - x) * (v - u)) / (y - x) + u;
// const chars = [
//   '___ ',
//   // '▏  ▏',
//   '▎  ▏',
//   '▍  ▏',
//   '▌  ▏',
//   '▋  ▏',
//   '▊  ▏',
//   '▉  ▏',
//   '█  ▏',
//
//   '█▏ ▏',
//   '█▎ ▏',
//   '█▍ ▏',
//   '█▌ ▏',
//   '█▋ ▏',
//   '█▊ ▏',
//   '█▉ ▏',
//   '██ ▏',
//
//   '██▏▏',
//   '██▎▏',
//   '██▍▏',
//   '██▌▏',
//   '██▋▏',
//   '██▊▏',
//   '██▉▏',
//   '███▏',
// ];

export const refreshFrequency = 5000;

export const render = ({ output }) => (
  <Box
    backgroundColor={
      parseInt(output, 10) === 0 ? palette.color04 : palette.color0A
    }
    style={{
      whiteSpace: 'pre',
    }}
  >
    ♫{' '}{output.trim()}
    {/*chars[Math.round(map(parseInt(output, 10), 0, 100, 0, chars.length - 1))]*/}
  </Box>
);

export const className = `
  ${getWidgetStyles('sound')};
`;
