
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png"
      href="${pageContext.request.contextPath}/assets/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard — Flavora</title>

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
  position: fixed;
  top: 0; left: 0;
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
  position: fixed;
  top: 0; left: 0;
  pointer-events: none;
  z-index: 9999;
  transform: translate(-50%,-50%);
  transition: transform 0.1s ease;
}
.cursor-ring {
  width: 36px; height: 36px;
  border: 1.5px solid var(--orange);
  border-radius: 50%;
  position: fixed;
  top: 0; left: 0;
  pointer-events: none;
  z-index: 9998;
  transform: translate(-50%,-50%);
  transition: transform 0.12s ease, width 0.2s ease, height 0.2s ease, opacity 0.2s ease;
}

/* nav */
.nav {
  position: fixed;
  top: 0; left: 0; right: 0;
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 40px;
  height: 68px;
  background: rgba(245,240,232,0.88);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  border-bottom: 1px solid rgba(26,18,8,0.08);
  transition: background 0.4s;
}
.nav.dark-bg {
  background: rgba(26,18,8,0.92);
  border-bottom-color: rgba(255,255,255,0.08);
}
.nav-logo {
  font-family: var(--font-display);
  font-size: 26px;
  letter-spacing: 0.08em;
  color: var(--dark);
  line-height: 1;
  transition: color 0.4s;
}
.nav.dark-bg .nav-logo { color: var(--white); }
.nav-logo span {
  font-family: var(--font-script);
  font-size: 13px;
  display: block;
  color: var(--orange);
  letter-spacing: 0.04em;
  margin-top: -4px;
  font-style: italic;
}
.nav-links { display: flex; align-items: center; gap: 6px; }
.nav-links .btnn {
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--dark);
  padding: 9px 18px;
  border-radius: 40px;
  border: 1.5px solid transparent;
  transition: all 0.22s ease;
}
.nav.dark-bg .nav-links .btnn { color: rgba(255,255,255,0.75); }
.nav-links .btnn:hover {
  border-color: var(--orange);
  color: var(--orange);
}
.nav-links .btnn.primary {
  background: var(--dark);
  color: var(--white);
  border-color: var(--dark);
}
.nav.dark-bg .nav-links .btnn.primary {
  background: var(--orange);
  border-color: var(--orange);
  color: var(--white);
}
.nav-links .btnn.primary:hover {
  background: var(--orange);
  border-color: var(--orange);
}

/* ─── HAMBURGER ─── */
.hamburger {
  display: none;
  background: none; border: none; cursor: pointer;
  padding: 8px; z-index: 10001;
  flex-direction: column; gap: 5px;
}
.hamburger span {
  display: block;
  width: 22px; height: 2px;
  background: var(--dark);
  border-radius: 2px;
  transition: all 0.3s ease;
}
.nav.dark-bg .hamburger span { background: var(--white); }
.hamburger.active span:nth-child(1) { transform: rotate(45deg) translate(5px, 5px); }
.hamburger.active span:nth-child(2) { opacity: 0; }
.hamburger.active span:nth-child(3) { transform: rotate(-45deg) translate(5px, -5px); }

.mobile-menu {
  display: none;
  position: fixed; top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(245,240,232,0.98);
  backdrop-filter: blur(20px);
  z-index: 9999;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 12px;
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.35s ease;
}
.mobile-menu.open {
  opacity: 1;
  pointer-events: auto;
}
.mobile-menu .btnn {
  font-family: var(--font-body);
  font-size: 14px; font-weight: 500;
  letter-spacing: 0.16em; text-transform: uppercase;
  color: var(--dark);
  padding: 14px 28px;
  border-radius: 40px;
  border: 1.5px solid transparent;
  transition: all 0.22s ease;
  cursor: pointer;
  background: none;
  text-decoration: none;
  display: block;
  text-align: center;
  min-width: 200px;
}
.mobile-menu .btnn.primary { background: var(--dark); color: var(--white); border-color: var(--dark); }
.mobile-menu .btnn:hover { border-color: var(--orange); color: var(--orange); }
.mobile-menu .btnn.primary:hover { background: var(--orange); border-color: var(--orange); }

@media (max-width: 767px) {
  .hamburger { display: flex; }
  .nav-links { display: none; }
  .mobile-menu { display: flex; }
}

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
.delay-3 { transition-delay: 0.18s; }
.delay-4 { transition-delay: 0.24s; }

/* ═══════════════════════════════════════════
   DASHBOARD SPECIFIC
   ════════════════════════════════════════════ */

.dash-page {
  padding-top: 68px;
  min-height: 100vh;
  background: var(--cream);
}
.dash-inner {
  max-width: 1200px;
  margin: 0 auto;
  padding: 60px 48px 100px;
}

/* welcome header */
.dash-header { margin-bottom: 48px; }
.dash-header-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 16px;
}
.dash-greeting {
  font-size: 28px;
  font-weight: 600;
  color: var(--dark);
  line-height: 1.3;
}
.dash-greeting small {
  display: block;
  font-size: 14px;
  font-weight: 400;
  color: rgba(26,18,8,0.45);
  margin-top: 4px;
}
.dash-badge {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  background: rgba(232,93,4,0.08);
  color: var(--orange);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  padding: 8px 18px;
  border-radius: 40px;
  border: 1px solid rgba(232,93,4,0.15);
}

/* stats grid */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
  margin-bottom: 48px;
}
.stat-card {
  background: var(--white);
  border-radius: 12px;
  padding: 24px;
  box-shadow: 0 1px 4px rgba(26,18,8,0.04);
  transition: transform 0.25s ease, box-shadow 0.25s ease;
  position: relative;
  overflow: hidden;
  cursor: default;
  transform-style: preserve-3d;
}
.stat-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 30px rgba(26,18,8,0.08);
}
.stat-card::before {
  content: '';
  position: absolute;
  top: 0; left: 0; right: 0;
  height: 3px;
  background: var(--orange);
}
.stat-card:nth-child(2)::before { background: var(--gold); }
.stat-card:nth-child(3)::before { background: var(--green); }
.stat-card:nth-child(4)::before { background: var(--orange); }
.stat-icon {
  width: 40px; height: 40px;
  border-radius: 10px;
  background: rgba(232,93,4,0.08);
  display: flex; align-items: center; justify-content: center;
  font-size: 18px;
  margin-bottom: 16px;
}
.stat-value {
  font-family: var(--font-display);
  font-size: 36px;
  letter-spacing: 0.04em;
  color: var(--dark);
  line-height: 1;
  margin-bottom: 4px;
}
.stat-label {
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: rgba(26,18,8,0.4);
}

/* quick action cards */
.quick-actions {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
}
.action-card {
  background: var(--white);
  border-radius: 12px;
  padding: 36px;
  box-shadow: 0 1px 4px rgba(26,18,8,0.04);
  display: flex;
  align-items: center;
  gap: 28px;
  text-decoration: none;
  transition: transform 0.25s ease, box-shadow 0.25s ease;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transform-style: preserve-3d;
}
.action-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 40px rgba(26,18,8,0.1);
}
.action-card:active { transform: translateY(-1px); }
.action-card::before {
  content: '';
  position: absolute;
  top: 0; left: -100%;
  width: 100%; height: 100%;
  background: linear-gradient(90deg, transparent, rgba(244,161,36,0.04));
  transition: left 0.4s cubic-bezier(0.25,0.8,0.25,1);
  z-index: 0;
  pointer-events: none;
}
.action-card:hover::before { left: 0; }
.action-icon {
  width: 64px; height: 64px;
  border-radius: 16px;
  background: rgba(232,93,4,0.08);
  display: flex; align-items: center; justify-content: center;
  font-size: 28px;
  flex-shrink: 0;
  position: relative;
  z-index: 1;
}
.action-info { position: relative; z-index: 1; flex: 1; }
.action-info h3 {
  font-size: 18px;
  font-weight: 600;
  color: var(--dark);
  margin-bottom: 4px;
}
.action-info p {
  font-size: 13px;
  color: rgba(26,18,8,0.4);
  margin-bottom: 8px;
  line-height: 1.5;
}
.action-link {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--orange);
  border-bottom: 1px solid transparent;
  transition: border-color 0.2s;
}
.action-link:hover { border-bottom-color: var(--orange); }
.action-card.alt .action-icon { background: rgba(26,18,8,0.05); }
.action-card.alt .action-link { color: var(--dark); }
.action-card.alt:hover .action-link { color: var(--orange); }

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
  font-family: var(--font-body);
  font-size: 11px;
  letter-spacing: 0.1em;
  color: rgba(255,255,255,0.3);
  text-transform: uppercase;
}
.footer-top-link {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-family: var(--font-body);
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
  .dash-inner { padding: 40px 24px 80px; }
  .stats-grid { grid-template-columns: repeat(2, 1fr); }
  .dash-greeting { font-size: 24px; }
  .nav { padding: 0 20px; }
}
@media (max-width: 767px) {
  .dash-inner { padding: 30px 16px 60px; }
  .stats-grid { grid-template-columns: 1fr 1fr; gap: 12px; }
  .stat-card { padding: 18px; }
  .stat-value { font-size: 28px; }
  .stat-icon { width: 36px; height: 36px; font-size: 16px; margin-bottom: 12px; }
  .quick-actions { grid-template-columns: 1fr; }
  .action-card { padding: 24px; gap: 20px; }
  .action-icon { width: 48px; height: 48px; font-size: 22px; }
  .action-info h3 { font-size: 16px; }
  .dash-header { margin-bottom: 28px; }
  .dash-greeting { font-size: 22px; }
  .nav-links .btnn { font-size: 10px; padding: 7px 12px; }
  .footer { padding: 30px 16px; }
  .footer-inner { flex-direction: column; align-items: center; text-align: center; gap: 20px; }
}
@media (max-width: 479px) {
  .dash-inner { padding: 20px 12px 40px; }
  .stats-grid { grid-template-columns: 1fr 1fr; gap: 8px; }
  .stat-card { padding: 14px; }
  .stat-value { font-size: 24px; }
  .stat-icon { width: 30px; height: 30px; font-size: 14px; margin-bottom: 8px; }
  .dash-greeting { font-size: 20px; }
  .action-card { padding: 18px; gap: 16px; }
  .action-icon { width: 40px; height: 40px; font-size: 18px; }
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

<%
User user = (User)session.getAttribute("user");
if(user == null){
    response.sendRedirect("adminLogin.jsp");
    return;
}
if(!"admin".equals(user.getRole())){
    response.sendRedirect("../restaurantServlet");
    return;
}
%>

<!-- scroll progress -->
<div class="scroll-progress" id="scrollProgress"></div>

<!-- custom cursor -->
<div class="cursor-dot" id="cDot"></div>
<div class="cursor-ring" id="cRing"></div>

<!-- nav -->
<nav class="nav" id="mainNav">
  <a href="../restaurantServlet" class="nav-logo">
    FLAVORA
    <span><em>fine food delivery</em></span>
  </a>
  <div class="nav-links buttons">
    <a href="../callOrderHistoryServlet" class="btnn">Order History</a>
    <a href="../cart.jsp"                class="btnn">Cart</a>
    <a href="../restaurantServlet"       class="btnn">Restaurants</a>
    <a href="dashBoard.jsp"              class="btnn primary">Dashboard</a>
  </div>
  <button class="hamburger" id="hamburger" aria-label="Menu">
    <span></span><span></span><span></span>
  </button>
</nav>
<!-- mobile menu overlay -->
<div class="mobile-menu" id="mobileMenu">
  <a href="../callOrderHistoryServlet" class="btnn">Order History</a>
  <a href="../cart.jsp"                class="btnn">Cart</a>
  <a href="../restaurantServlet"       class="btnn">Restaurants</a>
  <a href="dashBoard.jsp"              class="btnn primary">Dashboard</a>
  <a href="adminLogin.html"            class="btnn">Admin Login</a>
  <a href="adminRegister.jsp"          class="btnn">Admin Register</a>
</div>

<!-- dashboard main -->
<div class="dash-page">
  <div class="dash-inner">

    <!-- welcome header -->
    <div class="dash-header scroll-3d">
      <div class="dash-header-top">
        <div>
          <h1 class="dash-greeting">
            Welcome back, <%= user.getUserName() != null ? user.getUserName() : "Admin" %> 👋
            <small>Here's what's happening with Flavora today.</small>
          </h1>
        </div>
        <div class="dash-badge">✦ Admin Panel</div>
      </div>
    </div>

    <!-- stats grid -->
    <div class="stats-grid">
      <div class="stat-card scroll-3d delay-1">
        <div class="stat-icon">📦</div>
        <div class="stat-value">1,284</div>
        <div class="stat-label">Total Orders</div>
      </div>
      <div class="stat-card scroll-3d delay-2">
        <div class="stat-icon">🏪</div>
        <div class="stat-value">48</div>
        <div class="stat-label">Active Restaurants</div>
      </div>
      <div class="stat-card scroll-3d delay-3">
        <div class="stat-icon">💰</div>
        <div class="stat-value">₹12.4k</div>
        <div class="stat-label">Today's Revenue</div>
      </div>
      <div class="stat-card scroll-3d delay-4">
        <div class="stat-icon">👥</div>
        <div class="stat-value">3,567</div>
        <div class="stat-label">Total Users</div>
      </div>
    </div>

    <!-- quick actions -->
    <div class="quick-actions">
      <a href="../callManageRestaurantServlet" class="action-card scroll-3d delay-2" id="actionCard1">
        <div class="action-icon">🏪</div>
        <div class="action-info">
          <h3>Manage Restaurants &amp; Menu</h3>
          <p>Add, edit, or remove restaurant listings and menu items across the platform.</p>
          <span class="action-link">Visit Panel →</span>
        </div>
      </a>
      <a href="<%=request.getContextPath()%>/callLogoutServlet" class="action-card alt scroll-3d delay-3" id="actionCard2">
        <div class="action-icon">🚪</div>
        <div class="action-info">
          <h3>Logout</h3>
          <p>Sign out of your admin session and return to the login page.</p>
          <span class="action-link">Sign Out →</span>
        </div>
      </a>
    </div>

  </div>
</div>

<!-- footer -->
<footer class="footer">
  <div class="footer-bg-word">FLAVORA</div>
  <div class="footer-inner">
    <div class="footer-logo">
      FLAVORA
      <span><em>fine food delivery</em></span>
    </div>
    <div style="text-align:right;">
      <p class="footer-copy" style="margin-bottom:16px;">© 2026 Flavora. All rights reserved.</p>
      <a href="#" class="footer-top-link">Back to top ↑</a>
    </div>
  </div>
</footer>

<script>
/* ── Hamburger menu toggle ── */
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
document.querySelectorAll('a, button, .action-card, .stat-card, .dash-badge').forEach(el => {
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

/* 3D tilt on action cards */
const card1 = document.getElementById('actionCard1');
const card2 = document.getElementById('actionCard2');
[card1, card2].forEach(card => {
  if (card) {
    card.addEventListener('mousemove', e => {
      const rect = card.getBoundingClientRect();
      const cx = rect.left + rect.width / 2;
      const cy = rect.top + rect.height / 2;
      const dx = (e.clientX - cx) / rect.width;
      const dy = (e.clientY - cy) / rect.height;
      card.style.transform =
        `perspective(1000px) rotateX(${dy * -3}deg) rotateY(${dx * 3}deg)`;
      card.style.transition = 'transform 0.08s ease-out';
    });
    card.addEventListener('mouseleave', () => {
      card.style.transform = 'perspective(1000px) rotateX(0) rotateY(0)';
      card.style.transition = 'transform 0.5s cubic-bezier(0.16,1,0.3,1)';
    });
  }
});
</script>

</body>
</html>