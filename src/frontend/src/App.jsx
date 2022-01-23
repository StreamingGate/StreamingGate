import React from 'react';
import { ThemeProvider } from 'styled-components';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { QueryClientProvider, QueryClient } from 'react-query';
import { ReactQueryDevtools } from 'react-query/devtools';

import { theme } from '@utils/constant';
import { modalService } from '@utils/service';

import { GlobalStyle, NormalizeStyle } from '@components/styles';
import { MainLayout } from '@components/layouts';
import LoginPage from '@pages/Login';
import RegisterPage from '@pages/Register';
import HomePage from '@pages/Home';
import VideoPlayPage from '@pages/VideoPlay';
import ChannelPage from '@pages/Channel';
import MyPage from '@pages/My';

const queryClient = new QueryClient();

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <ThemeProvider theme={theme}>
        <GlobalStyle />
        <NormalizeStyle />
        <modalService.Provider>
          <Router>
            <Routes>
              <Route path='/' element={<Navigate to='/login' />} />
              <Route path='/login' element={<LoginPage />} />
              <Route path='/register' element={<RegisterPage />} />
              <Route path='*' element={<MainLayout />}>
                <Route path='home' element={<HomePage />} />
                <Route path='video-play/:id' element={<VideoPlayPage />} />
                <Route path='channel/:id' element={<ChannelPage />} />
                <Route path='mypage/:type' element={<MyPage />} />
              </Route>
            </Routes>
          </Router>
        </modalService.Provider>
      </ThemeProvider>
      <ReactQueryDevtools initialIsOpen={false} position='bottom-right' />
    </QueryClientProvider>
  );
}

export default App;
