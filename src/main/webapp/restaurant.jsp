<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.List" %>
<%@ page import="com.tap.DAOImple.copy.RestaurantDAOImple" %>
<%@ page import="com.tap.model.Restaurant" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurants</title>

<style>

body{
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding: 0;
}

/* Navbar */
.nav{
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;

    background-color: darkorange;
    display: flex;
    justify-content: flex-end;
    align-items: center;

    padding: 10px 20px;
    box-sizing: border-box;
    z-index: 1000;
}

.nav .buttons .btnn{
    background-color: white;
    color: black;
    text-decoration: none;

    padding: 6px 12px;
    margin-left: 8px;

    border-radius: 4px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.2);
}

.nav .buttons .btnn:hover{
    background-color: #f0f0f0;
}

/* Restaurant Container */
.container{
    width: 90%;
    margin: 80px auto 20px;

    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 280px));
    justify-content: center;
    gap: 35px;
}

/* Restaurant Card */
.card{
    background: white;
    border-radius: 12px;
    overflow: hidden;
    
    width: 280px;
    padding: 10px;

    box-shadow: 0 2px 10px rgba(0,0,0,0.12);
    transition: transform 0.3s ease;
}

.card:hover{
    transform: translateY(-5px);
}

/* Restaurant Image */
.card img{
    width: 100%;
    height: 180px;
    object-fit: cover;
    border-radius: 10px;
}

/* Restaurant Name */
.card h2{
    margin: 10px 0 5px;
    color: #ff6600;
    font-size: 20px;
}

/* Restaurant Details */
.card p{
    margin: 5px 0;
    font-size: 14px;
    color: #555;
}

/* View Menu Button */
.btn{
    background-color: orange;
    color: white;
    text-decoration: none;

    padding: 8px 16px;
    border-radius: 5px;

    display: inline-block;
    margin-top: 10px;
    font-size: 14px;
}

.btn:hover{
    background-color: darkorange;
}

</style>

</head>
<body>

<section>
	<nav class="nav">
		<div class= "buttons">
			<a href="callOrderHistoryServlet" class="btnn">order history</a>
			<a href="cart.jsp" class="btnn">Cart</a>
			<a href="register.html"  class= btnn>signup</a>
			<a href="login.html" class="btnn">login</a>
		</div>
	</nav>
</section>

<div class="container">
<%
List<Restaurant> restaurantList = (List<Restaurant>)request.getAttribute("restaurantList");

if(restaurantList != null){
    for(Restaurant r : restaurantList){
%>

<div class="card">
	<img alt="" src="assets/<%= r.getImages()%>" class="restaurant-img">
    <h2><%= r.getName() %></h2>
    <p><strong>Cuisine:</strong> <%= r.getCuisineType() %></p>
    <p><strong>Delivery Time:</strong> <%= r.getDeliveryTime() %> mins </p>
    <p><strong>Address:</strong> <%= r.getAddress() %></p>
    <p><strong>Rating:</strong> ⭐ <%= r.getRating() %></p>
    <p><strong>isActive:</strong> <%= r.getIsActive() %></p>
    <a href="callMenuServlet?restaurantId=<%= r.getRestaurantId() %>" class="btn">View Restaurant</a>
</div>

<%
    }
}
%>

</div>

</body>
</html>  --%>





















<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.tap.DAOImple.copy.RestaurantDAOImple" %>
<%@ page import="com.tap.model.Restaurant" %>
<%@ page import="com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Restaurants — Flavora</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Caveat:wght@400;600&family=Inter:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400&display=swap" rel="stylesheet">

<style>
/* ─── TOKENS ─── */
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

/* ─── RESET ─── */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; }
body {
  font-family: var(--font-body);
  background: var(--cream);
  color: var(--dark);
  overflow-x: hidden;
  cursor: default;
}
img { display: block; max-width: 100%; }
a { text-decoration: none; color: inherit; }

/* ─── SCROLL PROGRESS BAR ─── */
.scroll-progress {
  position: fixed;
  top: 0; left: 0;
  height: 3px;
  background: linear-gradient(90deg, var(--orange), var(--gold));
  z-index: 10001;
  width: 0%;
  transition: width 0.1s linear;
}

/* ─── SECTION NAV DOTS ─── */
.section-nav {
  position: fixed;
  right: 28px;
  top: 50%;
  transform: translateY(-50%);
  z-index: 9997;
  display: flex;
  flex-direction: column;
  gap: 14px;
}
.section-nav a {
  display: block;
  width: 10px; height: 10px;
  border-radius: 50%;
  background: rgba(26,18,8,0.2);
  border: 1.5px solid transparent;
  transition: all 0.3s cubic-bezier(0.16,1,0.3,1);
  position: relative;
}
.section-nav a::after {
  content: attr(data-label);
  position: absolute;
  right: 20px;
  top: 50%;
  transform: translateY(-50%);
  font-family: var(--font-body);
  font-size: 9px;
  font-weight: 500;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: rgba(26,18,8,0.4);
  white-space: nowrap;
  opacity: 0;
  transition: opacity 0.25s, right 0.25s;
  pointer-events: none;
}
.section-nav a:hover::after {
  opacity: 1;
  right: 26px;
}
.section-nav a.active {
  background: var(--orange);
  border-color: var(--orange);
  transform: scale(1.4);
  box-shadow: 0 0 12px rgba(232,93,4,0.35);
}
.section-nav a.active::after {
  opacity: 1;
  color: var(--orange);
  right: 26px;
}

/* ─── CUSTOM CURSOR ─── */
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

/* ─── NAV ─── */
.nav {
  position: fixed;
  top: 0; left: 0; right: 0;
  z-index: 10000;
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

/* ─── HERO ─── */
.hero {
  min-height: 100vh;
  background: var(--cream);
  display: flex;
  flex-direction: column;
  position: relative;
  overflow: hidden;
  padding-top: 68px;
  perspective: 1200px;
}
.hero-words {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  padding: 60px 48px 0;
  position: relative;
  z-index: 2;
  transform-style: preserve-3d;
}
.hero-word {
  font-family: var(--font-display);
  font-size: clamp(72px, 11vw, 160px);
  line-height: 0.88;
  letter-spacing: 0.02em;
  color: var(--dark);
  opacity: 0;
  transform: translateY(60px) translateZ(0);
  animation: wordReveal 0.9s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-word:nth-child(1) { animation-delay: 0.1s; }
.hero-word:nth-child(2) { animation-delay: 0.25s; color: var(--orange); }
.hero-word:nth-child(3) { animation-delay: 0.4s; }

@keyframes wordReveal {
  to { opacity: 1; transform: translateY(0) translateZ(0); }
}

.hero-center {
  flex: 1;
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
  padding: 0 48px 40px;
  gap: 40px;
  position: relative;
  z-index: 2;
  transform-style: preserve-3d;
}
.hero-left {
  display: flex;
  flex-direction: column;
  gap: 20px;
}
.hero-hashtag {
  font-family: var(--font-display);
  font-size: clamp(18px, 2.5vw, 28px);
  letter-spacing: 0.04em;
  color: var(--orange);
  opacity: 0;
  animation: wordReveal 0.8s 0.55s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-scroll-links {
  display: flex;
  flex-direction: column;
  gap: 10px;
  opacity: 0;
  animation: wordReveal 0.8s 0.7s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-scroll-links a {
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--dark);
  display: inline-flex;
  align-items: center;
  gap: 8px;
  transition: color 0.2s, gap 0.2s;
}
.hero-scroll-links a::after {
  content: '→';
  font-size: 13px;
  transition: transform 0.2s;
}
.hero-scroll-links a:hover { color: var(--orange); gap: 14px; }

.hero-img-wrap {
  position: relative;
  width: clamp(280px, 30vw, 440px);
  aspect-ratio: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  transform-style: preserve-3d;
}
.hero-img-circle {
  position: absolute;
  inset: 0;
  background: radial-gradient(circle, var(--gold) 0%, transparent 70%);
  border-radius: 50%;
  opacity: 0.3;
  animation: slowSpin 20s linear infinite;
}
@keyframes slowSpin {
  to { transform: rotate(360deg); }
}
.hero-plate-emoji {
  font-size: clamp(100px, 14vw, 180px);
  line-height: 1;
  animation: float 4s ease-in-out infinite;
  position: relative;
  z-index: 1;
  filter: drop-shadow(0 24px 48px rgba(232,93,4,0.25));
  transform-style: preserve-3d;
  transition: transform 0.15s ease-out;
}
@keyframes float {
  0%,100% { transform: translateY(0) rotate(-3deg); }
  50%      { transform: translateY(-18px) rotate(3deg); }
}

.hero-right {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 20px;
  text-align: right;
}
.hero-pronun {
  font-family: var(--font-body);
  font-size: 13px;
  font-weight: 300;
  font-style: italic;
  color: rgba(26,18,8,0.5);
  letter-spacing: 0.04em;
  opacity: 0;
  animation: wordReveal 0.8s 0.6s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-tagline {
  font-family: var(--font-body);
  font-size: 14px;
  line-height: 1.7;
  color: rgba(26,18,8,0.65);
  max-width: 240px;
  opacity: 0;
  animation: wordReveal 0.8s 0.75s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-cta {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  background: var(--dark);
  color: var(--white);
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  padding: 13px 28px;
  border-radius: 40px;
  transition: background 0.25s, gap 0.2s, transform 0.3s cubic-bezier(0.16,1,0.3,1);
  opacity: 0;
  animation: wordReveal 0.8s 0.9s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-cta:hover { background: var(--orange); gap: 16px; transform: translateZ(20px); }
.hero-cta span { font-size: 14px; transition: transform 0.2s; }
.hero-cta:hover span { transform: translateX(4px); }

.hero-big-split {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  padding: 0 48px 20px;
  position: relative;
  z-index: 2;
  opacity: 0;
  animation: wordReveal 1s 0.5s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-big-split .big-word {
  font-family: var(--font-display);
  font-size: clamp(60px, 10vw, 140px);
  line-height: 0.85;
  letter-spacing: 0.03em;
  color: var(--dark);
}

/* ─── 3D SCROLL REVEAL ─── */
.scroll-3d {
  opacity: 1;
  transform: perspective(1200px) translateY(70px) rotateX(10deg);
  transform-origin: center top;
  will-change: transform, opacity;
  transition: opacity 0.9s cubic-bezier(0.16,1,0.3,1),
              transform 1.1s cubic-bezier(0.16,1,0.3,1);
}
.scroll-3d.vis {
  opacity: 1;
  transform: perspective(1200px) translateY(0) rotateX(0);
}

.scroll-3d-left {
  opacity: 1;
  transform: perspective(1000px) translateX(-60px) rotateY(6deg);
  transform-origin: left center;
  will-change: transform, opacity;
  transition: opacity 0.9s cubic-bezier(0.16,1,0.3,1),
              transform 1.1s cubic-bezier(0.16,1,0.3,1);
}
.scroll-3d-left.vis {
  opacity: 1;
  transform: perspective(1000px) translateX(0) rotateY(0);
}

.scroll-3d-right {
  opacity: 1;
  transform: perspective(1000px) translateX(60px) rotateY(-6deg);
  transform-origin: right center;
  will-change: transform, opacity;
  transition: opacity 0.9s cubic-bezier(0.16,1,0.3,1),
              transform 1.1s cubic-bezier(0.16,1,0.3,1);
}
.scroll-3d-right.vis {
  opacity: 1;
  transform: perspective(1000px) translateX(0) rotateY(0);
}

/* stagger delays */
.delay-1 { transition-delay: 0.05s; }
.delay-2 { transition-delay: 0.12s; }
.delay-3 { transition-delay: 0.2s; }
.delay-4 { transition-delay: 0.28s; }

/* ─── VIDEO EXPERIENCE SECTION ─── */
.video-section {
  position: relative;
  height: 100vh;
  overflow: hidden;
  background: var(--dark);
}
.video-section video {
  position: absolute;
  top: 0; left: 0;
  width: 100%; height: 100%;
  object-fit: cover;
  z-index: 0;
}
.video-overlay {
  position: absolute;
  inset: 0;
  z-index: 1;
  background: linear-gradient(
    to bottom,
    rgba(26,18,8,0.25) 0%,
    rgba(26,18,8,0.7) 100%
  );
}
.video-content {
  position: relative;
  z-index: 2;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  padding: 0 48px;
}
.video-eyebrow {
  font-family: var(--font-body);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.28em;
  text-transform: uppercase;
  color: var(--gold);
  margin-bottom: 20px;
}
.video-big {
  font-family: var(--font-display);
  font-size: clamp(56px, 8vw, 110px);
  line-height: 0.88;
  letter-spacing: 0.03em;
  color: var(--white);
  margin-bottom: 10px;
}
.video-script {
  font-family: var(--font-script);
  font-size: clamp(18px, 2.5vw, 30px);
  color: var(--gold);
  font-style: italic;
  margin-bottom: 24px;
}
.video-body {
  font-family: var(--font-body);
  font-size: 14px;
  line-height: 1.8;
  color: rgba(255,255,255,0.65);
  max-width: 420px;
}
.video-body em {
  color: var(--gold);
  font-style: normal;
}

/* ─── TICKER ─── */
.ticker-wrap {
  overflow: hidden;
  background: var(--dark);
  padding: 14px 0;
  position: relative;
}
.ticker-wrap.light {
  background: var(--orange);
}
.ticker-track {
  display: flex;
  gap: 0;
  animation: ticker 28s linear infinite;
  white-space: nowrap;
}
.ticker-wrap:hover .ticker-track { animation-play-state: paused; }
.ticker-track span {
  font-family: var(--font-display);
  font-size: 15px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--white);
  padding: 0 40px;
  flex-shrink: 0;
}
.ticker-wrap.light .ticker-track span { color: var(--white); }
.ticker-track .dot {
  color: var(--gold);
  padding: 0;
  font-size: 18px;
}
.ticker-wrap.light .ticker-track .dot { color: var(--dark); }

@keyframes ticker {
  from { transform: translateX(0); }
  to   { transform: translateX(-50%); }
}
.ticker-reverse .ticker-track { animation-direction: reverse; }

/* ─── STATS ─── */
.stats-section {
  background: var(--dark);
  padding: 80px 48px;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 0;
}
.stat-block {
  text-align: center;
  padding: 20px;
  border-right: 1px solid rgba(255,255,255,0.08);
}
.stat-block:last-child { border-right: none; }
.stat-num {
  font-family: var(--font-display);
  font-size: clamp(48px, 5vw, 72px);
  color: var(--gold);
  letter-spacing: 0.04em;
  line-height: 1;
}
.stat-label {
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 400;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: rgba(255,255,255,0.45);
  margin-top: 8px;
}

/* ─── INTRO + SEARCH ─── */
.intro-section {
  padding: 100px 48px 60px;
  background: var(--cream);
  position: relative;
  overflow: hidden;
}
.intro-eyebrow {
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.28em;
  text-transform: uppercase;
  color: var(--orange);
  margin-bottom: 20px;
}
.intro-big {
  font-family: var(--font-display);
  font-size: clamp(48px, 7vw, 96px);
  line-height: 0.9;
  letter-spacing: 0.03em;
  color: var(--dark);
}
.intro-sub {
  font-family: var(--font-script);
  font-size: clamp(20px, 3vw, 32px);
  color: var(--orange);
  font-style: italic;
  margin-top: 12px;
}

.search-wrap {
  max-width: 560px;
  margin: 40px auto 0;
  display: flex;
  align-items: center;
  background: var(--white);
  border: 1.5px solid rgba(26,18,8,0.12);
  border-radius: 40px;
  padding: 6px 6px 6px 24px;
  box-shadow: 0 8px 32px rgba(26,18,8,0.06);
  transition: border-color 0.3s, box-shadow 0.3s;
}
.search-wrap:focus-within {
  border-color: var(--orange);
  box-shadow: 0 8px 40px rgba(232,93,4,0.12);
}
.search-wrap input {
  flex: 1;
  border: none;
  background: transparent;
  font-family: var(--font-body);
  font-size: 14px;
  color: var(--dark);
  outline: none;
}
.search-wrap input::placeholder { color: #aaa; font-style: italic; }
.search-btn {
  background: var(--dark);
  color: var(--white);
  border: none;
  border-radius: 32px;
  padding: 12px 26px;
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  cursor: pointer;
  transition: background 0.25s;
}
.search-btn:hover { background: var(--orange); }

.filter-row {
  display: flex;
  justify-content: center;
  gap: 10px;
  flex-wrap: wrap;
  padding: 32px 48px 0;
}
.fpill {
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  padding: 9px 22px;
  border-radius: 40px;
  border: 1.5px solid rgba(26,18,8,0.2);
  background: transparent;
  color: var(--dark);
  cursor: pointer;
  transition: all 0.2s ease;
}
.fpill:hover, .fpill.active {
  background: var(--dark);
  color: var(--white);
  border-color: var(--dark);
}

/* ─── CARD GRID ─── */
.grid-wrap {
  padding: 60px 48px 100px;
  background: var(--cream);
}
.card-grid {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 28px;
}

/* Card 3D */
.card {
  background: var(--white);
  border-radius: 4px;
  overflow: hidden;
  position: relative;
  cursor: pointer;
  opacity: 1;
  transform: perspective(1000px) translateY(50px) rotateX(8deg);
  transform-origin: center top;
  transition: opacity 0.8s ease,
              transform 0.9s cubic-bezier(0.16,1,0.3,1),
              box-shadow 0.3s ease;
}
.card.vis {
  opacity: 1;
  transform: perspective(1000px) translateY(0) rotateX(0);
}
.card:hover {
  box-shadow: -10px 14px 50px rgba(26,18,8,0.2);
  transform: perspective(1000px) translateY(-6px) rotateX(2deg) scale(1.01);
}

/* stagger */
.card:nth-child(3n+2) { transition-delay: 0.08s; }
.card:nth-child(3n+3) { transition-delay: 0.16s; }

.card-img-wrap { position: relative; overflow: hidden; height: 220px; }
.card-img-wrap img {
  width: 100%; height: 100%;
  object-fit: cover;
  transition: transform 0.6s cubic-bezier(0.25,0.8,0.25,1);
}
.card:hover .card-img-wrap img { transform: scale(1.07); }

.card-cuisine-tag {
  position: absolute;
  top: 14px; left: 14px;
  background: var(--dark);
  color: var(--white);
  font-family: var(--font-body);
  font-size: 9px;
  font-weight: 600;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  padding: 5px 12px;
  border-radius: 40px;
}
.card-rating-tag {
  position: absolute;
  top: 14px; right: 14px;
  background: var(--gold);
  color: var(--dark);
  font-family: var(--font-body);
  font-size: 12px;
  font-weight: 700;
  padding: 5px 11px;
  border-radius: 40px;
  display: flex;
  align-items: center;
  gap: 3px;
}
.card-img-wrap::after {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(to top, rgba(26,18,8,0.55) 0%, transparent 50%);
  pointer-events: none;
}
.card-delivery {
  position: absolute;
  bottom: 12px; left: 14px;
  z-index: 1;
  display: flex;
  align-items: center;
  gap: 5px;
  color: rgba(255,255,255,0.88);
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 400;
  letter-spacing: 0.08em;
}

.card-body {
  padding: 20px 22px 22px;
}
.card-name {
  font-family: var(--font-display);
  font-size: 30px;
  letter-spacing: 0.04em;
  color: var(--dark);
  text-transform: uppercase;
  line-height: 0.95;
  margin-bottom: 10px;
}
.card-address {
  font-family: var(--font-body);
  font-size: 12px;
  color: rgba(26,18,8,0.5);
  line-height: 1.5;
  margin-bottom: 16px;
  display: flex;
  align-items: flex-start;
  gap: 6px;
}
.card-address svg { flex-shrink: 0; margin-top: 1px; opacity: 0.4; }

.card-status {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  font-family: var(--font-body);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  margin-bottom: 18px;
  color: rgba(26,18,8,0.5);
}
.status-dot {
  width: 6px; height: 6px;
  border-radius: 50%;
  background: #4caf50;
  animation: pulsedot 2s ease-in-out infinite;
}
@keyframes pulsedot {
  0%,100% { opacity:1; transform:scale(1); }
  50%      { opacity:0.45; transform:scale(0.8); }
}

.card-btn {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  background: var(--dark);
  color: var(--white);
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  padding: 13px 20px;
  border-radius: 2px;
  text-decoration: none;
  transition: background 0.25s;
  overflow: hidden;
  position: relative;
}
.card-btn::before {
  content: '';
  position: absolute;
  top: 0; left: -100%;
  width: 100%; height: 100%;
  background: var(--orange);
  transition: left 0.35s cubic-bezier(0.25,0.8,0.25,1);
  z-index: 0;
}
.card-btn:hover::before { left: 0; }
.card-btn span { position: relative; z-index: 1; }
.card-btn svg { position: relative; z-index: 1; transition: transform 0.25s; }
.card-btn:hover svg { transform: translateX(5px); }

/* ─── EMPTY STATE ─── */
.empty-state {
  grid-column: 1 / -1;
  text-align: center;
  padding: 100px 40px;
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
}

/* ─── DARK FEATURE ─── */
.dark-feature {
  background: var(--dark);
  padding: 100px 48px;
  position: relative;
  overflow: hidden;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 60px;
  align-items: center;
}
.dark-feature::before {
  content: '';
  position: absolute;
  top: -100px; right: -100px;
  width: 400px; height: 400px;
  background: radial-gradient(circle, rgba(244,161,36,0.15) 0%, transparent 70%);
  border-radius: 50%;
}
.dark-feature-text { position: relative; z-index: 1; }
.df-eyebrow {
  font-family: var(--font-body);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.28em;
  text-transform: uppercase;
  color: var(--gold);
  margin-bottom: 20px;
}
.df-big {
  font-family: var(--font-display);
  font-size: clamp(44px, 6vw, 80px);
  line-height: 0.9;
  letter-spacing: 0.03em;
  color: var(--white);
  margin-bottom: 10px;
}
.df-script {
  font-family: var(--font-script);
  font-size: clamp(18px, 2.5vw, 28px);
  color: var(--gold);
  font-style: italic;
  margin-bottom: 28px;
}
.df-body {
  font-family: var(--font-body);
  font-size: 14px;
  line-height: 1.8;
  color: rgba(255,255,255,0.6);
  max-width: 360px;
}

.dark-feature-visual { position: relative; z-index: 1; }
.big-emoji-block {
  font-size: clamp(80px, 12vw, 160px);
  text-align: center;
  filter: drop-shadow(0 20px 60px rgba(244,161,36,0.3));
  animation: float 5s ease-in-out infinite;
}

/* ─── STREET SECTION ─── */
.street-section {
  background: var(--cream);
  padding: 100px 0;
  position: relative;
  overflow: hidden;
}
.street-bg-text {
  font-family: var(--font-display);
  font-size: clamp(80px, 12vw, 160px);
  color: rgba(26,18,8,0.04);
  letter-spacing: 0.04em;
  text-align: center;
  position: absolute;
  top: 50%;
  left: 0; right: 0;
  transform: translateY(-50%);
  pointer-events: none;
  white-space: nowrap;
  overflow: hidden;
}
.street-inner {
  max-width: 1000px;
  margin: 0 auto;
  padding: 0 48px;
  text-align: center;
  position: relative;
  z-index: 1;
}
.street-eyebrow {
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.28em;
  text-transform: uppercase;
  color: var(--orange);
  margin-bottom: 20px;
}
.street-big {
  font-family: var(--font-display);
  font-size: clamp(44px, 7vw, 100px);
  line-height: 0.9;
  letter-spacing: 0.03em;
  color: var(--dark);
}
.street-script {
  font-family: var(--font-script);
  font-size: clamp(20px, 3vw, 36px);
  color: var(--orange);
  font-style: italic;
  margin-top: 10px;
  margin-bottom: 50px;
}

.mini-cards {
  display: flex;
  gap: 20px;
  justify-content: center;
  flex-wrap: wrap;
}
.mini-card {
  background: var(--white);
  border-radius: 4px;
  padding: 24px;
  width: 200px;
  text-align: center;
  box-shadow: -6px 8px 30px rgba(26,18,8,0.08);
  transition: transform 0.4s cubic-bezier(0.16,1,0.3,1), box-shadow 0.3s;
}
.mini-card:hover {
  transform: perspective(800px) translateY(-8px) translateZ(20px) rotateX(4deg);
  box-shadow: -10px 16px 40px rgba(26,18,8,0.14);
}
.mini-card-icon { font-size: 36px; margin-bottom: 10px; }
.mini-card-title {
  font-family: var(--font-display);
  font-size: 22px;
  letter-spacing: 0.04em;
  color: var(--dark);
  margin-bottom: 4px;
}
.mini-card-sub {
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 400;
  letter-spacing: 0.08em;
  color: rgba(26,18,8,0.45);
  text-transform: uppercase;
}

/* ─── FOOTER ─── */
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


/* ─── RESPONSIVE ─── */
@media (max-width: 900px) {
  .hero-center { grid-template-columns: 1fr; text-align: center; gap: 20px; }
  .hero-words { padding: 40px 24px 0; }
  .hero-big-split { padding: 0 24px 20px; }
  .hero-right { align-items: center; text-align: center; }
  .hero-scroll-links { display: none; }
  .stats-section { grid-template-columns: 1fr 1fr; }
  .dark-feature { grid-template-columns: 1fr; }
  .intro-section, .grid-wrap, .street-inner { padding-left: 24px; padding-right: 24px; }
  .video-content { padding: 0 24px; }
  .nav { padding: 0 20px; }
  .filter-row { padding: 24px 24px 0; }
  .section-nav { display: none; }
}
@media (max-width: 600px) {
  .stats-section { grid-template-columns: 1fr 1fr; gap: 0; }
  .hero-img-wrap { width: 220px; }
  .hero-plate-emoji { font-size: 80px; }
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

<!-- scroll progress bar -->
<div class="scroll-progress" id="scrollProgress"></div>

<!-- section nav dots -->
<nav class="section-nav" id="sectionNav"></nav>

<!-- custom cursor -->
<div class="cursor-dot" id="cDot"></div>
<div class="cursor-ring" id="cRing"></div>

<!-- ═══════════════════════════════════════════
     NAV
════════════════════════════════════════════ -->
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
    <a href="admin/adminLogin.html"	  class="btnn primary">Admin Login</a>
   	<%User user = (User)session.getAttribute("user");%>
   	<div class="btnn primary" onclick="toggleMenu()">
   		👤<%=user != null? user.getUserName():"User" %>
   	</div> 
   	 <ul>
   		<li><a class="btnn" href="<%=request.getContextPath()%>/callLogoutServlet" >Logout</a></li>
   	</ul> 	
  </div>
</nav>

<!-- ═══════════════════════════════════════════
     HERO
════════════════════════════════════════════ -->
<section class="hero" id="hero" data-section="Home">
  <div class="hero-words">
    <div class="hero-word">Fresh.</div>
    <div class="hero-word">Fast.</div>
    <div class="hero-word">Flavourful.</div>
  </div>

  <div class="hero-center" id="heroTilt">
    <div class="hero-left">
      <p class="hero-hashtag">#TasteTheCity</p>
      <div class="hero-scroll-links">
        <a href="#restaurants">Browse Restaurants</a>
        <a href="#why">Why Flavora</a>
      </div>
    </div>

    <div class="hero-img-wrap">
      <div class="hero-img-circle"></div>
      <div class="hero-plate-emoji" id="heroEmoji">🍽️</div>
    </div>

    <div class="hero-right">
      <p class="hero-pronun"><em>flavora</em></p>
      <p class="hero-tagline">
        More than just delivery — it's a curated experience bringing the city's
        finest kitchens straight to your table.
      </p>
      <a href="#restaurants" class="hero-cta">
        Discover restaurants <span>→</span>
      </a>
    </div>
  </div>

  <div class="hero-big-split">
    <div class="big-word">ORDER</div>
    <div class="big-word" style="color:var(--orange);">NOW</div>
  </div>
</section>

<!-- ═══════════════════════════════════════════
     VIDEO EXPERIENCE
════════════════════════════════════════════ -->
<section class="video-section" data-section="Experience">
  <video autoplay muted loop playsinline poster="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100' height='100'%3E%3Crect fill='%231a1208' width='100' height='100'/%3E%3C/svg%3E">
    <source src="https://cdn.pixabay.com/video/2019/07/06/24999-347024091_large.mp4" type="video/mp4">
  </video>
  <div class="video-overlay"></div>
  <div class="video-content scroll-3d">
    <p class="video-eyebrow">✦ From our kitchen ✦</p>
    <h2 class="video-big">Crafted<br>with Passion</h2>
    <p class="video-script">every dish, a masterpiece</p>
    <p class="video-body">Fresh ingredients, skilled chefs, and a dedication to flavour —<br>watch the artistry behind every <em>order</em>.</p>
  </div>
</section>

<!-- ═══════════════════════════════════════════
     TICKER 1
════════════════════════════════════════════ -->
<div class="ticker-wrap" data-section="Stats">
  <div class="ticker-track" id="ticker1"></div>
</div>

<!-- ═══════════════════════════════════════════
     STATS
════════════════════════════════════════════ -->
<div class="stats-section" data-section="Stats">
  <div class="stat-block scroll-3d delay-1">
    <div class="stat-num">120+</div>
    <div class="stat-label">Restaurants</div>
  </div>
  <div class="stat-block scroll-3d delay-2">
    <div class="stat-num">30 min</div>
    <div class="stat-label">Avg Delivery</div>
  </div>
  <div class="stat-block scroll-3d delay-3">
    <div class="stat-num">4.8 ★</div>
    <div class="stat-label">Avg Rating</div>
  </div>
  <div class="stat-block scroll-3d delay-4">
    <div class="stat-num">50k+</div>
    <div class="stat-label">Happy Customers</div>
  </div>
</div>

<!-- ═══════════════════════════════════════════
     INTRO + SEARCH
════════════════════════════════════════════ -->
<section class="intro-section" id="restaurants" data-section="Restaurants">
  <p class="intro-eyebrow scroll-3d">✦ Browse &amp; discover ✦</p>
  <h2 class="intro-big scroll-3d delay-1">Our<br>Restaurants</h2>
  <p class="intro-sub scroll-3d delay-2"><em>Handpicked kitchens. Extraordinary flavour.</em></p>

  <div class="search-wrap scroll-3d delay-3">
    <input type="text" id="searchInput" placeholder="Search cuisine or restaurant…" oninput="applyFilters()">
    <button class="search-btn">Search</button>
  </div>
</section>

<!-- filter row -->
<div class="filter-row scroll-3d delay-4" id="filterRow">
  <button class="fpill active" onclick="setFilter(this,'')">All</button>
  <button class="fpill" onclick="setFilter(this,'indian')">Indian</button>
  <button class="fpill" onclick="setFilter(this,'chinese')">Chinese</button>
  <button class="fpill" onclick="setFilter(this,'italian')">Italian</button>
  <button class="fpill" onclick="setFilter(this,'fast food')">Fast Food</button>
  <button class="fpill" onclick="setFilter(this,'biryani')">Biryani</button>
  <button class="fpill" onclick="setFilter(this,'pizza')">Pizza</button>
</div>

<!-- ═══════════════════════════════════════════
     RESTAURANT GRID
════════════════════════════════════════════ -->
<div class="grid-wrap" data-section="Restaurants">
<div class="card-grid" id="cardGrid">

<%
List<Restaurant> restaurantList = (List<Restaurant>)request.getAttribute("restaurantList");

if(restaurantList != null){
    for(Restaurant r : restaurantList){
%>

<div class="card"
     data-cuisine="<%= r.getCuisineType() != null ? r.getCuisineType().toLowerCase() : "" %>"
     data-name="<%= r.getName() != null ? r.getName().toLowerCase() : "" %>">

  <div class="card-img-wrap">
    <img alt="<%= r.getName() %>" src="assets/<%= r.getImages()%>">
    <div class="card-cuisine-tag"><%= r.getCuisineType() %></div>
    <div class="card-rating-tag">⭐ <%= r.getRating() %></div>
    <div class="card-delivery">
      <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
      <%= r.getDeliveryTime() %> mins
    </div>
  </div>

  <div class="card-body">
    <h2 class="card-name"><%= r.getName() %></h2>
    <p class="card-address">
      <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0118 0z"/><circle cx="12" cy="10" r="3"/></svg>
      <%= r.getAddress() %>
    </p>
    <div class="card-status">
      <span class="status-dot"></span>
      <span><%= r.getIsActive()== 1 ? "Available":"Not Available" %></span>
    </div>
    <a href="callMenuServlet?restaurantId=<%= r.getRestaurantId() %>" class="card-btn">
      <span>View Restaurant</span>
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
    </a>
  </div>
</div>

<%
    }
} else {
%>
<div class="empty-state">
  <div class="empty-emoji">🍽️</div>
  <h3>No Restaurants Yet</h3>
  <p>Great things are cooking. Check back soon.</p>
</div>
<%
}
%>

</div>
</div>

<!-- ═══════════════════════════════════════════
     TICKER 2 (reverse / orange)
════════════════════════════════════════════ -->
<div class="ticker-wrap light ticker-reverse" data-section="Why">
  <div class="ticker-track" id="ticker2"></div>
</div>

<!-- ═══════════════════════════════════════════
     DARK FEATURE SECTION
════════════════════════════════════════════ -->
<section class="dark-feature" id="why" data-section="Why">
  <div class="dark-feature-text scroll-3d-left" id="dfText">
    <p class="df-eyebrow">✦ Why flavora ✦</p>
    <h2 class="df-big">Crafted<br>with Care</h2>
    <p class="df-script"><em>every meal, a moment of joy</em></p>
    <p class="df-body">
      We partner only with kitchens that treat ingredients with respect —
      fresh produce sourced daily, recipes refined over generations,
      delivered to the people who matter most. No shortcuts. Just flavour.
    </p>
  </div>
  <div class="dark-feature-visual scroll-3d-right" id="dfVisual">
    <div class="big-emoji-block">🥘</div>
  </div>
</section>

<!-- ═══════════════════════════════════════════
     STREET / WHY-US SECTION
════════════════════════════════════════════ -->
<section class="street-section" data-section="Order">
  <div class="street-bg-text">FLAVORA</div>
  <div class="street-inner">
    <p class="street-eyebrow scroll-3d" id="sEyebrow">✦ Always nearby ✦</p>
    <h2 class="street-big scroll-3d delay-1" id="sBig">Order from<br>Anywhere</h2>
    <p class="street-script scroll-3d delay-2" id="sScript"><em>the city's best food, one tap away</em></p>

    <div class="mini-cards scroll-3d delay-3" id="miniCards">
      <div class="mini-card">
        <div class="mini-card-icon">🛵</div>
        <div class="mini-card-title">Fast</div>
        <div class="mini-card-sub">Delivery</div>
      </div>
      <div class="mini-card">
        <div class="mini-card-icon">🌿</div>
        <div class="mini-card-title">Fresh</div>
        <div class="mini-card-sub">Ingredients</div>
      </div>
      <div class="mini-card">
        <div class="mini-card-icon">⭐</div>
        <div class="mini-card-title">Rated</div>
        <div class="mini-card-sub">Kitchens</div>
      </div>
      <div class="mini-card">
        <div class="mini-card-icon">🔒</div>
        <div class="mini-card-title">Secure</div>
        <div class="mini-card-sub">Payments</div>
      </div>
    </div>
  </div>
</section>

<!-- ═══════════════════════════════════════════
     FOOTER
════════════════════════════════════════════ -->
<footer class="footer" data-section="Footer">
  <div class="footer-bg-word">FLAVORA</div>
  <div class="footer-inner">
    <div class="footer-logo">
      FLAVORA
      <span><em>fine food delivery</em></span>
    </div>
    <div style="text-align:right;">
      <p class="footer-copy" style="margin-bottom:16px;">© 2026 Flavora. All rights reserved.</p>
      <a href="#hero" class="footer-top-link">Back to top ↑</a>
    </div>
  </div>
</footer>

<!-- ═══════════════════════════════════════════
     JAVASCRIPT
════════════════════════════════════════════ -->
<script>
/* ── Custom cursor ── */
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
document.querySelectorAll('a, button, .card, .fpill').forEach(el => {
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

/* ── Nav dark toggle ── */
const nav = document.getElementById('mainNav');
window.addEventListener('scroll', () => {
  const y = window.scrollY;
  nav.classList.toggle('dark-bg', y > window.innerHeight - 80);
}, { passive: true });

/* ── Build tickers ── */
function buildTicker(id, items) {
  const track = document.getElementById(id);
  const full  = [...items, ...items];
  full.forEach((txt, i) => {
    const s = document.createElement('span');
    s.textContent = txt;
    track.appendChild(s);
    if (i < full.length - 1) {
      const d = document.createElement('span');
      d.className = 'dot';
      d.textContent = ' ✦ ';
      track.appendChild(d);
    }
  });
}
const t1Items = ['Fresh Delivery','Top Restaurants','Fast & Reliable','Order Now','Premium Kitchens','Great Taste'];
const t2Items = ['City\'s Finest Food','Rated 4.8 Stars','30 Min Delivery','50,000+ Orders','Eat Well, Live Well','Flavora'];
buildTicker('ticker1', [...t1Items, ...t1Items]);
buildTicker('ticker2', [...t2Items, ...t2Items]);

/* ── Scroll progress bar ── */
const progressBar = document.getElementById('scrollProgress');
window.addEventListener('scroll', () => {
  const scrollTop = window.scrollY;
  const docHeight = document.documentElement.scrollHeight - window.innerHeight;
  const pct = docHeight > 0 ? (scrollTop / docHeight) * 100 : 0;
  progressBar.style.width = pct + '%';
}, { passive: true });

/* ── Section nav dots ── */
const sectionNav = document.getElementById('sectionNav');
const sections = document.querySelectorAll('[data-section]');
const sectionNames = [...new Set(Array.from(sections).map(s => s.dataset.section))];

const sectionNavItems = [];
sectionNames.forEach(name => {
  const a = document.createElement('a');
  a.href = '#';
  a.dataset.label = name;
  a.addEventListener('click', e => {
    e.preventDefault();
    const target = document.querySelector(`[data-section="${name}"]`);
    if (target) {
      target.scrollIntoView({ behavior: 'smooth' });
    }
  });
  sectionNav.appendChild(a);
  sectionNavItems.push({ el: a, name });
});

function updateSectionNav() {
  const scrollY = window.scrollY + window.innerHeight / 3;
  let activeIdx = 0;
  const sectionEls = Array.from(sections);
  sectionEls.forEach((sec, i) => {
    if (scrollY >= sec.offsetTop) activeIdx = i;
  });
  const activeName = sectionEls[activeIdx]?.dataset?.section;
  sectionNavItems.forEach(({ el, name }) => {
    el.classList.toggle('active', name === activeName);
  });
}
window.addEventListener('scroll', updateSectionNav, { passive: true });
window.addEventListener('resize', updateSectionNav, { passive: true });
setTimeout(updateSectionNav, 100);

/* ── 3D Scroll Reveal — immediate vis for elements already in viewport ── */
document.querySelectorAll(
  '.scroll-3d, .scroll-3d-left, .scroll-3d-right, .card'
).forEach(el => {
  const rect = el.getBoundingClientRect();
  if (rect.top < window.innerHeight - 60) {
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
}, { threshold: 0.1, rootMargin: '0px 0px -60px 0px' });

document.querySelectorAll(
  '.scroll-3d:not(.vis), .scroll-3d-left:not(.vis), .scroll-3d-right:not(.vis), .card:not(.vis)'
).forEach(el => observer3d.observe(el));

/* ── Hero 3D mouse tilt parallax ── */
const heroTilt = document.getElementById('heroTilt');
const heroEmoji = document.getElementById('heroEmoji');

if (heroTilt && heroEmoji) {
  document.querySelector('.hero').addEventListener('mousemove', e => {
    const rect = heroTilt.getBoundingClientRect();
    const cx = rect.left + rect.width / 2;
    const cy = rect.top + rect.height / 2;
    const dx = (e.clientX - cx) / rect.width;
    const dy = (e.clientY - cy) / rect.height;

    const tiltX = dy * -6;
    const tiltY = dx * 6;

    heroTilt.style.transform =
      `perspective(1000px) rotateX(${tiltX}deg) rotateY(${tiltY}deg)`;
    heroTilt.style.transition = 'transform 0.08s ease-out';

    heroEmoji.style.transform =
      `translateZ(40px) rotateX(${tiltX * 0.5}deg) rotateY(${tiltY * 0.5}deg)`;
    heroEmoji.style.transition = 'transform 0.08s ease-out';
  });

  document.querySelector('.hero').addEventListener('mouseleave', () => {
    heroTilt.style.transform = 'perspective(1000px) rotateX(0) rotateY(0)';
    heroTilt.style.transition = 'transform 0.5s cubic-bezier(0.16,1,0.3,1)';
    heroEmoji.style.transform = 'translateZ(0) rotateX(0) rotateY(0)';
    heroEmoji.style.transition = 'transform 0.5s cubic-bezier(0.16,1,0.3,1)';
  });
}

/* ── Search & Filter ── */
let activeFilter = '';

function setFilter(btn, cuisine) {
  document.querySelectorAll('.fpill').forEach(p => p.classList.remove('active'));
  btn.classList.add('active');
  activeFilter = cuisine;
  applyFilters();
}

function applyFilters() {
  const q = document.getElementById('searchInput').value.toLowerCase().trim();
  document.querySelectorAll('#cardGrid .card').forEach(card => {
    const name    = card.dataset.name    || '';
    const cuisine = card.dataset.cuisine || '';
    const matchQ  = !q || name.includes(q) || cuisine.includes(q);
    const matchF  = !activeFilter || cuisine.includes(activeFilter);
    card.style.display = (matchQ && matchF) ? '' : 'none';
  });
}

/* ── Smooth scroll offset ── */
document.querySelectorAll('a[href^="#"]').forEach(a => {
  a.addEventListener('click', e => {
    const target = document.querySelector(a.getAttribute('href'));
    if (target) {
      e.preventDefault();
      window.scrollTo({ top: target.offsetTop - 68, behavior: 'smooth' });
    }
  });
});
</script>

</body>
</html> 












