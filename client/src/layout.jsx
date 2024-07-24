// src/components/Layout.jsx
import React from 'react';
import NavigationComponent from './components/NavigationComponent';
import { FooterComponent } from './components/FooterComponent';
import DecorComponent from './components/DecorComponent';

const Layout = ({ children }) => {
  return (
    <div className="layout-container">
      <header className="layout-header">
        <NavigationComponent />
        <DecorComponent />
      </header>
      <main className="layout-main p-32 dark:bg-black">
        {children}
      </main>
      <footer className="layout-footer">
        <FooterComponent />
      </footer>
    </div>
  );
};

export default Layout;
