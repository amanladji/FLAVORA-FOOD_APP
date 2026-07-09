
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png"
      href="${pageContext.request.contextPath}/assets/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login — Flavora</title>

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

/* left */
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
.hero-word:nth-child(3) { animation-delay: 0.4s; }

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
.hero-hashtag {
  font-family: var(--font-display);
  font-size: clamp(16px, 2vw, 22px);
  letter-spacing: 0.04em;
  color: var(--orange);
  margin-top: 10px;
  opacity: 0;
  animation: wordReveal 0.8s 0.7s cubic-bezier(0.16,1,0.3,1) forwards;
}

/* right */
.hero-right {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 40px;
  position: relative;
  z-index: 2;
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

/* form card */
.login-card {
  background: var(--dark);
  border-radius: 4px;
  padding: 48px 40px 40px;
  width: 100%;
  max-width: 420px;
  box-shadow: -14px 18px 60px rgba(26,18,8,0.25);
  position: relative;
  overflow: hidden;
  transform-style: preserve-3d;
}
.login-card::before {
  content: '';
  position: absolute;
  top: -80px; right: -80px;
  width: 200px; height: 200px;
  background: radial-gradient(circle, rgba(244,161,36,0.12) 0%, transparent 70%);
  border-radius: 50%;
  pointer-events: none;
}
.login-card h2 {
  font-family: var(--font-display);
  font-size: 42px;
  letter-spacing: 0.06em;
  color: var(--white);
  text-transform: uppercase;
  margin-bottom: 4px;
}
.login-card .card-sub {
  font-family: var(--font-script);
  font-size: 16px;
  color: var(--gold);
  font-style: italic;
  margin-bottom: 28px;
}

/* input group */
.input-group {
  margin-bottom: 18px;
  position: relative;
}
.input-group label {
  display: block;
  font-family: var(--font-body);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: rgba(255,255,255,0.45);
  margin-bottom: 6px;
  transition: color 0.3s;
}
.input-group:focus-within label {
  color: var(--orange);
}
.input-group input {
  width: 100%;
  background: rgba(255,255,255,0.06);
  border: none;
  border-bottom: 1.5px solid rgba(255,255,255,0.15);
  border-radius: 0;
  padding: 12px 16px 12px 0;
  font-family: var(--font-body);
  font-size: 14px;
  color: var(--white);
  outline: none;
  transition: background 0.3s, padding 0.3s;
}
.input-group input::placeholder { color: rgba(255,255,255,0.2); font-style: italic; }
.input-group input:focus {
  background: rgba(255,255,255,0.1);
  padding-left: 16px;
}
/* underline */
.input-group::after {
  content: '';
  position: absolute;
  bottom: 0; left: 50%;
  width: 0;
  height: 1.5px;
  background: var(--orange);
  transition: width 0.35s cubic-bezier(0.16,1,0.3,1), left 0.35s cubic-bezier(0.16,1,0.3,1);
}
.input-group:focus-within::after {
  width: 100%;
  left: 0;
}

/* password toggle */
.pw-wrap {
  position: relative;
}
.pw-toggle {
  position: absolute;
  right: 0;
  top: 50%;
  transform: translateY(-50%);
  background: none;
  border: none;
  cursor: pointer;
  padding: 8px;
  color: rgba(255,255,255,0.3);
  transition: color 0.25s;
  z-index: 2;
  line-height: 1;
}
.pw-toggle:hover { color: var(--gold); }
.pw-toggle svg { display: block; }

/* submit button */
.submit-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  width: 100%;
  background: var(--orange);
  color: var(--white);
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  padding: 14px 22px;
  border: none;
  border-radius: 2px;
  cursor: pointer;
  overflow: hidden;
  position: relative;
  margin-top: 8px;
  transition: background 0.25s, gap 0.25s;
}
.submit-btn::before {
  content: '';
  position: absolute;
  top: 0; left: -100%;
  width: 100%; height: 100%;
  background: var(--gold);
  transition: left 0.35s cubic-bezier(0.25,0.8,0.25,1);
  z-index: 0;
}
.submit-btn:hover::before { left: 0; }
.submit-btn span { position: relative; z-index: 1; }
.submit-btn svg { position: relative; z-index: 1; transition: transform 0.25s; }
.submit-btn:hover svg { transform: translateX(5px); }
.submit-btn:active { transform: scale(0.97); }

.submit-btn.loading { pointer-events: none; background: var(--dark); }
.submit-btn.loading::before { display: none; }
.submit-btn.loading .btn-text { display: none; }
.submit-btn.loading .btn-load { display: flex; }
.btn-load { display: none; align-items: center; gap: 10px; position: relative; z-index: 1; }
.spinner {
  width: 14px; height: 14px;
  border: 2px solid rgba(255,255,255,0.25);
  border-top-color: var(--white);
  border-radius: 50%;
  animation: spin 0.6s linear infinite;
}
@keyframes spin { to { transform: rotate(360deg); } }

/* validation */
.input-group.error input { border-bottom-color: #e53935; }
.input-group.error::after { background: #e53935; }
@keyframes shake {
  0%,100% { transform: translateX(0); }
  20%     { transform: translateX(-6px); }
  40%     { transform: translateX(6px); }
  60%     { transform: translateX(-4px); }
  80%     { transform: translateX(4px); }
}
.login-card.shake { animation: shake 0.4s ease; }

/* links */
.login-links {
  text-align: center;
  margin-top: 20px;
  font-family: var(--font-body);
  font-size: 12px;
  color: rgba(255,255,255,0.35);
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.login-links a {
  color: var(--gold);
  font-weight: 500;
  border-bottom: 1px solid transparent;
  transition: border-color 0.2s;
}
.login-links a:hover {
  border-bottom-color: var(--gold);
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
  .hero { grid-template-columns: 1fr; padding-top: 68px; }
  .hero-left { padding: 40px 24px 0; text-align: center; align-items: center; }
  .hero-right { padding: 24px 24px 40px; }
  .login-card { width: 100%; max-width: 420px; margin: 0; }
  .nav { padding: 0 20px; }
}
@media (max-width: 767px) {
  .hero-left { padding: 30px 16px 0; }
  .hero-right { padding: 16px 16px 40px; }
  .login-card { padding: 24px; }
  .login-card h2 { font-size: clamp(28px, 8vw, 42px); }
  .submit-btn { padding: 14px 24px; font-size: 12px; min-height: 48px; }
  .nav-links .btnn { font-size: 10px; padding: 7px 12px; }
  .footer { padding: 30px 16px; }
  .footer-inner { flex-direction: column; align-items: center; text-align: center; gap: 20px; }
}
@media (max-width: 479px) {
  .nav { padding: 0 12px; height: 56px; }
  .nav-logo { font-size: 20px; }
  .nav-logo span { font-size: 11px; }
  .hero-left { padding: 20px 12px 0; }
  .hero-right { padding: 12px 12px 30px; }
  .login-card { padding: 20px; }
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
    <a href="<%=request.getContextPath()%>/callOrderHistoryServlet" class="btnn">Order History</a>
    <a href="<%=request.getContextPath()%>/cart.jsp" class="btnn">Cart</a>
    <a href="<%=request.getContextPath()%>/restaurantServlet" class="btnn">Restaurants</a>
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
  <a href="../adminRegister.jsp"           class="btnn">Admin Sign Up</a>
</div>

<!-- hero -->
<section class="hero">
  <div class="hero-left">
    <div class="hero-word">Access.</div>
    <div class="hero-word">Control.</div>
    <div class="hero-word">Admin.</div>
    <p class="hero-tagline">
      Sign in to manage your dashboard — oversee orders, restaurants, and everything Flavora.
    </p>
    <p class="hero-hashtag">#TasteTheCity</p>
  </div>

  <div class="hero-right">
    <form action="<%=request.getContextPath()%>/callLoginServlet" method="post" class="login-card" id="loginCard" novalidate>
      <h2>Admin Login</h2>
      <p class="card-sub"><em>manage your dashboard</em></p>

      <div class="input-group scroll-3d delay-1">
        <label>Username</label>
        <input type="text" name="userName" placeholder="Enter your username" required>
      </div>

      <div class="input-group scroll-3d delay-2">
        <label>Password</label>
        <div class="pw-wrap">
          <input type="password" name="password" id="pwInput" placeholder="Enter your password" required>
          <button type="button" class="pw-toggle" id="pwToggle" tabindex="-1" aria-label="Toggle password visibility">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
              <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" id="eyePath"/>
              <circle cx="12" cy="12" r="3"/>
            </svg>
          </button>
        </div>
      </div>

      <button type="submit" class="submit-btn scroll-3d delay-3" id="submitBtn">
        <span class="btn-text">Sign In</span>
        <span class="btn-load"><span class="spinner"></span> Signing in...</span>
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="btn-text"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
      </button>

      <div class="login-links scroll-3d delay-4">
        <span>Don't have an account? Register</span>
        <a href="adminRegister.jsp">← register here</a>
      </div>
    </form>
  </div>
</section>

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
document.querySelectorAll('a, button, .submit-btn, input').forEach(el => {
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
const observer3d = new IntersectionObserver((entries) => {
  entries.forEach(e => {
    if (e.isIntersecting) {
      e.target.classList.add('vis');
      observer3d.unobserve(e.target);
    }
  });
}, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });

document.querySelectorAll('.scroll-3d').forEach(el => observer3d.observe(el));

/* 3D tilt on card */
const loginCard = document.querySelector('.login-card');
if (loginCard) {
  loginCard.style.transition = 'transform 0.08s ease-out';
  document.querySelector('.hero-right').addEventListener('mousemove', e => {
    const rect = loginCard.getBoundingClientRect();
    const cx = rect.left + rect.width / 2;
    const cy = rect.top + rect.height / 2;
    const dx = (e.clientX - cx) / rect.width;
    const dy = (e.clientY - cy) / rect.height;
    loginCard.style.transform =
      `perspective(1000px) rotateX(${dy * -4}deg) rotateY(${dx * 4}deg)`;
  });
  document.querySelector('.hero-right').addEventListener('mouseleave', () => {
    loginCard.style.transform = 'perspective(1000px) rotateX(0) rotateY(0)';
    loginCard.style.transition = 'transform 0.5s cubic-bezier(0.16,1,0.3,1)';
  });
}

/* password toggle */
const pwInput = document.getElementById('pwInput');
const pwToggle = document.getElementById('pwToggle');
if (pwToggle && pwInput) {
  pwToggle.addEventListener('click', () => {
    const isPassword = pwInput.type === 'password';
    pwInput.type = isPassword ? 'text' : 'password';
    pwToggle.innerHTML = isPassword
      ? `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
          <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94"/>
          <path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19"/>
          <line x1="1" y1="1" x2="23" y2="23"/>
          <path d="M14.12 14.12a3 3 0 1 1-4.24-4.24"/>
        </svg>`
      : `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
          <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
          <circle cx="12" cy="12" r="3"/>
        </svg>`;
  });
}

/* submit loading + validation */
const form = document.querySelector('.login-card');
const submitBtn = document.getElementById('submitBtn');
if (form) {
  form.addEventListener('submit', function(e) {
    const inputs = form.querySelectorAll('input');
    let valid = true;
    inputs.forEach(inp => {
      const group = inp.closest('.input-group');
      if (group) group.classList.remove('error');
      if (inp.hasAttribute('required') && !inp.value.trim()) {
        valid = false;
        if (group) group.classList.add('error');
      }
    });
    if (!valid) {
      e.preventDefault();
      form.classList.remove('shake');
      void form.offsetWidth;
      form.classList.add('shake');
      return;
    }
    if (submitBtn) {
      submitBtn.classList.add('loading');
      setTimeout(() => { submitBtn.classList.remove('loading'); }, 3000);
    }
  });

  form.querySelectorAll('input').forEach(inp => {
    inp.addEventListener('input', () => {
      const group = inp.closest('.input-group');
      if (group) group.classList.remove('error');
    });
  });
}
</script>

</body>
</html>