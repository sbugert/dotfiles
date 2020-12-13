import { styled } from 'uebersicht';
import palette from './palette';

const Box = styled('div')(
  ({ width, backgroundColor = palette.color05 }) => `
  ${width ? `width: ${width}px;` : ''}
  color: ${palette.color02};
  background: ${backgroundColor};
  font: 10px Menlo, Monospace;
  padding: 3px;
  line-height: 100%;
  text-align: center;
  border-radius: 1px;
  box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2), 0px 1px 1px 0px rgba(0,0,0,0.14), 0px 2px 1px -1px rgba(0,0,0,0.12);
  white-space: nowrap;
  overflow: scroll;
`
);
export default Box;
