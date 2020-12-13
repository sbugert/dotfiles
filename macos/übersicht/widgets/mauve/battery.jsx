import { getWidgetStyles } from './lib/widgets';
import Box from './lib/Box';
import palette from './lib/palette';

export const command = `
if pmset -g batt | grep AC &> /dev/null; then
    echo "⚡"
else
    echo "♥"
fi

battery="$(pmset -g batt | grep -o '[0-9]*%')"

if [[ "\${#battery}" -gt 3 ]] ; then
	echo "$battery" | tr -d '%'
else
	echo "$battery"
fi
`;

export const refreshFrequency = 30000;

export const render = ({ output }) => (
  <Box backgroundColor={palette.color0B}>{output}</Box>
);

export const className = `
  ${getWidgetStyles('battery')};
`;
