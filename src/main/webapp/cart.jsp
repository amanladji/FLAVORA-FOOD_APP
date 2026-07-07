<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import= "com.tap.model.Cart" %>
<%@ page import= "com.tap.model.CartItems" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	.h2{
		display: flex;
		justify-content: center;
	}

	body{
		margin: 0;
		padding: 0;
		background: #f5f5f5;
		font-family: Arial, sans-serif;
	}
	.container{
		width: 900px;
		margin: 20px auto;
		padding: 10px 20px;
		
		background: white;
		border: 1px solid #dcdcdc;
		border-radius: 12px;
		overflow: hidden;
		
	}
	
	.cart-container{
		height: 50px;
		width: 800px;
		
		display: flex;
		align-items: center;
		
	}
	
	.item-name{
		flex: 2;
	}
	.item-price,
	.item-totalPrice,
	.item-quantity{
		flex: 1;
	}
	.item-action{
		padding-left: 50px;
		flex: 0.8;
		text-align: center;
	}
	
	.item:first-child{
		text-align:left;
	}
	.cart-container:last-child{
		border-bottom: none;
	}
	.item-action button{
		padding: 8px 18px;
		cursor: pointer;
	}
	.qty-btn{
		width: 30px;
		height: 30px;
		border-radius: 50%;
		border: none;
	}
	.qty-btn:hover{
		background: black;
		color: white;
		transition: 0.3s;
	}
	.item-quantity{
		display: flex;
		justify-content: center;
		align-items: center;
		gap: 10px;
	}
	
	.cart-empty-container{
		margin: 80px auto;
		height: 300px;
		width: 800px;
		background: white;
		display: flex;
		justify-content: center;
		align-items: center;
		flex-direction: column;
		border-radius: 12px;
		border: none;
	}
	.goToRestaurant:hover{
		background: darkorange;
	}
	.goToRestaurant{
		padding: 8px 15px;
		background: orange;
		color: white;
		text-decoration: none;
		margin-top: 15px;
		font-size: 20px;
		border-radius: 5px;
	}
	.cart-action{
		display: flex;
		justify-content: center;
	}
	
	.add-more-btn{
		padding: 8px 15px;
		background: orange;
		color: white;
		text-decoration: none;
		margin-right: 300px;
		border-radius: 5px;
		border: 1px solid black;
	}
	
	.checkout-btn{
		padding: 8px 15px;
		background: orange;
		color: white;
		text-decoration: none;
		margin-left: 300px;
		border-radius: 5px;
		border: 1px solid black;
	}
	
	.add-more-btn:hover{
		background: darkorange;
		cursor: pointer;
	}
	.checkout-btn:hover{
		background: darkorange;
		cursor: pointer;
	}
</style>
</head>
<body>

	<%  Cart cart = (Cart)session.getAttribute("cart");
		Integer restaurantId = (Integer)session.getAttribute("oldRestaurantId");
		
		double grandTotal = 0;
		if(cart != null && !cart.getItems().isEmpty()){
	%>
		<div class="h2"><h2>Your Cart</h2></div>
	<div class="container">
			<div class="cart-container">
				<div class="item item-name"><strong>Item</strong></div>
				<div class="item item-price"><strong>Price</strong></div>
				<div class="item item-totalPrice"><strong>Total</strong></div>
				<div class="item item-quantity"><strong>Quantity</strong></div>
				<div class="item item-action"><strong>Action</strong></div>
			</div>
	<%		
			
			for(CartItems item : cart.getItems().values()){
				grandTotal = grandTotal + item.getTotalPrice();
	%>

	<hr>
		<div class="cart-container">
			<div class="item item-name"><%=item.getName() %></div>
			<div class="item item-price"><%= item.getPrice() %></div>
			<div class="item item-totalPrice"><%= item.getTotalPrice() %></div>
			
			<div class="item item-quantity">
					<form action="callCartServlet">
						<input type="hidden" name="menuId" value="<%= item.getMenuId()%>">
						<input type="hidden" name="restaurantId" value="<%= item.getRestaurantId()%>">
						<%if(item.getQuantity() - 1 <= 0) {%>
							<input type="hidden" name= "action" value="remove">
						<% } else { %>
							<input type="hidden" name="action" value="update">
							<input type="hidden" name="quantity" value="<%= item.getQuantity() - 1%>">
						<%} %>
							<button class="qty-btn" type="submit">-</button>
					</form>
			    <span><%= item.getQuantity() %></span>
					<form action="callCartServlet">
						<input type="hidden" name="menuId" value="<%= item.getMenuId()%>">
						<input type="hidden" name="restaurantId" value="<%= item.getRestaurantId()%>">
						<input type="hidden" name="quantity" value="<%= item.getQuantity() + 1%>">
						<input type="hidden" name="action" value="update">
						<button class="qty-btn" type="submit">+</button>
					</form>
			</div>
			
			<form action="callCartServlet">
				<input type="hidden" name="menuId" value="<%=item.getMenuId()%>">
				<input type="hidden" name="restaurantId" value="<%= item.getRestaurantId()%>">
				<input type="hidden" name = "action" value="remove">
				<div class="item item-action"><button type="submit">Remove</button></div>
			</form>
			
			
		</div>
		
		
	<% } %>
	
	<hr>
		<div class="cart-container">
			<div class="item item-name"><strong>Grand Total</strong></div>
			<div class="item item-price"></div>
			<div class="item item-totalPrice"></div>
			<div class="item item-quantity"></div>
			<div class="item item-action"><strong><%= grandTotal %>/-</strong></div>
		</div>
</div>

		<div class="cart-action">
			<a class= "add-more-btn" href="callMenuServlet?restaurantId=<%= restaurantId%>">Add more items</a>
			<a class="checkout-btn" href="checkout.jsp">Proceed To Checkout</a>
		</div>
		
	<%
		}else{	
	%>
	<div class="cart-empty-container">
		<div><h2>Your Cart is empty</h2></div>
		<div><p>Please add some food item from menu.</p></div>
		<div><a class="goToRestaurant" href="restaurantServlet">Go To Restaurant</a></div>
	</div>
	

	<%
		}
	%>

</body>
</html> --%>


























<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import= "com.tap.model.Cart" %>
<%@ page import= "com.tap.model.CartItems" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cart — Flavora</title>

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

/* cart section */
.cart-section {
  padding: 30px 48px 60px;
  max-width: 900px;
  margin: 0 auto;
}

/* cart card */
.cart-card {
  background: var(--white);
  border-radius: 4px;
  overflow: hidden;
  box-shadow: -6px 10px 30px rgba(26,18,8,0.06);
}

/* cart header row */
.cart-header {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1.2fr 0.8fr;
  align-items: center;
  padding: 14px 24px;
  background: var(--dark);
  color: rgba(255,255,255,0.6);
  font-size: 9px;
  font-weight: 600;
  letter-spacing: 0.2em;
  text-transform: uppercase;
}

/* cart item row */
.cart-row {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1.2fr 0.8fr;
  align-items: center;
  padding: 16px 24px;
  border-bottom: 1px solid rgba(26,18,8,0.05);
  transition: background 0.2s;
}
.cart-row:last-child { border-bottom: none; }
.cart-row:hover { background: rgba(232,93,4,0.03); }
.cart-row.grand-total {
  background: var(--dark);
  color: var(--white);
  border-bottom: none;
}
.cart-row.grand-total:hover { background: var(--dark); }

/* item name */
.cart-item-name {
  font-family: var(--font-display);
  font-size: 22px;
  letter-spacing: 0.02em;
  color: var(--orange);
  line-height: 1.1;
}
.cart-cell {
  font-family: var(--font-body);
  font-size: 13px;
  color: var(--dark);
}
.cart-cell.price {
  font-weight: 500;
}
.cart-cell.total {
  font-weight: 600;
  font-size: 14px;
}
.cart-cell.grand {
  font-family: var(--font-display);
  font-size: 22px;
  letter-spacing: 0.04em;
  color: var(--gold);
}

/* quantity controls */
.qty-wrap {
  display: flex;
  align-items: center;
  gap: 10px;
}
.qty-btn {
  width: 30px; height: 30px;
  border-radius: 50%;
  border: 1.5px solid var(--orange);
  background: transparent;
  color: var(--orange);
  font-size: 15px;
  font-weight: 500;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
}
.qty-btn:hover {
  background: var(--orange);
  color: var(--white);
}
.qty-btn:active { transform: scale(0.9); }
.qty-number {
  font-family: var(--font-body);
  font-size: 15px;
  font-weight: 600;
  color: var(--dark);
  min-width: 20px;
  text-align: center;
}

/* remove */
.remove-btn {
  font-family: var(--font-body);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: rgba(26,18,8,0.35);
  background: none;
  border: none;
  cursor: pointer;
  padding: 6px 0;
  transition: color 0.2s;
}
.remove-btn:hover { color: var(--orange); }

/* cart actions */
.cart-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 30px;
  gap: 16px;
  flex-wrap: wrap;
}
.cart-action-btn {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  padding: 13px 26px;
  border-radius: 40px;
  transition: all 0.25s;
  cursor: pointer;
}
.cart-action-btn.ghost {
  color: var(--dark);
  border: 1.5px solid rgba(26,18,8,0.2);
  background: transparent;
}
.cart-action-btn.ghost:hover {
  border-color: var(--orange);
  color: var(--orange);
  gap: 12px;
}
.cart-action-btn.primary {
  background: var(--dark);
  color: var(--white);
  border: 1.5px solid var(--dark);
}
.cart-action-btn.primary:hover {
  background: var(--orange);
  border-color: var(--orange);
  gap: 12px;
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
.empty-state .back-btn {
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
.empty-state .back-btn:hover { background: var(--orange); gap: 16px; }

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

/* hr hidden */
.hr { display: none; }

/* responsive */
@media (max-width: 768px) {
  .cart-header, .cart-row {
    grid-template-columns: 1.5fr 1fr 1fr 1fr 0.7fr;
    padding: 12px 16px;
    gap: 4px;
  }
  .cart-item-name { font-size: 18px; }
  .cart-section { padding: 20px 16px 50px; }
  .hero { grid-template-columns: 1fr; min-height: 30vh; }
  .hero-left { padding: 80px 24px 10px; align-items: center; text-align: center; }
  .hero-right { padding: 0 24px 30px; }
  .hero-tagline { max-width: 100%; }
  .nav { padding: 0 20px; }
  .cart-actions { flex-direction: column; align-items: stretch; }
  .cart-action-btn { justify-content: center; }
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
    <a href="cart.jsp"                class="btnn primary">Cart</a>
    <a href="register.html"           class="btnn">Sign Up</a>
    <a href="login.html"              class="btnn">Login</a>
  </div>
</nav>

<!-- hero -->
<section class="hero">
  <div class="hero-left">
    <div class="hero-word">Your.</div>
    <div class="hero-word">Cart.</div>
    <p class="hero-tagline">
      Review your selections, adjust quantities, and proceed when you're ready.
    </p>
  </div>
  <div class="hero-right">
    <div class="big-emoji">🛒</div>
  </div>
</section>

<section class="cart-section">

<%
  Cart cart = (Cart)session.getAttribute("cart");
  Integer restaurantId = (Integer)session.getAttribute("oldRestaurantId");

  double grandTotal = 0;
  if(cart != null && !cart.getItems().isEmpty()){
%>

<div class="cart-card scroll-3d">
  <div class="cart-header">
    <span>Item</span>
    <span>Price</span>
    <span>Total</span>
    <span>Quantity</span>
    <span>Action</span>
  </div>

<%
  for(CartItems item : cart.getItems().values()){
    grandTotal = grandTotal + item.getTotalPrice();
%>

  <div class="cart-row">
    <div class="cart-item-name"><%= item.getName() %></div>
    <div class="cart-cell price">₹ <%= item.getPrice() %></div>
    <div class="cart-cell total">₹ <%= item.getTotalPrice() %></div>
    <div class="qty-wrap">
      <form action="callCartServlet" style="display:inline;">
        <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
        <input type="hidden" name="restaurantId" value="<%= item.getRestaurantId() %>">
        <% if(item.getQuantity() - 1 <= 0) { %>
          <input type="hidden" name="action" value="remove">
        <% } else { %>
          <input type="hidden" name="action" value="update">
          <input type="hidden" name="quantity" value="<%= item.getQuantity() - 1 %>">
        <% } %>
        <button class="qty-btn" type="submit">−</button>
      </form>
      <span class="qty-number"><%= item.getQuantity() %></span>
      <form action="callCartServlet" style="display:inline;">
        <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
        <input type="hidden" name="restaurantId" value="<%= item.getRestaurantId() %>">
        <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
        <input type="hidden" name="action" value="update">
        <button class="qty-btn" type="submit">+</button>
      </form>
    </div>
    <form action="callCartServlet" style="display:inline;">
      <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
      <input type="hidden" name="restaurantId" value="<%= item.getRestaurantId() %>">
      <input type="hidden" name="action" value="remove">
      <button class="remove-btn" type="submit">✕ Remove</button>
    </form>
  </div>

<%
  }
%>

  <div class="cart-row grand-total">
    <div style="font-family:var(--font-body);font-size:12px;font-weight:600;letter-spacing:0.12em;text-transform:uppercase;color:rgba(255,255,255,0.5);">Grand Total</div>
    <div></div>
    <div></div>
    <div></div>
    <div class="cart-cell grand">₹ <%= grandTotal %>/-</div>
  </div>
</div>

<div class="cart-actions">
  <a class="cart-action-btn ghost" href="callMenuServlet?restaurantId=<%= restaurantId %>">
    <span>← Add more items</span>
  </a>
  <a class="cart-action-btn primary" href="checkout.jsp">
    <span>Proceed to Checkout →</span>
  </a>
</div>

<%
  } else {
%>

<div class="empty-state scroll-3d">
  <div class="empty-emoji">📭</div>
  <h3>Your Cart is Empty</h3>
  <p>Please add some food items from the menu to get started.</p>
  <a href="restaurantServlet" class="back-btn">
    <span>Go To Restaurant →</span>
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
      <p class="footer-copy" style="margin-bottom:16px;">© 2026 Flavora. All rights reserved.</p>
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
document.querySelectorAll('a, button, .qty-btn, .remove-btn, .cart-action-btn, .back-btn').forEach(el => {
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
