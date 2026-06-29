<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List,com.tap.model.Order" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order History</title>

<style>

body{
    font-family:Arial,sans-serif;
    background:#f5f5f5;
    margin:30px;
}

h2{
    text-align:center;
    color:#333;
}

table{
    width:90%;
    margin:auto;
    border-collapse:collapse;
    background:white;
    box-shadow:0 0 10px rgba(0,0,0,.1);
}

th{
    background:#ff6b35;
    color:white;
    padding:12px;
}

td{
    text-align:center;
    padding:12px;
    border-bottom:1px solid #ddd;
}

tr:hover{
    background:#f9f9f9;
}

.back{
    display:block;
    width:180px;
    margin:25px auto;
    text-align:center;
    text-decoration:none;
    background:#ff6b35;
    color:white;
    padding:12px;
    border-radius:6px;
}

</style>

</head>
<body>

<h2>My Order History</h2>

<%

List<Order> historyList = (List<Order>)request.getAttribute("orderHistory");

if(historyList != null && !historyList.isEmpty()){

%>

<table>

<tr>
<th>Order ID</th>
<th>Date</th>
<th>Total Amount</th>
<th>Status</th>
<th>Payment</th>
</tr>

<%

for(Order o : historyList){

%>

<tr>

<td><%=o.getOrderId()%></td>

<td><%=o.getOrderDate()%></td>

<td>₹ <%=o.getTotalAmount()%></td>

<td><%=o.getStatus()%></td>

<td><%=o.getPaymentMethod()%></td>

</tr>

<%
}
%>

</table>

<%

}else{

%>

<h3 style="text-align:center;">No Orders Found</h3>

<%

}

%>

<a href="restaurantServlet" class="back">Back to Restaurants</a>

</body>
</html> --%>























<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List,com.tap.model.Order" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order History — Flavora</title>

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

/* hero */
.hero {
  min-height: 60vh;
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
  font-size: clamp(64px, 7vw, 110px);
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
.hero-right {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 40px;
  position: relative;
  z-index: 2;
}
.hero-right .big-emoji {
  font-size: clamp(100px, 14vw, 180px);
  animation: float 4s ease-in-out infinite;
  filter: drop-shadow(0 24px 48px rgba(232,93,4,0.2));
}
@keyframes float {
  0%,100% { transform: translateY(0) rotate(-3deg); }
  50%      { transform: translateY(-18px) rotate(3deg); }
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

/* table section */
.table-section {
  padding: 60px 48px 80px;
  background: var(--cream);
}
.table-wrap {
  max-width: 1100px;
  margin: 0 auto;
  overflow-x: auto;
  background: var(--white);
  border-radius: 4px;
  box-shadow: -8px 12px 40px rgba(26,18,8,0.08);
}
table {
  width: 100%;
  border-collapse: collapse;
  min-width: 600px;
}
thead th {
  font-family: var(--font-body);
  font-size: 10px;
  font-weight: 600;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: rgba(255,255,255,0.7);
  background: var(--dark);
  padding: 16px 20px;
  text-align: left;
}
thead th:first-child { border-radius: 4px 0 0 0; }
thead th:last-child  { border-radius: 0 4px 0 0; }
tbody td {
  font-family: var(--font-body);
  font-size: 13px;
  color: var(--dark);
  padding: 16px 20px;
  border-bottom: 1px solid rgba(26,18,8,0.06);
}
tbody tr {
  transition: background 0.2s, transform 0.2s;
}
tbody tr:hover {
  background: rgba(232,93,4,0.04);
  transform: scale(1.005);
}
tbody tr:last-child td { border-bottom: none; }

/* status badges */
.status-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  font-size: 11px;
  font-weight: 600;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  padding: 4px 12px;
  border-radius: 40px;
}
.status-badge.delivered {
  background: rgba(45,80,22,0.1);
  color: var(--green);
}
.status-badge.pending {
  background: rgba(232,93,4,0.1);
  color: var(--orange);
}
.status-badge.cancelled {
  background: rgba(26,18,8,0.06);
  color: rgba(26,18,8,0.5);
}
.status-dot {
  width: 5px; height: 5px;
  border-radius: 50%;
}
.status-dot.green  { background: var(--green); }
.status-dot.orange { background: var(--orange); }
.status-dot.gray   { background: rgba(26,18,8,0.3); }

/* amount */
.amount {
  font-weight: 600;
  font-size: 14px;
}
.order-id {
  font-family: var(--font-display);
  font-size: 18px;
  letter-spacing: 0.04em;
  color: var(--dark);
}

/* empty state */
.empty-state {
  max-width: 500px;
  margin: 0 auto;
  text-align: center;
  padding: 80px 40px;
}
.empty-emoji { font-size: 60px; margin-bottom: 20px; }
.empty-state h3 {
  font-family: var(--font-display);
  font-size: 40px;
  color: var(--dark);
  letter-spacing: 0.04em;
  margin-bottom: 10px;
}
.empty-state p {
  font-family: var(--font-body);
  font-size: 14px;
  color: rgba(26,18,8,0.5);
  margin-bottom: 30px;
}

/* back button */
.back-btn {
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
  padding: 13px 28px;
  border-radius: 40px;
  transition: background 0.25s, gap 0.2s;
}
.back-btn:hover {
  background: var(--orange);
  gap: 16px;
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
@media (max-width: 900px) {
  .hero { grid-template-columns: 1fr; min-height: 50vh; }
  .hero-left { padding: 80px 24px 20px; align-items: center; text-align: center; }
  .hero-right { padding: 0 24px 40px; }
  .hero-tagline { max-width: 100%; }
  .table-section { padding: 40px 20px 60px; }
  .nav { padding: 0 20px; }
}
@media (max-width: 600px) {
  table { min-width: 100%; }
  thead th, tbody td { padding: 12px 14px; font-size: 12px; }
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

<!-- hero -->
<section class="hero">
  <div class="hero-left">
    <div class="hero-word">Your.</div>
    <div class="hero-word">Order.</div>
    <div class="hero-word">History.</div>
    <p class="hero-tagline">
      Every meal you've ordered, all in one place. Track, reorder, and relive the flavours.
    </p>
    <p class="hero-hashtag">#TasteTheCity</p>
  </div>
  <div class="hero-right">
    <div class="big-emoji">📋</div>
  </div>
</section>

<!-- orders -->
<section class="table-section">

<%
List<Order> historyList = (List<Order>)request.getAttribute("orderHistory");

if(historyList != null && !historyList.isEmpty()){
%>

<div class="table-wrap scroll-3d">
<table>
<thead>
<tr>
<th>Order ID</th>
<th>Date</th>
<th>Total Amount</th>
<th>Status</th>
<th>Payment</th>
</tr>
</thead>
<tbody>

<%
for(Order o : historyList){
  String status = o.getStatus() != null ? o.getStatus().toLowerCase() : "";
  String badgeClass = "pending";
  String dotClass = "orange";
  if(status.contains("deliver") || status.contains("completed")) {
    badgeClass = "delivered"; dotClass = "green";
  } else if(status.contains("cancel")) {
    badgeClass = "cancelled"; dotClass = "gray";
  }
%>

<tr>
<td><span class="order-id">#<%= o.getOrderId() %></span></td>
<td><%= o.getOrderDate() %></td>
<td><span class="amount">₹ <%= o.getTotalAmount() %></span></td>
<td><span class="status-badge <%= badgeClass %>"><span class="status-dot <%= dotClass %>"></span><%= o.getStatus() %></span></td>
<td><%= o.getPaymentMethod() %></td>
</tr>

<%
}
%>

</tbody>
</table>
</div>

<div style="text-align:center; margin-top:40px;">
  <a href="restaurantServlet" class="back-btn">
    <span>← Back to Restaurants</span>
  </a>
</div>

<%
} else {
%>

<div class="empty-state scroll-3d">
  <div class="empty-emoji">📭</div>
  <h3>No Orders Yet</h3>
  <p>Looks like you haven't placed any orders. Craving something? Browse our restaurants and place your first order.</p>
  <a href="restaurantServlet" class="back-btn">
    <span>Browse Restaurants →</span>
  </a>
</div>

<%
}
%>

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
      <p class="footer-copy" style="margin-bottom:16px;">© 2025 Flavora. All rights reserved.</p>
      <a href="#" class="footer-top-link">Back to top ↑</a>
    </div>
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
document.querySelectorAll('a, button, .back-btn').forEach(el => {
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
</script>

</body>
</html>
