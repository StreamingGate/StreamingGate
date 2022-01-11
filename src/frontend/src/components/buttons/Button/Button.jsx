import React from 'react';
import PropTypes from 'prop-types';

import ButtonStyle from './Button.style';

function Button({ variant, children, color, size, fullWidth, onClick }) {
  return (
    <ButtonStyle.B
      type='button'
      variant={variant}
      color={color}
      size={size}
      fullWidth={fullWidth}
      onClick={onClick}
    >
      {children}
    </ButtonStyle.B>
  );
}

Button.propTypes = {
  variant: PropTypes.oneOf(['contained', 'outlined']),
  children: PropTypes.node,
  color: PropTypes.oneOf(['youtubeRed', 'youtubeBlue']),
  size: PropTypes.oneOf(['small', 'large']),
  fullWidth: PropTypes.bool,
  onClick: PropTypes.func,
};

Button.defaultProps = {
  variant: 'contained',
  children: '',
  color: 'youtubeRed',
  size: 'small',
  fullWidth: false,
  onClick: null,
};

export default Button;