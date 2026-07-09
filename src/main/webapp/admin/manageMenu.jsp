
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "com.tap.model.Menu, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png"
      href="${pageContext.request.contextPath}/assets/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Menu — Flavora Admin</title>

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
.delay-4 { transition-delay: 0.28s; }

/* ═══════════════════════════════════════════
   MANAGE MENU SPECIFIC
   ════════════════════════════════════════════ */

.admin-page {
  padding-top: 68px;
  min-height: 100vh;
  background: var(--cream);
}
.admin-inner {
  max-width: 1400px;
  margin: 0 auto;
  padding: 60px 48px 100px;
}

/* page header */
.page-header {
  margin-bottom: 48px;
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

/* form card */
.form-card {
  background: var(--white);
  border-radius: 4px;
  padding: 40px 44px;
  box-shadow: -6px 10px 30px rgba(26,18,8,0.06);
  margin-bottom: 60px;
}
.form-card h2 {
  font-family: var(--font-display);
  font-size: 36px;
  letter-spacing: 0.04em;
  color: var(--orange);
  line-height: 1;
  margin-bottom: 32px;
}
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
.form-group textarea,
.form-group select {
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
.form-group select { cursor: pointer; }
.form-group:focus-within input,
.form-group:focus-within textarea,
.form-group:focus-within select {
  border-color: var(--orange);
  box-shadow: 0 0 0 3px rgba(232,93,4,0.08);
  background: var(--white);
}
.form-group input[type="file"] {
  padding: 10px 14px;
  cursor: pointer;
}
.form-group input[type="file"]::file-selector-button {
  font-family: var(--font-body);
  font-size: 10px; font-weight: 600;
  letter-spacing: 0.12em; text-transform: uppercase;
  background: var(--dark); color: var(--white);
  border: none; padding: 8px 16px;
  border-radius: 2px; cursor: pointer;
  margin-right: 12px;
  transition: background 0.2s;
}
.form-group input[type="file"]::file-selector-button:hover {
  background: var(--orange);
}
.img-preview {
  display: block;
  max-width: 150px;
  max-height: 100px;
  border-radius: 4px;
  object-fit: cover;
  margin-top: 10px;
  box-shadow: -4px 6px 16px rgba(26,18,8,0.08);
}
.form-actions {
  margin-top: 32px;
  display: flex;
  justify-content: flex-end;
}
.form-actions input[type="submit"] {
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
.form-actions input[type="submit"]:hover {
  background: var(--orange);
}

/* section divider */
.section-divider {
  height: 1px;
  background: linear-gradient(to right, transparent, rgba(26,18,8,0.08), transparent);
  margin: 0 0 56px;
}

/* menu grid */
.menu-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 28px;
}

/* menu card */
.menu-card {
  background: var(--white);
  border-radius: 4px;
  overflow: hidden;
  box-shadow: -6px 10px 30px rgba(26,18,8,0.06);
  transition: transform 0.4s cubic-bezier(0.16,1,0.3,1),
              box-shadow 0.4s cubic-bezier(0.16,1,0.3,1);
}
.menu-card:hover {
  transform: perspective(1000px) translateY(-6px) rotateX(2deg) scale(1.01);
  box-shadow: -10px 14px 50px rgba(26,18,8,0.2);
}

/* card image wrap */
.card-img-wrap {
  position: relative;
  overflow: hidden;
  height: 180px;
}
.card-img-wrap img {
  width: 100%; height: 100%;
  object-fit: cover;
  display: block;
  transition: transform 0.6s cubic-bezier(0.25,0.8,0.25,1);
}
.menu-card:hover .card-img-wrap img { transform: scale(1.07); }

/* gradient overlay */
.card-img-wrap::after {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(to top, rgba(26,18,8,0.55) 0%, transparent 50%);
  pointer-events: none;
}

/* availability badge (top-right) */
.avail-badge {
  position: absolute;
  top: 14px; right: 14px;
  z-index: 2;
  font-size: 9px;
  font-weight: 600;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  padding: 5px 12px;
  border-radius: 40px;
}
.avail-badge.active {
  background: var(--green);
  color: var(--white);
}
.avail-badge.inactive {
  background: #e53935;
  color: var(--white);
}

/* card body */
.card-body {
  padding: 18px 20px 22px;
  display: flex;
  flex-direction: column;
  flex: 1;
}
.card-body h2 {
  font-family: var(--font-display);
  font-size: 26px;
  letter-spacing: 0.04em;
  color: var(--dark);
  line-height: 0.95;
  margin-bottom: 6px;
}
.card-desc {
  font-size: 12px;
  line-height: 1.6;
  color: rgba(26,18,8,0.55);
  margin-bottom: 12px;
  flex: 1;
}

/* price + category row */
.card-meta {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 14px;
}
.card-price {
  font-family: var(--font-display);
  font-size: 24px;
  letter-spacing: 0.04em;
  color: var(--dark);
}
.card-category {
  font-size: 9px;
  font-weight: 600;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: rgba(26,18,8,0.4);
  background: rgba(26,18,8,0.05);
  padding: 4px 12px;
  border-radius: 40px;
}

/* card actions */
.card-actions {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
  padding-top: 14px;
  border-top: 1px solid rgba(26,18,8,0.06);
}
.card-actions .btn {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 10px 18px;
  border: none;
  border-radius: 2px;
  font-family: var(--font-body);
  font-size: 10px;
  font-weight: 600;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  cursor: pointer;
  text-decoration: none;
  color: var(--white);
  transition: background 0.25s;
}
.card-actions .btn:hover {
  background: var(--orange);
}
.card-actions .btn.edit {
  background: var(--dark);
}
.card-actions .btn.delete {
  background: #e53935;
}
.card-actions .btn.delete:hover {
  background: #c62828;
}

/* empty state */
.empty-state {
  grid-column: 1 / -1;
  text-align: center;
  padding: 100px 40px;
  background: var(--white);
  border-radius: 4px;
  box-shadow: -6px 10px 30px rgba(26,18,8,0.06);
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
  font-size: 14px;
  color: rgba(26,18,8,0.5);
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
  .admin-inner { padding: 40px 24px 80px; }
  .form-grid { grid-template-columns: 1fr; }
  .form-card { padding: 32px 28px; }
  .menu-grid { grid-template-columns: repeat(auto-fill, minmax(260px,1fr)); }
  .nav { padding: 0 20px; }
}
@media (max-width: 767px) {
  .admin-inner { padding: 30px 16px 60px; }
  .form-card { padding: 24px 20px; }
  .form-card h2 { font-size: 28px; }
  .menu-grid { grid-template-columns: 1fr; gap: 20px; }
  .card-img-wrap { height: 200px; }
  .card-body { padding: 16px 18px 18px; }
  .card-body h2 { font-size: 22px; }
  .form-actions input[type="submit"] { width: 100%; }
  .footer { padding: 30px 16px; }
  .footer-inner { flex-direction: column; align-items: center; text-align: center; gap: 20px; }
}
@media (max-width: 479px) {
  .admin-inner { padding: 20px 12px 40px; }
  .form-card { padding: 18px 14px; }
  .form-card h2 { font-size: 24px; }
  .card-img-wrap { height: 160px; }
  .card-body { padding: 14px 14px 16px; }
  .card-body h2 { font-size: 20px; }
  .card-price { font-size: 20px; }
  .card-actions .btn { font-size: 9px; padding: 8px 14px; }
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
Menu menu = (Menu)request.getAttribute("menu");
int restaurantId = (int)request.getAttribute("restaurantId");
List<Menu> menuList = (List<Menu>)request.getAttribute("menuList");
%>

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
    <a href="admin/dashBoard.jsp"     class="btnn primary">Dashboard</a>
    <a href="manageRestaurant.jsp"    class="btnn primary">Manage</a>
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
  <a href="admin/dashBoard.jsp"     class="btnn primary">Dashboard</a>
  <a href="manageRestaurant.jsp"    class="btnn primary">Manage</a>
  <a href="admin/adminLogin.html"   class="btnn">Admin Login</a>
</div>

<!-- admin main -->
<div class="admin-page">
  <div class="admin-inner">

    <!-- page header -->
    <div class="page-header scroll-3d">
      <h1>Manage Menu</h1>
      <p>Add, edit, or remove menu items for this restaurant.</p>
    </div>

    <!-- add / edit form -->
    <div class="form-card scroll-3d delay-1">
      <h2><%=menu == null ? "Add New Menu Items Here" : "Update Menu Here"%></h2>
      <form action="<%= request.getContextPath()%>/callMenuManager_CRUD" method="post" enctype="multipart/form-data">

        <input type="hidden" name="restaurantId" value=<%=restaurantId%>>

        <div class="form-grid">

          <div class="form-group">
            <label>Item Name</label>
            <input type="text" name="itemName" value="<%=menu!= null ? menu.getItemName():"" %>" required>
          </div>

          <div class="form-group">
            <label>Price</label>
            <input type="number" name="price" value="<%=menu!= null ? menu.getPrice():"" %>" required>
          </div>

          <div class="form-group full-width">
            <label>Description</label>
            <textarea rows="3" name="description" required><%=menu!= null ? menu.getDescription():"" %></textarea>
          </div>

          <div class="form-group">
            <label>Category</label>
            <input type="text" name="category" value="<%=menu!= null ? menu.getCategory():"" %>" required>
          </div>

          <div class="form-group">
            <label>Is Available</label>
            <select name="isAvailable" required>
              <option value="1" <%=menu != null && menu.getIsAvailable() == 1 ? "selected" : "" %>>Active</option>
              <option value="0" <%=menu != null && menu.getIsAvailable() == 0 ? "selected" : "" %>>Inactive</option>
            </select>
          </div>

          <div class="form-group full-width">
            <label>Restaurant Image</label>
            <input type="hidden" name="oldImage" value="<%=menu!= null ? menu.getImages():"" %>">
            <% if(menu != null && menu.getImages() != null && !menu.getImages().isEmpty()){ %>
              <img alt="image could not load" src="<%= request.getContextPath()%>/assets/<%=menu.getImages()%>" width="150" height="100" class="img-preview">
            <% } %>
            <input type="file" name="imageFile" accept="image/*">
          </div>

        </div>

        <input type="hidden" name="menuId" value="<%=menu!= null ? menu.getMenuId():"" %>">
        <input type="hidden" name="action" value=<%=menu == null? "add": "update" %>>

        <div class="form-actions">
          <input type="submit" value="<%=menu == null ? "Add New Item" : "Update Item" %>">
        </div>
      </form>
    </div>

    <!-- section divider -->
    <div class="section-divider scroll-3d delay-2"></div>

    <!-- menu grid -->
    <div class="menu-grid">
      <%
      if (menuList != null && !menuList.isEmpty()) {
        int idx = 0;
        for (Menu m : menuList) {
          int d = (idx % 4) + 1;
      %>
      <div class="menu-card scroll-3d delay-<%= d %>">
        <div class="card-img-wrap">
          <img alt="<%= m.getItemName() %>" src="<%=request.getContextPath() %>/assets/<%=m.getImages() %>" loading="lazy" onerror="this.style.display='none'">
          <span class="avail-badge <%= m.getIsAvailable() == 1 ? "active" : "inactive" %>"><%= m.getIsAvailable() == 1 ? "Available" : "Sold Out" %></span>
        </div>
        <div class="card-body">
          <h2><%= m.getItemName() %></h2>
          <p class="card-desc"><%= m.getDescription() %></p>
          <div class="card-meta">
            <span class="card-price">&#8377; <%= m.getPrice() %></span>
            <span class="card-category"><%= m.getIsAvailable() %></span>
          </div>
          <div class="card-actions">
            <form action="<%= request.getContextPath()%>/callMenuManager_CRUD" method="post" style="display:inline">
              <input type="hidden" name="menuId" value="<%= m.getMenuId() %>">
              <input type="hidden" name="restaurantId" value="<%= m.getRestaurantId() %>">
              <input type="hidden" name="action" value="edit">
              <button class="btn edit">Edit</button>
            </form>
            <form action="<%= request.getContextPath()%>/callMenuManager_CRUD" method="post" style="display:inline" onsubmit="return confirm('Remove <%= m.getItemName() %> from menu?')">
              <input type="hidden" name="menuId" value="<%= m.getMenuId() %>">
              <input type="hidden" name="restaurantId" value="<%= m.getRestaurantId() %>">
              <input type="hidden" name="action" value="delete">
              <button class="btn delete">Delete</button>
            </form>
          </div>
        </div>
      </div>
      <%
          idx++;
        }
      } else {
      %>
      <div class="empty-state">
        <div class="empty-emoji">&#x1F962;</div>
        <h3>No Menu Items Yet</h3>
        <p>Add one using the form above.</p>
      </div>
      <% } %>
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
      <p class="footer-copy" style="margin-bottom:16px;">&copy; 2026 Flavora. All rights reserved.</p>
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
document.querySelectorAll('a, button, .menu-card, .form-card, .btn').forEach(el => {
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
