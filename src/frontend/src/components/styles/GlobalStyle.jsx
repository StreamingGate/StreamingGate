import { createGlobalStyle } from 'styled-components';

import robotoRegular from '@assets/font/Roboto-Regular.ttf';

const GlobalStyle = createGlobalStyle`
    @font-face {
        font-family: 'Roboto';
        src: url(${robotoRegular});
    }

    * {
        font-family: 'Roboto';
    }

    body {
        background-color: ${props => props.theme.colors.background}
    }
`;

export default GlobalStyle;