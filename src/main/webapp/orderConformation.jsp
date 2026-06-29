<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Confirmation</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, sans-serif;
}

body{
    background:#f5f5f5;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.container{
    background:#fff;
    padding:40px;
    border-radius:10px;
    text-align:center;
    box-shadow:0 4px 12px rgba(0,0,0,0.15);
    width:400px;
}

.success-icon{
    font-size:60px;
    color:#28a745;
    margin-bottom:20px;
}

h2{
    color:#333;
    margin-bottom:10px;
}

p{
    color:#666;
    margin-bottom:25px;
}

.btn{
    display:inline-block;
    text-decoration:none;
    background:#ff6b35;
    color:#fff;
    padding:12px 25px;
    border-radius:6px;
    transition:0.3s;
}

.btn:hover{
    background:#e85b2d;
}
</style>

</head>
<body>

<div class="container">

    <div class="success-icon">✔</div>

    <h2>Your Order has been Placed Successfully!</h2>

    <p>Thank you for ordering with us.</p>

    <a href="restaurantServlet" class="btn">Back to Restaurants</a>

</div>

</body>
</html> --%>























<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Confirmed — Flavora</title>

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
  min-height: 100vh;
  display: flex;
  flex-direction: column;
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
  pointer-events: none;
  z-index: 9999;
  transform: translate(-50%,-50%);
  transition: transform 0.1s ease;
}
.cursor-ring {
  width: 36px; height: 36px;
  border: 1.5px solid var(--orange);
  border-radius: 50%;
  position: fixed; top: 0; left: 0;
  pointer-events: none;
  z-index: 9998;
  transform: translate(-50%,-50%);
  transition: transform 0.12s ease, width 0.2s ease, height 0.2s ease, opacity 0.2s ease;
}

/* nav */
.nav {
  position: fixed; top: 0; left: 0; right: 0;
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
.nav.dark-bg { background: rgba(26,18,8,0.92); border-bottom-color: rgba(255,255,255,0.08); }
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
.nav-links .btnn:hover { border-color: var(--orange); color: var(--orange); }
.nav-links .btnn.primary { background: var(--dark); color: var(--white); border-color: var(--dark); }
.nav.dark-bg .nav-links .btnn.primary { background: var(--orange); border-color: var(--orange); color: var(--white); }
.nav-links .btnn.primary:hover { background: var(--orange); border-color: var(--orange); }

/* confirmation section */
.confirm-section {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 100px 24px 60px;
}

/* card */
.confirm-card {
  max-width: 480px;
  width: 100%;
  background: var(--white);
  border-radius: 4px;
  padding: 50px 40px 44px;
  text-align: center;
  box-shadow: -8px 14px 44px rgba(26,18,8,0.08);
  position: relative;
  overflow: hidden;
}

/* animated checkmark */
.checkmark-wrap {
  width: 80px;
  height: 80px;
  margin: 0 auto 24px;
  position: relative;
}
.checkmark-circle {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: var(--green);
  display: flex;
  align-items: center;
  justify-content: center;
  animation: popIn 0.6s cubic-bezier(0.16,1,0.3,1) forwards;
  transform: scale(0);
}
@keyframes popIn {
  0%   { transform: scale(0); }
  70%  { transform: scale(1.1); }
  100% { transform: scale(1); }
}
.checkmark-circle svg {
  width: 38px;
  height: 38px;
  stroke: var(--white);
  stroke-width: 3;
  fill: none;
  stroke-linecap: round;
  stroke-linejoin: round;
  stroke-dasharray: 50;
  stroke-dashoffset: 50;
  animation: drawCheck 0.45s 0.4s ease forwards;
}
@keyframes drawCheck {
  to { stroke-dashoffset: 0; }
}

/* ring wave */
.checkmark-wrap::after {
  content: '';
  position: absolute;
  top: 0; left: 0;
  width: 100%; height: 100%;
  border-radius: 50%;
  border: 2px solid var(--green);
  animation: ringExpand 1.2s 0.6s ease-out infinite;
}
@keyframes ringExpand {
  0%   { transform: scale(1); opacity: 0.6; }
  100% { transform: scale(1.6); opacity: 0; }
}

.confirm-card h2 {
  font-family: var(--font-display);
  font-size: 34px;
  letter-spacing: 0.02em;
  color: var(--dark);
  line-height: 1.1;
  margin-bottom: 10px;
  opacity: 0;
  animation: fadeUp 0.7s 0.5s cubic-bezier(0.16,1,0.3,1) forwards;
}
.confirm-card .sub {
  font-family: var(--font-body);
  font-size: 13px;
  line-height: 1.7;
  color: rgba(26,18,8,0.5);
  margin-bottom: 32px;
  opacity: 0;
  animation: fadeUp 0.7s 0.65s cubic-bezier(0.16,1,0.3,1) forwards;
}
@keyframes fadeUp {
  to { opacity: 1; transform: translateY(0); }
}
.confirm-card h2, .confirm-card .sub {
  transform: translateY(16px);
}

/* CTA */
.confirm-btn {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  background: var(--dark);
  color: var(--white);
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  padding: 14px 32px;
  border-radius: 40px;
  transition: background 0.25s, gap 0.2s;
  opacity: 0;
  animation: fadeUp 0.7s 0.8s cubic-bezier(0.16,1,0.3,1) forwards;
  transform: translateY(16px);
}
.confirm-btn:hover {
  background: var(--orange);
  gap: 16px;
}

/* floating dots celebration */
.floating-dot {
  position: absolute;
  width: 6px;
  height: 6px;
  border-radius: 50%;
  pointer-events: none;
  opacity: 0;
  animation: dotFloat 2.5s ease-out infinite;
}
.floating-dot:nth-child(1) { top: 10%; left: 8%; background: var(--orange); animation-delay: 0.2s; width: 8px; height: 8px; }
.floating-dot:nth-child(2) { top: 8%; right: 12%; background: var(--gold); animation-delay: 0.6s; }
.floating-dot:nth-child(3) { bottom: 15%; left: 10%; background: var(--green); animation-delay: 1s; width: 5px; height: 5px; }
.floating-dot:nth-child(4) { bottom: 12%; right: 8%; background: var(--orange); animation-delay: 1.4s; width: 7px; height: 7px; }
.floating-dot:nth-child(5) { top: 40%; left: 5%; background: var(--gold); animation-delay: 0.8s; width: 4px; height: 4px; }
.floating-dot:nth-child(6) { top: 45%; right: 5%; background: var(--green); animation-delay: 1.6s; }
@keyframes dotFloat {
  0%   { opacity: 0; transform: translateY(0) scale(0); }
  20%  { opacity: 0.5; transform: translateY(-10px) scale(1); }
  80%  { opacity: 0.2; transform: translateY(-30px) scale(0.6); }
  100% { opacity: 0; transform: translateY(-40px) scale(0); }
}

/* footer */
.footer {
  background: var(--dark);
  padding: 40px 48px;
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
  align-items: center;
  flex-wrap: wrap;
  gap: 20px;
  position: relative;
  z-index: 1;
}
.footer-logo {
  font-family: var(--font-display);
  font-size: 36px;
  letter-spacing: 0.06em;
  color: var(--white);
  line-height: 0.9;
}
.footer-logo span {
  display: block;
  font-family: var(--font-script);
  font-size: 14px;
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

@media (max-width: 600px) {
  .confirm-card { padding: 40px 24px 36px; }
  .confirm-card h2 { font-size: 28px; }
  .nav { padding: 0 20px; }
  .confirm-section { padding: 80px 16px 40px; }
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
  <a href="restaurantServlet" class="nav-logo">
    FLAVORA
    <span><em>fine food delivery</em></span>
  </a>
  <div class="nav-links buttons">
    <a href="callOrderHistoryServlet" class="btnn">Order History</a>
    <a href="cart.jsp"                class="btnn">Cart</a>
    <a href="register.html"           class="btnn">Sign Up</a>
    <a href="login.html"              class="btnn primary">Login</a>
  </div>
</nav>

<!-- main -->
<section class="confirm-section">
  <div class="confirm-card">
    <div class="floating-dot"></div>
    <div class="floating-dot"></div>
    <div class="floating-dot"></div>
    <div class="floating-dot"></div>
    <div class="floating-dot"></div>
    <div class="floating-dot"></div>

    <div class="checkmark-wrap">
      <div class="checkmark-circle">
        <svg viewBox="0 0 24 24">
          <polyline points="4 13 9 18 20 6" />
        </svg>
      </div>
    </div>

    <h2>Your Order has been Placed Successfully!</h2>
    <p class="sub">Thank you for ordering with us.</p>
    <a href="restaurantServlet" class="confirm-btn"><span>Back to Restaurants →</span></a>
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
    <p class="footer-copy">© 2025 Flavora. All rights reserved.</p>
  </div>
</footer>

<script>
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
document.querySelectorAll('a, button, .confirm-btn').forEach(el => {
  el.addEventListener('mouseenter', () => {
    ring.style.width = '56px'; ring.style.height = '56px'; ring.style.opacity = '0.5';
  });
  el.addEventListener('mouseleave', () => {
    ring.style.width = '36px'; ring.style.height = '36px'; ring.style.opacity = '1';
  });
});

/* nav dark toggle */
const nav = document.getElementById('mainNav');
window.addEventListener('scroll', () => {
  nav.classList.toggle('dark-bg', window.scrollY > 80);
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
