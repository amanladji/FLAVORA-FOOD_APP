<%-- 

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Profile — Flavora</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Caveat:wght@400;600&family=Inter:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400&display=swap" rel="stylesheet">

<style>
:root {
  --cream:   #f5f0e8;
  --dark:    #1a1208;
  --orange:  #e85d04;
  --gold:    #f4a124;
  --green:   #2d5016;
  --white:   #ffffff;
  --font-display: 'Bebas Neue', sans-serif;
  --font-script:  'Caveat', cursive;
  --font-body:    'Inter', sans-serif;
}
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; }
body {
  font-family: var(--font-body);
  background: var(--cream);
  color: var(--dark);
  overflow-x: hidden;
  cursor: default;
}
a { text-decoration: none; color: inherit; }

/* scroll progress */
.scroll-progress {
  position: fixed; top: 0; left: 0;
  height: 3px;
  background: linear-gradient(90deg, var(--orange), var(--gold));
  z-index: 10001;
  width: 0%;
  transition: width 0.1s linear;
}

/* custom cursor */
.cursor-dot {
  width: 8px; height: 8px;
  background: var(--orange);
  border-radius: 50%;
  position: fixed; top: 0; left: 0;
  pointer-events: none; z-index: 9999;
  transform: translate(-50%,-50%);
}
.cursor-ring {
  width: 36px; height: 36px;
  border: 1.5px solid var(--orange);
  border-radius: 50%;
  position: fixed; top: 0; left: 0;
  pointer-events: none; z-index: 9998;
  transform: translate(-50%,-50%);
  transition: width 0.2s ease, height 0.2s ease, opacity 0.2s ease;
}

/* nav */
.nav {
  position: fixed; top: 0; left: 0; right: 0;
  z-index: 1000;
  display: flex; align-items: center;
  justify-content: space-between;
  padding: 0 40px; height: 68px;
  background: rgba(245,240,232,0.88);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  border-bottom: 1px solid rgba(26,18,8,0.08);
  transition: background 0.4s;
}
.nav.dark-bg { background: rgba(26,18,8,0.92); border-bottom-color: rgba(255,255,255,0.08); }
.nav-logo {
  font-family: var(--font-display);
  font-size: 26px; letter-spacing: 0.08em;
  color: var(--dark); line-height: 1;
  transition: color 0.4s;
}
.nav.dark-bg .nav-logo { color: var(--white); }
.nav-logo span {
  font-family: var(--font-script);
  font-size: 13px; display: block;
  color: var(--orange); letter-spacing: 0.04em;
  margin-top: -4px; font-style: italic;
}
.nav-links { display: flex; align-items: center; gap: 6px; }
.nav-links .btnn {
  font-family: var(--font-body);
  font-size: 11px; font-weight: 500;
  letter-spacing: 0.16em; text-transform: uppercase;
  color: var(--dark);
  padding: 9px 18px; border-radius: 40px;
  border: 1.5px solid transparent;
  transition: all 0.22s ease;
}
.nav.dark-bg .nav-links .btnn { color: rgba(255,255,255,0.75); }
.nav-links .btnn:hover { border-color: var(--orange); color: var(--orange); }
.nav-links .btnn.primary { background: var(--dark); color: var(--white); border-color: var(--dark); }
.nav.dark-bg .nav-links .btnn.primary { background: var(--orange); border-color: var(--orange); color: var(--white); }
.nav-links .btnn.primary:hover { background: var(--orange); border-color: var(--orange); }

/* hamburger */
.hamburger {
  display: none; background: none; border: none; cursor: pointer;
  padding: 8px; z-index: 10001;
  flex-direction: column; gap: 5px;
}
.hamburger span {
  display: block; width: 22px; height: 2px;
  background: var(--dark); border-radius: 2px;
  transition: all 0.3s ease;
}
.nav.dark-bg .hamburger span { background: var(--white); }
.hamburger.active span:nth-child(1) { transform: rotate(45deg) translate(5px,5px); }
.hamburger.active span:nth-child(2) { opacity: 0; }
.hamburger.active span:nth-child(3) { transform: rotate(-45deg) translate(5px,-5px); }

.mobile-menu {
  display: none;
  position: fixed; top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(245,240,232,0.98);
  backdrop-filter: blur(20px); z-index: 9999;
  flex-direction: column; align-items: center;
  justify-content: center; gap: 12px;
  opacity: 0; pointer-events: none;
  transition: opacity 0.35s ease;
}
.mobile-menu.open { opacity: 1; pointer-events: auto; }
.mobile-menu .btnn {
  font-family: var(--font-body);
  font-size: 14px; font-weight: 500;
  letter-spacing: 0.16em; text-transform: uppercase;
  color: var(--dark);
  padding: 14px 28px; border-radius: 40px;
  border: 1.5px solid transparent;
  transition: all 0.22s ease;
  cursor: pointer; background: none;
  text-decoration: none; display: block;
  text-align: center; min-width: 200px;
}
.mobile-menu .btnn.primary { background: var(--dark); color: var(--white); border-color: var(--dark); }
.mobile-menu .btnn:hover { border-color: var(--orange); color: var(--orange); }
.mobile-menu .btnn.primary:hover { background: var(--orange); border-color: var(--orange); }

@media (max-width: 767px) {
  .hamburger { display: flex; }
  .nav-links { display: none; }
  .mobile-menu { display: flex; }
}

/* ═══════════════════════════════════════════
   PROFILE SPECIFIC
   ════════════════════════════════════════════ */

.profile-page {
  padding-top: 68px;
  min-height: 100vh;
  background: var(--cream);
}
.profile-inner {
  max-width: 720px;
  margin: 0 auto;
  padding: 60px 48px 100px;
}

/* page header */
.page-header {
  margin-bottom: 40px;
}
.page-header h1 {
  font-family: var(--font-display);
  font-size: clamp(40px, 5vw, 64px);
  letter-spacing: 0.04em;
  color: var(--dark);
  line-height: 0.9;
}
.page-header p {
  font-size: 14px;
  color: rgba(26,18,8,0.45);
  margin-top: 8px;
}

/* profile card */
.profile-card {
  background: var(--white);
  border-radius: 4px;
  padding: 40px 44px;
  box-shadow: -6px 10px 30px rgba(26,18,8,0.06);
}
.profile-card .section-title {
  font-family: var(--font-display);
  font-size: 28px;
  letter-spacing: 0.04em;
  color: var(--orange);
  line-height: 1;
  margin-bottom: 24px;
}
.profile-card .section + .section {
  margin-top: 36px;
  padding-top: 36px;
  border-top: 1px solid rgba(26,18,8,0.06);
}

/* form grid */
.form-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px 28px;
}
.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
}
.form-group.full-width {
  grid-column: 1 / -1;
}
.form-group label {
  font-size: 10px;
  font-weight: 600;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: rgba(26,18,8,0.5);
}
.form-group input,
.form-group textarea {
  width: 100%;
  padding: 12px 14px;
  border: 1.5px solid rgba(26,18,8,0.08);
  border-radius: 4px;
  font-family: var(--font-body);
  font-size: 14px;
  color: var(--dark);
  background: var(--cream);
  outline: none;
  transition: border-color 0.2s, box-shadow 0.2s, background 0.2s;
}
.form-group textarea {
  resize: vertical;
  min-height: 80px;
}
.form-group:focus-within input,
.form-group:focus-within textarea {
  border-color: var(--orange);
  box-shadow: 0 0 0 3px rgba(232,93,4,0.08);
  background: var(--white);
}
.form-actions {
  margin-top: 28px;
  display: flex;
  justify-content: flex-end;
}
.form-actions button {
  font-family: var(--font-body);
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--white);
  background: var(--dark);
  border: none;
  padding: 14px 40px;
  border-radius: 2px;
  cursor: pointer;
  transition: background 0.25s;
}
.form-actions button:hover {
  background: var(--orange);
}

/* footer */
.footer {
  background: var(--dark);
  padding: 60px 48px 40px;
  position: relative;
  overflow: hidden;
}
.footer-bg-word {
  position: absolute;
  font-family: var(--font-display);
  font-size: clamp(80px, 14vw, 180px);
  color: rgba(255,255,255,0.03);
  bottom: -10px; left: 0; right: 0;
  text-align: center;
  letter-spacing: 0.06em;
  pointer-events: none;
}
.footer-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  flex-wrap: wrap;
  gap: 30px;
  position: relative;
  z-index: 1;
}
.footer-logo {
  font-family: var(--font-display);
  font-size: 48px;
  letter-spacing: 0.06em;
  color: var(--white);
  line-height: 0.9;
}
.footer-logo span {
  display: block;
  font-family: var(--font-script);
  font-size: 18px;
  color: var(--gold);
  font-style: italic;
  letter-spacing: 0.04em;
  margin-top: 4px;
}
.footer-copy {
  font-size: 11px;
  letter-spacing: 0.1em;
  color: rgba(255,255,255,0.3);
  text-transform: uppercase;
}
.footer-top-link {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--gold);
  border: 1px solid rgba(244,161,36,0.3);
  padding: 10px 22px;
  border-radius: 40px;
  transition: all 0.25s;
}
.footer-top-link:hover {
  background: var(--gold);
  color: var(--dark);
  border-color: var(--gold);
}

/* responsive */
@media (max-width: 1023px) {
  .profile-inner { padding: 40px 24px 80px; }
  .profile-card { padding: 32px 28px; }
  .nav { padding: 0 20px; }
}
@media (max-width: 767px) {
  .profile-inner { padding: 30px 16px 60px; }
  .profile-card { padding: 24px 20px; }
  .profile-card .section-title { font-size: 24px; }
  .form-grid { grid-template-columns: 1fr; }
  .form-actions button { width: 100%; }
  .footer { padding: 30px 16px; }
  .footer-inner { flex-direction: column; align-items: center; text-align: center; gap: 20px; }
}
@media (max-width: 479px) {
  .profile-inner { padding: 20px 12px 40px; }
  .profile-card { padding: 18px 14px; }
  .profile-card .section-title { font-size: 20px; }
  .nav { padding: 0 12px; height: 56px; }
  .nav-logo { font-size: 20px; }
  .nav-logo span { font-size: 11px; }
}
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
</style>
</head>
<body>

<% User user = (User)request.getAttribute("user"); %>

<!-- scroll progress -->
<div class="scroll-progress" id="scrollProgress"></div>

<!-- custom cursor -->
<div class="cursor-dot" id="cDot"></div>
<div class="cursor-ring" id="cRing"></div>

<!-- nav -->
<nav class="nav" id="mainNav">
  <a href="restaurantServlet" class="nav-logo">
    FLAVORA
    <span><em>fine food delivery</em></span>
  </a>
  <div class="nav-links buttons">
    <a href="callOrderHistoryServlet" class="btnn">Order History</a>
    <a href="cart.jsp"                class="btnn">Cart</a>
    <a href="restaurantServlet"       class="btnn">Restaurants</a>
  </div>
  <button class="hamburger" id="hamburger" aria-label="Menu">
    <span></span><span></span><span></span>
  </button>
</nav>
<!-- mobile menu overlay -->
<div class="mobile-menu" id="mobileMenu">
  <a href="callOrderHistoryServlet" class="btnn">Order History</a>
  <a href="cart.jsp"                class="btnn">Cart</a>
  <a href="restaurantServlet"       class="btnn">Restaurants</a>
</div>

<% if (user != null) { %>

<!-- profile main -->
<div class="profile-page">
  <div class="profile-inner">

    <!-- page header -->
    <div class="page-header">
      <h1>My Profile</h1>
      <p>Manage your personal information and password.</p>
    </div>

    <!-- profile card -->
    <div class="profile-card">
      <form action="callProfileServlet" method="post">

        <input type="hidden" name="userId" value="<%= user.getUserId() %>">
        <input type="hidden" name="DBPassword" value="<%= user.getPassword() %>">

        <!-- personal info section -->
        <div class="section">
          <div class="section-title">Personal Information</div>
          <div class="form-grid">
            <div class="form-group full-width">
              <label>Name</label>
              <input type="text" name="userName" value="<%= user.getUserName() %>">
            </div>
            <div class="form-group full-width">
              <label>Email</label>
              <input type="text" name="email" value="<%= user.getEmail() %>">
            </div>
            <div class="form-group full-width">
              <label>Address</label>
              <textarea name="address" rows="3"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
            </div>
          </div>
        </div>

        <!-- password section -->
        <div class="section">
          <div class="section-title">Change Password</div>
          <div class="form-grid">
            <div class="form-group full-width">
              <label>Old Password</label>
              <input type="password" name="oldPassword" placeholder="Enter current password" required>
            </div>
            <div class="form-group full-width">
              <label>New Password</label>
              <input type="password" name="newPassword" placeholder="Enter new password" required>
            </div>
          </div>
        </div>

        <div class="form-actions">
          <button type="submit">Update</button>
        </div>
      </form>
    </div>

  </div>
</div>

<% } %>

<!-- footer -->
<footer class="footer">
  <div class="footer-bg-word">FLAVORA</div>
  <div class="footer-inner">
    <div class="footer-logo">
      FLAVORA
      <span><em>fine food delivery</em></span>
    </div>
    <div style="text-align:right;">
      <p class="footer-copy" style="margin-bottom:16px;">&copy; 2025 Flavora. All rights reserved.</p>
      <a href="#" class="footer-top-link">Back to top &uarr;</a>
    </div>
  </div>
</footer>

<script>
/* hamburger toggle */
const hamburger = document.getElementById('hamburger');
const mobileMenu = document.getElementById('mobileMenu');
if (hamburger && mobileMenu) {
  hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('active');
    mobileMenu.classList.toggle('open');
    document.body.style.overflow = mobileMenu.classList.contains('open') ? 'hidden' : '';
  });
  mobileMenu.querySelectorAll('.btnn').forEach(link => {
    link.addEventListener('click', () => {
      hamburger.classList.remove('active');
      mobileMenu.classList.remove('open');
      document.body.style.overflow = '';
    });
  });
}

/* custom cursor */
const dot  = document.getElementById('cDot');
const ring = document.getElementById('cRing');
let mx = 0, my = 0, rx = 0, ry = 0;
document.addEventListener('mousemove', e => { mx = e.clientX; my = e.clientY; });
(function animCursor() {
  rx += (mx - rx) * 0.12;
  ry += (my - ry) * 0.12;
  dot.style.left  = mx + 'px';
  dot.style.top   = my + 'px';
  ring.style.left = rx + 'px';
  ring.style.top  = ry + 'px';
  requestAnimationFrame(animCursor);
})();
document.querySelectorAll('a, button, .profile-card').forEach(el => {
  el.addEventListener('mouseenter', () => {
    ring.style.width  = '56px';
    ring.style.height = '56px';
    ring.style.opacity = '0.5';
  });
  el.addEventListener('mouseleave', () => {
    ring.style.width  = '36px';
    ring.style.height = '36px';
    ring.style.opacity = '1';
  });
});

/* nav dark toggle */
const nav = document.getElementById('mainNav');
window.addEventListener('scroll', () => {
  nav.classList.toggle('dark-bg', window.scrollY > window.innerHeight - 80);
}, { passive: true });

/* scroll progress */
const progressBar = document.getElementById('scrollProgress');
window.addEventListener('scroll', () => {
  const scrollTop = window.scrollY;
  const docHeight = document.documentElement.scrollHeight - window.innerHeight;
  const pct = docHeight > 0 ? (scrollTop / docHeight) * 100 : 0;
  progressBar.style.width = pct + '%';
}, { passive: true });
</script>

</body>
</html>
 --%>
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Profile — Flavora</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Caveat:wght@400;600&family=Inter:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400&display=swap" rel="stylesheet">

<style>
:root {
  --cream:   #f5f0e8;
  --dark:    #1a1208;
  --orange:  #e85d04;
  --gold:    #f4a124;
  --green:   #2d5016;
  --white:   #ffffff;
  --font-display: 'Bebas Neue', sans-serif;
  --font-script:  'Caveat', cursive;
  --font-body:    'Inter', sans-serif;
}
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; }
body {
  font-family: var(--font-body);
  background: var(--cream);
  color: var(--dark);
  overflow-x: hidden;
  cursor: default;
}
a { text-decoration: none; color: inherit; }

/* scroll progress */
.scroll-progress {
  position: fixed; top: 0; left: 0;
  height: 3px;
  background: linear-gradient(90deg, var(--orange), var(--gold));
  z-index: 10001;
  width: 0%;
  transition: width 0.1s linear;
}

/* custom cursor */
.cursor-dot {
  width: 8px; height: 8px;
  background: var(--orange);
  border-radius: 50%;
  position: fixed; top: 0; left: 0;
  pointer-events: none; z-index: 9999;
  transform: translate(-50%,-50%);
}
.cursor-ring {
  width: 36px; height: 36px;
  border: 1.5px solid var(--orange);
  border-radius: 50%;
  position: fixed; top: 0; left: 0;
  pointer-events: none; z-index: 9998;
  transform: translate(-50%,-50%);
  transition: width 0.2s ease, height 0.2s ease, opacity 0.2s ease;
}

/* nav */
.nav {
  position: fixed; top: 0; left: 0; right: 0;
  z-index: 1000;
  display: flex; align-items: center;
  justify-content: space-between;
  padding: 0 40px; height: 68px;
  background: rgba(245,240,232,0.88);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  border-bottom: 1px solid rgba(26,18,8,0.08);
  transition: background 0.4s;
}
.nav.dark-bg { background: rgba(26,18,8,0.92); border-bottom-color: rgba(255,255,255,0.08); }
.nav-logo {
  font-family: var(--font-display);
  font-size: 26px; letter-spacing: 0.08em;
  color: var(--dark); line-height: 1;
  transition: color 0.4s;
}
.nav.dark-bg .nav-logo { color: var(--white); }
.nav-logo span {
  font-family: var(--font-script);
  font-size: 13px; display: block;
  color: var(--orange); letter-spacing: 0.04em;
  margin-top: -4px; font-style: italic;
}
.nav-links { display: flex; align-items: center; gap: 6px; }
.nav-links .btnn {
  font-family: var(--font-body);
  font-size: 11px; font-weight: 500;
  letter-spacing: 0.16em; text-transform: uppercase;
  color: var(--dark);
  padding: 9px 18px; border-radius: 40px;
  border: 1.5px solid transparent;
  transition: all 0.22s ease;
}
.nav.dark-bg .nav-links .btnn { color: rgba(255,255,255,0.75); }
.nav-links .btnn:hover { border-color: var(--orange); color: var(--orange); }
.nav-links .btnn.primary { background: var(--dark); color: var(--white); border-color: var(--dark); }
.nav.dark-bg .nav-links .btnn.primary { background: var(--orange); border-color: var(--orange); color: var(--white); }
.nav-links .btnn.primary:hover { background: var(--orange); border-color: var(--orange); }

/* hamburger */
.hamburger {
  display: none; background: none; border: none; cursor: pointer;
  padding: 8px; z-index: 10001;
  flex-direction: column; gap: 5px;
}
.hamburger span {
  display: block; width: 22px; height: 2px;
  background: var(--dark); border-radius: 2px;
  transition: all 0.3s ease;
}
.nav.dark-bg .hamburger span { background: var(--white); }
.hamburger.active span:nth-child(1) { transform: rotate(45deg) translate(5px,5px); }
.hamburger.active span:nth-child(2) { opacity: 0; }
.hamburger.active span:nth-child(3) { transform: rotate(-45deg) translate(5px,-5px); }

.mobile-menu {
  display: none;
  position: fixed; top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(245,240,232,0.98);
  backdrop-filter: blur(20px); z-index: 9999;
  flex-direction: column; align-items: center;
  justify-content: center; gap: 12px;
  opacity: 0; pointer-events: none;
  transition: opacity 0.35s ease;
}
.mobile-menu.open { opacity: 1; pointer-events: auto; }
.mobile-menu .btnn {
  font-family: var(--font-body);
  font-size: 14px; font-weight: 500;
  letter-spacing: 0.16em; text-transform: uppercase;
  color: var(--dark);
  padding: 14px 28px; border-radius: 40px;
  border: 1.5px solid transparent;
  transition: all 0.22s ease;
  cursor: pointer; background: none;
  text-decoration: none; display: block;
  text-align: center; min-width: 200px;
}
.mobile-menu .btnn.primary { background: var(--dark); color: var(--white); border-color: var(--dark); }
.mobile-menu .btnn:hover { border-color: var(--orange); color: var(--orange); }
.mobile-menu .btnn.primary:hover { background: var(--orange); border-color: var(--orange); }

@media (max-width: 767px) {
  .hamburger { display: flex; }
  .nav-links { display: none; }
  .mobile-menu { display: flex; }
}

/* ═══════════════════════════════════════════
   PROFILE SPECIFIC
   ════════════════════════════════════════════ */

/* hero split */
.hero {
  min-height: 100vh;
  background: var(--cream);
  display: grid;
  grid-template-columns: 1fr 1fr;
  position: relative;
  overflow: hidden;
  padding-top: 68px;
}
.hero-left {
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 0 48px 0 60px;
  position: relative;
  z-index: 2;
}
.hero-word {
  font-family: var(--font-display);
  font-size: clamp(72px, 8vw, 120px);
  line-height: 0.88;
  letter-spacing: 0.02em;
  color: var(--dark);
  opacity: 0;
  transform: translateY(60px);
  animation: wordReveal 0.9s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-word:nth-child(1) { animation-delay: 0.1s; }
.hero-word:nth-child(2) { animation-delay: 0.25s; color: var(--orange); }
@keyframes wordReveal {
  to { opacity: 1; transform: translateY(0); }
}
.hero-tagline {
  font-family: var(--font-body);
  font-size: 13px;
  line-height: 1.7;
  color: rgba(26,18,8,0.55);
  max-width: 320px;
  margin-top: 24px;
  opacity: 0;
  animation: wordReveal 0.8s 0.55s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-right {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px;
  position: relative;
  z-index: 2;
}

/* avatar */
.avatar {
  width: 160px; height: 160px;
  border-radius: 50%;
  background: linear-gradient(135deg, var(--orange), var(--gold));
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: var(--font-display);
  font-size: 64px;
  color: var(--white);
  box-shadow: 0 24px 48px rgba(232,93,4,0.2);
  animation: float 4s ease-in-out infinite;
  margin-bottom: 24px;
}
@keyframes float {
  0%,100% { transform: translateY(0) rotate(-2deg); }
  50%     { transform: translateY(-14px) rotate(2deg); }
}
.role-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--orange);
  background: rgba(232,93,4,0.08);
  border: 1px solid rgba(232,93,4,0.15);
  padding: 8px 18px;
  border-radius: 40px;
}
.hero-emoji {
  position: absolute;
  font-size: clamp(60px, 10vw, 100px);
  bottom: 10%;
  right: 8%;
  animation: float 5s ease-in-out infinite 1s;
  z-index: 0;
  opacity: 0.6;
}

/* floating decor */
.floating-decor {
  position: absolute;
  pointer-events: none;
  z-index: 0;
  font-size: 30px;
  opacity: 0.15;
}
.floating-decor:nth-child(1) { top: 15%; left: 5%; animation: float 6s ease-in-out infinite; }
.floating-decor:nth-child(2) { top: 60%; left: 10%; animation: float 7s ease-in-out infinite 1.5s; }
.floating-decor:nth-child(3) { bottom: 20%; right: 5%; animation: float 5s ease-in-out infinite 0.8s; }

/* profile section */
.profile-section {
  padding: 40px 48px 100px;
  background: var(--cream);
  max-width: 900px;
  margin: 0 auto;
}
.profile-section .section-card {
  background: var(--white);
  border-radius: 4px;
  padding: 36px 40px;
  box-shadow: -6px 10px 30px rgba(26,18,8,0.06);
  margin-bottom: 28px;
}
.profile-section .section-card:last-child {
  margin-bottom: 0;
}
.section-title {
  display: flex;
  align-items: center;
  gap: 10px;
  font-family: var(--font-display);
  font-size: 28px;
  letter-spacing: 0.04em;
  color: var(--orange);
  line-height: 1;
  margin-bottom: 24px;
}
.section-title .icon {
  font-size: 22px;
  font-style: normal;
}

/* form grid */
.form-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px 28px;
}
.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
}
.form-group.full-width {
  grid-column: 1 / -1;
}
.form-group label {
  font-size: 10px;
  font-weight: 600;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: rgba(26,18,8,0.5);
}
.form-group input,
.form-group textarea {
  width: 100%;
  padding: 14px 16px;
  border: 1.5px solid rgba(26,18,8,0.08);
  border-radius: 4px;
  font-family: var(--font-body);
  font-size: 14px;
  color: var(--dark);
  background: var(--cream);
  outline: none;
  transition: border-color 0.25s, box-shadow 0.25s, background 0.25s;
}
.form-group textarea {
  resize: vertical;
  min-height: 80px;
}
.form-group:focus-within input,
.form-group:focus-within textarea {
  border-color: var(--orange);
  box-shadow: 0 0 0 3px rgba(232,93,4,0.1);
  background: var(--white);
}

/* password wrapper with eye toggle */
.pwd-wrap {
  position: relative;
}
.pwd-wrap input {
  padding-right: 44px;
}
.pwd-toggle {
  position: absolute;
  right: 12px;
  top: 50%;
  transform: translateY(-50%);
  background: none;
  border: none;
  cursor: pointer;
  font-size: 16px;
  color: rgba(26,18,8,0.3);
  padding: 4px;
  transition: color 0.2s;
  line-height: 1;
}
.pwd-toggle:hover {
  color: var(--orange);
}

.form-actions {
  margin-top: 28px;
  display: flex;
  justify-content: flex-end;
}
.submit-btn {
  position: relative;
  overflow: hidden;
  font-family: var(--font-body);
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--white);
  background: var(--orange);
  border: none;
  padding: 14px 40px;
  border-radius: 2px;
  cursor: pointer;
  z-index: 1;
  transition: color 0.3s ease;
}
.submit-btn::before {
  content: '';
  position: absolute;
  top: 0; left: -100%;
  width: 100%; height: 100%;
  background: var(--dark);
  transition: left 0.35s cubic-bezier(0.25,0.8,0.25,1);
  z-index: -1;
}
.submit-btn:hover::before { left: 0; }

/* 3D reveal */
.scroll-3d {
  opacity: 0;
  transform: perspective(1200px) translateY(50px) rotateX(8deg);
  transform-origin: center top;
  will-change: transform, opacity;
  transition: opacity 0.8s cubic-bezier(0.16,1,0.3,1),
              transform 1s cubic-bezier(0.16,1,0.3,1);
}
.scroll-3d.vis {
  opacity: 1;
  transform: perspective(1200px) translateY(0) rotateX(0);
}
.delay-1 { transition-delay: 0.06s; }
.delay-2 { transition-delay: 0.12s; }

/* footer */
.footer {
  background: var(--dark);
  padding: 60px 48px 40px;
  position: relative;
  overflow: hidden;
}
.footer-bg-word {
  position: absolute;
  font-family: var(--font-display);
  font-size: clamp(80px, 14vw, 180px);
  color: rgba(255,255,255,0.03);
  bottom: -10px; left: 0; right: 0;
  text-align: center;
  letter-spacing: 0.06em;
  pointer-events: none;
}
.footer-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  flex-wrap: wrap;
  gap: 30px;
  position: relative;
  z-index: 1;
}
.footer-logo {
  font-family: var(--font-display);
  font-size: 48px;
  letter-spacing: 0.06em;
  color: var(--white);
  line-height: 0.9;
}
.footer-logo span {
  display: block;
  font-family: var(--font-script);
  font-size: 18px;
  color: var(--gold);
  font-style: italic;
  letter-spacing: 0.04em;
  margin-top: 4px;
}
.footer-copy {
  font-size: 11px;
  letter-spacing: 0.1em;
  color: rgba(255,255,255,0.3);
  text-transform: uppercase;
}
.footer-top-link {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--gold);
  border: 1px solid rgba(244,161,36,0.3);
  padding: 10px 22px;
  border-radius: 40px;
  transition: all 0.25s;
}
.footer-top-link:hover {
  background: var(--gold);
  color: var(--dark);
  border-color: var(--gold);
}

/* responsive */
@media (max-width: 1023px) {
  .hero-left { padding: 0 32px 0 40px; }
  .profile-section { padding: 30px 24px 80px; }
  .profile-section .section-card { padding: 28px 24px; }
  .nav { padding: 0 20px; }
}
@media (max-width: 767px) {
  .hero { grid-template-columns: 1fr; min-height: auto; padding-top: 68px; }
  .hero-left { padding: 60px 24px 20px; }
  .hero-right { padding: 20px 24px 60px; }
  .avatar { width: 120px; height: 120px; font-size: 48px; }
  .hero-word { font-size: clamp(48px, 12vw, 72px); }
  .profile-section { padding: 20px 16px 60px; }
  .profile-section .section-card { padding: 24px 18px; }
  .section-title { font-size: 24px; }
  .form-grid { grid-template-columns: 1fr; }
  .submit-btn { width: 100%; }
  .form-actions { flex-direction: column; }
  .footer { padding: 30px 16px; }
  .footer-inner { flex-direction: column; align-items: center; text-align: center; gap: 20px; }
}
@media (max-width: 479px) {
  .hero-left { padding: 40px 16px 20px; }
  .hero-right { padding: 10px 16px 40px; }
  .avatar { width: 100px; height: 100px; font-size: 40px; }
  .profile-section .section-card { padding: 18px 14px; }
  .section-title { font-size: 20px; }
  .nav { padding: 0 12px; height: 56px; }
  .nav-logo { font-size: 20px; }
  .nav-logo span { font-size: 11px; }
}
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
</style>
</head>
<body>

<% User user = (User)request.getAttribute("user"); %>

<!-- scroll progress -->
<div class="scroll-progress" id="scrollProgress"></div>

<!-- custom cursor -->
<div class="cursor-dot" id="cDot"></div>
<div class="cursor-ring" id="cRing"></div>

<!-- nav -->
<nav class="nav" id="mainNav">
  <a href="restaurantServlet" class="nav-logo">
    FLAVORA
    <span><em>fine food delivery</em></span>
  </a>
  <div class="nav-links buttons">
    <a href="callOrderHistoryServlet" class="btnn">Order History</a>
    <a href="cart.jsp"                class="btnn">Cart</a>
    <a href="restaurantServlet"       class="btnn">Restaurants</a>
  </div>
  <button class="hamburger" id="hamburger" aria-label="Menu">
    <span></span><span></span><span></span>
  </button>
</nav>
<!-- mobile menu overlay -->
<div class="mobile-menu" id="mobileMenu">
  <a href="callOrderHistoryServlet" class="btnn">Order History</a>
  <a href="cart.jsp"                class="btnn">Cart</a>
  <a href="restaurantServlet"       class="btnn">Restaurants</a>
</div>

<% if (user != null) { %>

<!-- hero section -->
<div class="hero">
  <div class="floating-decor">🍕</div>
  <div class="floating-decor">🥗</div>
  <div class="floating-decor">🍝</div>
  <div class="hero-left">
    <div class="hero-word">My</div>
    <div class="hero-word">Profile</div>
    <p class="hero-tagline">Manage your personal information and keep your account secure.</p>
  </div>
  <div class="hero-right">
    <div class="avatar"><%= user.getUserName() != null ? user.getUserName().charAt(0) : "U" %></div>
    <span class="role-badge">&#9733; <%= user.getRole() != null ? user.getRole() : "Member" %></span>
    <div class="hero-emoji">&#x1F9D1;&#x200D;&#x1F373;</div>
  </div>
</div>

<!-- profile form section -->
<div class="profile-section">
  <form action="callProfileServlet" method="post">

    <input type="hidden" name="userId" value="<%= user.getUserId() %>">
    <input type="hidden" name="DBPassword" value="<%= user.getPassword() %>">

    <!-- personal info card -->
    <div class="section-card scroll-3d delay-1">
      <div class="section-title"><i class="icon">&#x1F464;</i> Personal Information</div>
      <div class="form-grid">
        <div class="form-group">
          <label>Name</label>
          <input type="text" name="userName" value="<%= user.getUserName() != null ? user.getUserName() : "" %>">
        </div>
        <div class="form-group">
          <label>Email</label>
          <input type="text" name="email" value="<%= user.getEmail() != null ? user.getEmail() : "" %>">
        </div>
        <div class="form-group full-width">
          <label>Address</label>
          <textarea name="address" rows="3"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
        </div>
      </div>
    </div>

    <!-- password card -->
    <div class="section-card scroll-3d delay-2">
      <div class="section-title"><i class="icon">&#x1F512;</i> Security</div>
      <div class="form-grid">
        <div class="form-group full-width">
          <label>Old Password</label>
          <div class="pwd-wrap">
            <input type="password" name="oldPassword" id="oldPwd" placeholder="Enter current password" required>
            <button type="button" class="pwd-toggle" onclick="togglePwd('oldPwd',this)">&#x1F441;</button>
          </div>
        </div>
        <div class="form-group full-width">
          <label>New Password</label>
          <div class="pwd-wrap">
            <input type="password" name="newPassword" id="newPwd" placeholder="Enter new password" required>
            <button type="button" class="pwd-toggle" onclick="togglePwd('newPwd',this)">&#x1F441;</button>
          </div>
        </div>
      </div>
      <div class="form-actions">
        <button type="submit" class="submit-btn">Update</button>
      </div>
    </div>

  </form>
</div>

<% } %>

<!-- footer -->
<footer class="footer">
  <div class="footer-bg-word">FLAVORA</div>
  <div class="footer-inner">
    <div class="footer-logo">
      FLAVORA
      <span><em>fine food delivery</em></span>
    </div>
    <div style="text-align:right;">
      <p class="footer-copy" style="margin-bottom:16px;">&copy; 2025 Flavora. All rights reserved.</p>
      <a href="#" class="footer-top-link">Back to top &uarr;</a>
    </div>
  </div>
</footer>

<script>
/* password toggle */
function togglePwd(id, btn) {
  const f = document.getElementById(id);
  if (f.type === 'password') { f.type = 'text'; btn.innerHTML = '&#x1F441;'; }
  else { f.type = 'password'; btn.innerHTML = '&#x1F441;'; }
}

/* hamburger toggle */
const hamburger = document.getElementById('hamburger');
const mobileMenu = document.getElementById('mobileMenu');
if (hamburger && mobileMenu) {
  hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('active');
    mobileMenu.classList.toggle('open');
    document.body.style.overflow = mobileMenu.classList.contains('open') ? 'hidden' : '';
  });
  mobileMenu.querySelectorAll('.btnn').forEach(link => {
    link.addEventListener('click', () => {
      hamburger.classList.remove('active');
      mobileMenu.classList.remove('open');
      document.body.style.overflow = '';
    });
  });
}

/* custom cursor */
const dot  = document.getElementById('cDot');
const ring = document.getElementById('cRing');
let mx = 0, my = 0, rx = 0, ry = 0;
document.addEventListener('mousemove', e => { mx = e.clientX; my = e.clientY; });
(function animCursor() {
  rx += (mx - rx) * 0.12;
  ry += (my - ry) * 0.12;
  dot.style.left  = mx + 'px';
  dot.style.top   = my + 'px';
  ring.style.left = rx + 'px';
  ring.style.top  = ry + 'px';
  requestAnimationFrame(animCursor);
})();
document.querySelectorAll('a, button, .section-card').forEach(el => {
  el.addEventListener('mouseenter', () => {
    ring.style.width  = '56px';
    ring.style.height = '56px';
    ring.style.opacity = '0.5';
  });
  el.addEventListener('mouseleave', () => {
    ring.style.width  = '36px';
    ring.style.height = '36px';
    ring.style.opacity = '1';
  });
});

/* nav dark toggle */
const nav = document.getElementById('mainNav');
window.addEventListener('scroll', () => {
  nav.classList.toggle('dark-bg', window.scrollY > window.innerHeight - 80);
}, { passive: true });

/* scroll progress */
const progressBar = document.getElementById('scrollProgress');
window.addEventListener('scroll', () => {
  const scrollTop = window.scrollY;
  const docHeight = document.documentElement.scrollHeight - window.innerHeight;
  const pct = docHeight > 0 ? (scrollTop / docHeight) * 100 : 0;
  progressBar.style.width = pct + '%';
}, { passive: true });

/* 3D scroll reveal */
document.querySelectorAll('.scroll-3d').forEach(el => {
  const rect = el.getBoundingClientRect();
  if (rect.top < window.innerHeight - 40) {
    el.classList.add('vis');
  }
});
const observer3d = new IntersectionObserver((entries) => {
  entries.forEach(e => {
    if (e.isIntersecting) {
      e.target.classList.add('vis');
      observer3d.unobserve(e.target);
    }
  });
}, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });
document.querySelectorAll('.scroll-3d:not(.vis)').forEach(el => observer3d.observe(el));
</script>

</body>
</html>
 