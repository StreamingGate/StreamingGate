import React, { useContext } from 'react';

import S from './Header.style';
import { HeaderContext, MainLayoutContext } from '@utils/context';

import { IconButton } from '@components/buttons';
import { HamburgerBar, AddEmptyCircle, Alarm, Search } from '@components/cores';
import SearchForm from './SearchForm';

function BaseHeader() {
  const { onToggle } = useContext(HeaderContext);
  const { onToggleSideNav } = useContext(MainLayoutContext);

  return (
    <>
      <S.HeaderLeftDiv>
        <S.HambergurIconButton onClick={onToggleSideNav}>
          <HamburgerBar />
        </S.HambergurIconButton>
        <S.VerticalLogo />
      </S.HeaderLeftDiv>
      <SearchForm />
      <S.HeaderRightDiv>
        <S.SearchBarIconButton onClick={onToggle}>
          <Search />
        </S.SearchBarIconButton>
        <IconButton>
          <AddEmptyCircle />
        </IconButton>
        <IconButton>
          <Alarm />
        </IconButton>
        <S.HeaderAvatar />
      </S.HeaderRightDiv>
    </>
  );
}

export default BaseHeader;