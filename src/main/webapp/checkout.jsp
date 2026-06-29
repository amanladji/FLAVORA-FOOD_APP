<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.Cart,com.tap.model.CartItems" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, Helvetica, sans-serif;
}

body{
    background:#f5f5f5;
    padding:40px;
}

.checkout-wrapper{
    width:90%;
    max-width:1200px;
    margin:auto;
    display:flex;
    gap:30px;
    align-items:flex-start;
}

.checkout-box{
    flex:2;
    background:white;
    padding:30px;
    border-radius:12px;
    box-shadow:0 5px 15px rgba(0,0,0,.1);
}

.summary-box{
    flex:1;
    background:white;
    padding:25px;
    border-radius:12px;
    box-shadow:0 5px 15px rgba(0,0,0,.1);
    position:sticky;
    top:20px;
}

.section-title{
    margin-bottom:25px;
    color:#333;
    border-bottom:2px solid #ff6b35;
    padding-bottom:10px;
}

.form-group{
    margin-bottom:20px;
}

label{
    display:block;
    margin-bottom:8px;
    font-weight:bold;
    color:#444;
}

input,
textarea,
select{
    width:100%;
    padding:12px;
    border:1px solid #ccc;
    border-radius:8px;
    outline:none;
    font-size:15px;
    transition:.3s;
}

input:focus,
textarea:focus,
select:focus{
    border-color:#ff6b35;
}

textarea{
    resize:none;
    height:120px;
}

.summary-item{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:12px 0;
    border-bottom:1px solid #eee;
}

.item-name{
    flex:2;
    font-weight:bold;
}

.item-qty{
    flex:1;
    text-align:center;
}

.item-total{
    flex:1;
    text-align:right;
    color:#ff6b35;
    font-weight:bold;
}

.bill-details{
    margin-top:20px;
}

.bill-row{
    display:flex;
    justify-content:space-between;
    margin:12px 0;
    font-size:16px;
}

.bill-row:last-child{
    border-top:2px dashed #ccc;
    padding-top:15px;
    margin-top:20px;
    font-size:20px;
    font-weight:bold;
}

.place-order-btn{
    width:100%;
    margin-top:25px;
    padding:14px;
    background:#28a745;
    color:white;
    border:none;
    border-radius:8px;
    cursor:pointer;
    font-size:17px;
    transition:.3s;
}

.place-order-btn:hover{
    background:#218838;
}

.back-cart-btn{
    display:block;
    text-align:center;
    margin-top:15px;
    text-decoration:none;
    background:#ff6b35;
    color:white;
    padding:12px;
    border-radius:8px;
    transition:.3s;
}

.back-cart-btn:hover{
    background:#e85b2d;
}

.empty-checkout{
    width:500px;
    margin:120px auto;
    background:white;
    padding:40px;
    border-radius:12px;
    text-align:center;
    box-shadow:0 5px 15px rgba(0,0,0,.1);
}

.empty-checkout h2{
    margin-bottom:15px;
}

.empty-checkout p{
    margin-bottom:25px;
    color:#666;
}

.browse-btn{
    text-decoration:none;
    display:inline-block;
    padding:12px 25px;
    background:#ff6b35;
    color:white;
    border-radius:8px;
    transition:.3s;
}

.browse-btn:hover{
    background:#e85b2d;
}

@media(max-width:900px){

.checkout-wrapper{
    flex-direction:column;
}

.summary-box{
    width:100%;
    position:static;
}

}

</style>

</head>
<body>

<%

Cart cart=(Cart)session.getAttribute("cart");

Integer restaurantId=(Integer)session.getAttribute("oldRestaurantId");

double grandTotal=0;
double deliveryFee=40;
double platformFee=5;

if(cart!=null && !cart.getItems().isEmpty()){

    for(CartItems item:cart.getItems().values()){
        grandTotal+=item.getTotalPrice();
    }

    double finalAmount=grandTotal+deliveryFee+platformFee;

%>

<form action="checkout" method="post">

<div class="checkout-wrapper">

<div class="checkout-box">

<h2 class="section-title">Delivery Details</h2>

<div class="form-group">
<label>Full Name</label>
<input type="text"
name="customerName"
placeholder="Enter Your Name"
required>
</div>

<div class="form-group">
<label>Mobile Number</label>
<input type="tel"
name="mobileNumber"
placeholder="Enter Mobile Number"
pattern="[0-9]{10}"
maxlength="10"
required>
</div>

<div class="form-group">
<label>Delivery Address</label>
<textarea
name="address"
placeholder="Enter Complete Address"
required></textarea>
</div>

<div class="form-group">
<label>Payment Method</label>

<select name="paymentMethod" required>

<option value="">Select Payment Method</option>

<option value="cash">
Cash On Delivery 
</option>

<option value="upi">
UPI
</option>

<option value="card">
Credit Card
</option>

<option value="card">
Debit Card
</option>


</select>

</div>

</div>

<div class="summary-box">

<h2 class="section-title">Order Summary</h2>

<%

for(CartItems item:cart.getItems().values()){

%>

<div class="summary-item">

<div class="item-name">
<%=item.getName()%>
</div>

<div class="item-qty">
x <%=item.getQuantity()%>
</div>

<div class="item-total">
₹ <%=item.getTotalPrice()%>
</div>

</div>

<%
}
%>

<div class="bill-details">

<div class="bill-row">
<span>Item Total</span>
<span>₹ <%=grandTotal%></span>
</div>

<div class="bill-row">
<span>Delivery Fee</span>
<span>₹ <%=deliveryFee%></span>
</div>

<div class="bill-row">
<span>Platform Fee</span>
<span>₹ <%=platformFee%></span>
</div>

<div class="bill-row">
<span>Total Amount</span>
<span>₹ <%=finalAmount%></span>
</div>

</div>

<%
session.setAttribute("finalAmount",finalAmount);
%>

<input
type="hidden"
name="restaurantId"
value="<%=restaurantId%>">

<input
type="hidden"
name="totalAmount"
value="<%=finalAmount%>">

<button
type="submit"
class="place-order-btn">
Place Order
</button>

<a
href="cart.jsp"
class="back-cart-btn">
Back to Cart
</a>

</div>

</div>

</form>

<%
}
else{
%>

<div class="empty-checkout">

<h2>Your Cart is Empty</h2>

<p>Please add food items before checkout.</p>

<a
href="restaurantServlet"
class="browse-btn">
Browse Restaurants
</a>

</div>

<%
}
%>

</body>
</html> --%>
























<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.Cart,com.tap.model.CartItems" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checkout — Flavora</title>

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

/* hero */
.hero {
  min-height: 35vh;
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
  font-size: clamp(64px, 7vw, 100px);
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
  margin-top: 20px;
  opacity: 0;
  animation: wordReveal 0.8s 0.4s cubic-bezier(0.16,1,0.3,1) forwards;
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
  font-size: clamp(80px, 12vw, 150px);
  animation: float 4s ease-in-out infinite;
  filter: drop-shadow(0 24px 48px rgba(232,93,4,0.2));
}
@keyframes float {
  0%,100% { transform: translateY(0) rotate(-3deg); }
  50%      { transform: translateY(-18px) rotate(3deg); }
}

/* 3D reveal */
.scroll-3d {
  opacity: 1;
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

/* checkout section */
.checkout-section {
  padding: 30px 48px 60px;
}
.checkout-wrapper {
  max-width: 1100px;
  margin: 0 auto;
  display: flex;
  gap: 30px;
  align-items: flex-start;
}

/* delivery form */
.checkout-box {
  flex: 2;
  background: var(--white);
  padding: 30px;
  border-radius: 4px;
  box-shadow: -6px 10px 30px rgba(26,18,8,0.06);
}
.section-title {
  font-family: var(--font-display);
  font-size: 28px;
  letter-spacing: 0.04em;
  color: var(--dark);
  margin-bottom: 24px;
  padding-bottom: 10px;
  border-bottom: 2px solid var(--orange);
}
.form-group { margin-bottom: 22px; }
.form-group label {
  display: block;
  font-family: var(--font-body);
  font-size: 10px;
  font-weight: 600;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: rgba(26,18,8,0.5);
  margin-bottom: 8px;
}
.input-wrap {
  position: relative;
}
.input-wrap input,
.input-wrap textarea,
.input-wrap select {
  width: 100%;
  padding: 12px 0;
  background: transparent;
  border: none;
  border-bottom: 1.5px solid rgba(26,18,8,0.12);
  outline: none;
  font-family: var(--font-body);
  font-size: 14px;
  color: var(--dark);
  transition: border-color 0.3s;
}
.input-wrap textarea { resize: none; height: 100px; }
.input-wrap select {
  cursor: pointer;
  appearance: none;
  -webkit-appearance: none;
  padding-right: 20px;
  background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6'%3E%3Cpath d='M0 0l5 6 5-6z' fill='%231a1208' opacity='0.4'/%3E%3C/svg%3E") no-repeat right center;
}
.input-wrap input:focus,
.input-wrap textarea:focus,
.input-wrap select:focus {
  border-bottom-color: var(--orange);
}
.input-wrap .underline {
  position: absolute;
  bottom: 0; left: 50%;
  height: 1.5px;
  width: 0;
  background: var(--orange);
  transition: width 0.35s ease, left 0.35s ease;
}
.input-wrap input:focus ~ .underline,
.input-wrap textarea:focus ~ .underline,
.input-wrap select:focus ~ .underline {
  width: 100%;
  left: 0;
}

/* summary box */
.summary-box {
  flex: 1;
  background: var(--white);
  border-radius: 4px;
  box-shadow: -6px 10px 30px rgba(26,18,8,0.06);
  padding: 30px 24px;
  position: sticky;
  top: 90px;
}
.summary-box .section-title {
  font-size: 22px;
  margin-bottom: 20px;
}
.summary-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 0;
  border-bottom: 1px solid rgba(26,18,8,0.06);
}
.summary-item:last-of-type { border-bottom: none; }
.summary-item .item-name {
  font-family: var(--font-display);
  font-size: 18px;
  letter-spacing: 0.02em;
  color: var(--orange);
  flex: 2;
}
.summary-item .item-qty {
  font-family: var(--font-body);
  font-size: 12px;
  color: rgba(26,18,8,0.5);
  flex: 1;
  text-align: center;
}
.summary-item .item-total {
  font-family: var(--font-body);
  font-size: 13px;
  font-weight: 600;
  color: var(--dark);
  flex: 1;
  text-align: right;
}

/* bill details */
.bill-details { margin-top: 20px; }
.bill-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 0;
  font-family: var(--font-body);
  font-size: 13px;
  color: rgba(26,18,8,0.7);
}
.bill-row:last-child {
  border-top: 2px dashed rgba(26,18,8,0.12);
  margin-top: 14px;
  padding-top: 16px;
  font-family: var(--font-display);
  font-size: 22px;
  letter-spacing: 0.04em;
  color: var(--gold);
}
.bill-row:last-child span:last-child {
  color: var(--gold);
}

/* buttons */
.place-order-btn {
  width: 100%;
  margin-top: 24px;
  padding: 14px;
  background: var(--green);
  color: var(--white);
  font-family: var(--font-body);
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  border: none;
  border-radius: 40px;
  cursor: pointer;
  transition: background 0.25s, transform 0.2s;
}
.place-order-btn:hover {
  background: #3a6d20;
  transform: scale(1.02);
}
.place-order-btn:active { transform: scale(0.97); }
.back-cart-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  margin-top: 12px;
  padding: 12px;
  font-family: var(--font-body);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--dark);
  border: 1.5px solid rgba(26,18,8,0.15);
  border-radius: 40px;
  transition: all 0.25s;
}
.back-cart-btn:hover {
  border-color: var(--orange);
  color: var(--orange);
  gap: 12px;
}

/* empty state */
.empty-checkout {
  max-width: 500px;
  margin: 80px auto;
  text-align: center;
  padding: 80px 40px;
  background: var(--white);
  border-radius: 4px;
  box-shadow: -6px 10px 30px rgba(26,18,8,0.06);
}
.empty-checkout .empty-emoji { font-size: 60px; margin-bottom: 20px; }
.empty-checkout h3 {
  font-family: var(--font-display);
  font-size: 40px;
  color: var(--dark);
  letter-spacing: 0.04em;
  margin-bottom: 10px;
}
.empty-checkout p {
  font-family: var(--font-body);
  font-size: 14px;
  color: rgba(26,18,8,0.5);
  margin-bottom: 30px;
}
.empty-checkout .back-btn {
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
.empty-checkout .back-btn:hover { background: var(--orange); gap: 16px; }

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
.footer-top-link:hover { background: var(--gold); color: var(--dark); border-color: var(--gold); }

/* responsive */
@media (max-width: 900px) {
  .checkout-wrapper { flex-direction: column; }
  .summary-box { position: static; width: 100%; }
  .checkout-section { padding: 20px 20px 50px; }
  .hero { grid-template-columns: 1fr; min-height: 30vh; }
  .hero-left { padding: 80px 24px 10px; align-items: center; text-align: center; }
  .hero-right { padding: 0 24px 30px; }
  .hero-tagline { max-width: 100%; }
  .nav { padding: 0 20px; }
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
    <div class="hero-word">Check.</div>
    <div class="hero-word">Out.</div>
    <p class="hero-tagline">
      One last step. Confirm your details and place your order.
    </p>
  </div>
  <div class="hero-right">
    <div class="big-emoji">🧾</div>
  </div>
</section>

<section class="checkout-section">

<%
Cart cart = (Cart)session.getAttribute("cart");
Integer restaurantId = (Integer)session.getAttribute("oldRestaurantId");

double grandTotal = 0;
double deliveryFee = 40;
double platformFee = 5;

if(cart != null && !cart.getItems().isEmpty()){

  for(CartItems item : cart.getItems().values()){
    grandTotal += item.getTotalPrice();
  }

  double finalAmount = grandTotal + deliveryFee + platformFee;
%>

<form action="checkout" method="post">
<div class="checkout-wrapper">

  <!-- delivery form -->
  <div class="checkout-box scroll-3d">
    <h2 class="section-title">Delivery Details</h2>

    <div class="form-group">
      <label>Full Name</label>
      <div class="input-wrap">
        <input type="text" name="customerName" placeholder="Enter Your Name" required>
        <span class="underline"></span>
      </div>
    </div>

    <div class="form-group">
      <label>Mobile Number</label>
      <div class="input-wrap">
        <input type="tel" name="mobileNumber" placeholder="Enter Mobile Number" pattern="[0-9]{10}" maxlength="10" required>
        <span class="underline"></span>
      </div>
    </div>

    <div class="form-group">
      <label>Delivery Address</label>
      <div class="input-wrap">
        <textarea name="address" placeholder="Enter Complete Address" required></textarea>
        <span class="underline"></span>
      </div>
    </div>

    <div class="form-group">
      <label>Payment Method</label>
      <div class="input-wrap">
        <select name="paymentMethod" required>
          <option value="">Select Payment Method</option>
          <option value="cash">Cash On Delivery</option>
          <option value="upi">UPI</option>
          <option value="card">Credit Card</option>
          <option value="card">Debit Card</option>
        </select>
        <span class="underline"></span>
      </div>
    </div>
  </div>

  <!-- order summary -->
  <div class="summary-box scroll-3d">
    <h2 class="section-title">Order Summary</h2>

<%
  for(CartItems item : cart.getItems().values()){
%>

    <div class="summary-item">
      <span class="item-name"><%= item.getName() %></span>
      <span class="item-qty">x <%= item.getQuantity() %></span>
      <span class="item-total">₹ <%= item.getTotalPrice() %></span>
    </div>

<%
  }
%>

    <div class="bill-details">
      <div class="bill-row">
        <span>Item Total</span>
        <span>₹ <%= grandTotal %></span>
      </div>
      <div class="bill-row">
        <span>Delivery Fee</span>
        <span>₹ <%= deliveryFee %></span>
      </div>
      <div class="bill-row">
        <span>Platform Fee</span>
        <span>₹ <%= platformFee %></span>
      </div>
      <div class="bill-row">
        <span>Total Amount</span>
        <span>₹ <%= finalAmount %></span>
      </div>
    </div>

<%
  session.setAttribute("finalAmount", finalAmount);
%>

    <input type="hidden" name="restaurantId" value="<%= restaurantId %>">
    <input type="hidden" name="totalAmount" value="<%= finalAmount %>">

    <button type="submit" class="place-order-btn">Place Order</button>
    <a href="cart.jsp" class="back-cart-btn"><span>← Back to Cart</span></a>
  </div>

</div>
</form>

<%
} else {
%>

<div class="empty-checkout scroll-3d">
  <div class="empty-emoji">📭</div>
  <h3>Your Cart is Empty</h3>
  <p>Please add food items before checkout.</p>
  <a href="restaurantServlet" class="back-btn"><span>Browse Restaurants →</span></a>
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
document.querySelectorAll('a, button, .place-order-btn, .back-cart-btn, .back-btn').forEach(el => {
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
