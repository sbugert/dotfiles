import { getWidgetStyles } from './lib/widgets';
import Box from './lib/Box';
import palette from './lib/palette';

export const command = `
ps cax | grep iTunes | grep -v com.apple.iTunesLibraryService > /dev/null
if [ $? -eq 0 ]; then
  osascript -e 'tell application "iTunes" to if player state is playing then artist of current track & " / " & name of current track'
fi
`;

export const refreshFrequency = 5000;

export const render = ({ output }) =>
  output && output.length ? (
    <Box style={{ maxWidth: '20vw' }} backgroundColor={palette.color0E}>
      ♬ {output}
    </Box>
  ) : null;

export const className = `
  ${getWidgetStyles('tunes')};
  margin-right: auto;
`;
