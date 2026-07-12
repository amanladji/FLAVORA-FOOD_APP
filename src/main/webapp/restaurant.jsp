 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.tap.DAOImple.RestaurantDAOImple" %>
<%@ page import="com.tap.model.Restaurant" %>
<%@ page import="com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Restaurants — Flavora</title>

<!-- Lenis smooth scroll -->
<script src="https://cdn.jsdelivr.net/npm/@studio-freight/lenis@1.0.42/dist/lenis.min.js"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Caveat:wght@400;600&family=Inter:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400&display=swap" rel="stylesheet">

<style>
/* ════════════════════════════════════════
   TOKENS
════════════════════════════════════════ */
:root{
  --cream:#f5f0e8;
  --dark:#1a1208;
  --orange:#e85d04;
  --gold:#f4a124;
  --white:#ffffff;
  --fd:'Bebas Neue',sans-serif;
  --fs:'Caveat',cursive;
  --fb:'Inter',sans-serif;
  --nav:68px;
}

/* ════════════════════════════════════════
   BASE
════════════════════════════════════════ */
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{overflow-x:hidden}
body{
  font-family:var(--fb);
  background:var(--cream);
  color:var(--dark);
  overflow-x:hidden;
  /* Lenis requires this */
  overscroll-behavior:none;
}
img{display:block;max-width:100%}
a{text-decoration:none;color:inherit}

/* ════════════════════════════════════════
   SCROLL PROGRESS BAR
════════════════════════════════════════ */
#spbar{
  position:fixed;top:0;left:0;
  height:2px;width:0%;
  background:linear-gradient(90deg,var(--orange),var(--gold));
  z-index:9999;pointer-events:none;
}

/* ════════════════════════════════════════
   CUSTOM CURSOR  (desktop only — hidden on touch)
════════════════════════════════════════ */
.cur-dot{
  width:7px;height:7px;
  background:var(--orange);
  border-radius:50%;
  position:fixed;top:0;left:0;
  pointer-events:none;z-index:9998;
  transform:translate(-50%,-50%);
  display:none; /* shown by JS on non-touch */
}
.cur-ring{
  width:34px;height:34px;
  border:1.5px solid rgba(232,93,4,.55);
  border-radius:50%;
  position:fixed;top:0;left:0;
  pointer-events:none;z-index:9997;
  transform:translate(-50%,-50%);
  transition:width .22s,height .22s,border-color .22s,opacity .22s;
  display:none;
}
.cur-ring.big{width:54px;height:54px;border-color:rgba(232,93,4,.28)}

/* ════════════════════════════════════════
   NAV
════════════════════════════════════════ */
.nav{
  position:fixed;top:0;left:0;right:0;
  z-index:5000;height:var(--nav);
  display:flex;align-items:center;justify-content:space-between;
  padding:0 44px;
  background:rgba(245,240,232,.9);
  backdrop-filter:blur(22px);-webkit-backdrop-filter:blur(22px);
  border-bottom:1px solid rgba(26,18,8,.07);
  transition:background .4s,border-color .4s;
}
.nav.inv{
  background:rgba(26,18,8,.93);
  border-bottom-color:rgba(255,255,255,.07);
}
.nav-logo{
  font-family:var(--fd);font-size:25px;
  letter-spacing:.08em;color:var(--dark);
  line-height:1;transition:color .3s;
}
.nav.inv .nav-logo{color:var(--white)}
.nav-logo small{
  display:block;font-family:var(--fs);
  font-size:12px;color:var(--orange);
  font-style:italic;letter-spacing:.03em;margin-top:-3px;
}
.nav-links{display:flex;align-items:center;gap:4px}

/* ── shared button ── */
.btnn{
  font-family:var(--fb);font-size:11px;font-weight:500;
  letter-spacing:.15em;text-transform:uppercase;
  color:var(--dark);padding:8px 16px;border-radius:40px;
  border:1.5px solid transparent;
  transition:all .2s;cursor:pointer;background:transparent;white-space:nowrap;
}
.nav.inv .btnn{color:rgba(255,255,255,.7)}
.btnn:hover{border-color:var(--orange);color:var(--orange)}
.btnn.primary{background:var(--dark);color:var(--white);border-color:var(--dark)}
.nav.inv .btnn.primary{background:var(--orange);border-color:var(--orange)}
.btnn.primary:hover{background:var(--orange);border-color:var(--orange)}

/* user dropdown */
.u-wrap{position:relative;display:inline-block}
.u-wrap:hover .u-menu{display:block}
.u-menu{
  display:none;position:absolute;top:calc(100% + 8px);right:0;
  background:var(--white);border-radius:10px;
  box-shadow:0 12px 40px rgba(0,0,0,.13);
  padding:8px;list-style:none;min-width:140px;z-index:200;
}
.u-menu li a{
  display:block;font-family:var(--fb);font-size:11px;font-weight:500;
  letter-spacing:.12em;text-transform:uppercase;
  padding:10px 14px;border-radius:6px;color:var(--dark);
  transition:background .16s,color .16s;
}
.u-menu li a:hover{background:var(--orange);color:var(--white)}

/* hamburger */
.ham{display:none;flex-direction:column;gap:5px;cursor:pointer;padding:8px}
.ham span{display:block;width:22px;height:1.5px;background:var(--dark);transition:all .3s}
.nav.inv .ham span{background:var(--white)}

/* mobile drawer */
.drawer{
  display:none;position:fixed;
  top:var(--nav);left:0;right:0;
  background:var(--cream);padding:18px 24px 26px;
  flex-direction:column;gap:8px;
  border-bottom:1px solid rgba(26,18,8,.1);
  z-index:4999;box-shadow:0 8px 28px rgba(26,18,8,.08);
}
.drawer.open{display:flex}
.drawer .btnn{width:100%;text-align:center;border:1.5px solid rgba(26,18,8,.12)}
.drawer .btnn.primary{background:var(--dark);color:var(--white);border-color:var(--dark)}

/* ════════════════════════════════════════
   HERO
════════════════════════════════════════ */
.hero{
  min-height:100vh;background:var(--cream);
  display:flex;flex-direction:column;
  position:relative;overflow:hidden;
  padding-top:var(--nav);
}
.hw{
  padding:46px 48px 0;
  position:relative;z-index:2;
}
.hw span{
  display:block;
  font-family:var(--fd);
  font-size:clamp(66px,10.5vw,148px);
  line-height:.88;letter-spacing:.025em;color:var(--dark);
  opacity:0;transform:translateY(64px);
  animation:wr .85s cubic-bezier(.16,1,.3,1) forwards;
}
.hw span:nth-child(2){color:var(--orange);animation-delay:.18s}
.hw span:nth-child(3){animation-delay:.34s}

@keyframes wr{to{opacity:1;transform:translateY(0)}}

.hb{
  flex:1;display:grid;grid-template-columns:1fr auto 1fr;
  align-items:center;padding:0 48px 36px;gap:32px;
  position:relative;z-index:2;
}
.hl{display:flex;flex-direction:column;gap:20px}
.htag{
  font-family:var(--fd);font-size:clamp(16px,2.2vw,24px);
  letter-spacing:.06em;color:var(--orange);
  opacity:0;animation:wr .8s .5s cubic-bezier(.16,1,.3,1) forwards;
}
.hlinks{
  display:flex;flex-direction:column;gap:10px;
  opacity:0;animation:wr .8s .65s cubic-bezier(.16,1,.3,1) forwards;
}
.hlinks a{
  font-family:var(--fb);font-size:11px;font-weight:500;
  letter-spacing:.2em;text-transform:uppercase;color:var(--dark);
  display:inline-flex;align-items:center;gap:8px;transition:color .2s,gap .22s;
}
.hlinks a::after{content:'→';transition:transform .2s}
.hlinks a:hover{color:var(--orange);gap:14px}

/* glow disk */
.disk{
  position:relative;width:clamp(240px,27vw,410px);
  aspect-ratio:1;display:flex;align-items:center;justify-content:center;
}
.disk-glow{
  position:absolute;inset:0;border-radius:50%;
  background:radial-gradient(circle,rgba(244,161,36,.42) 0%,transparent 70%);
  animation:sg 18s linear infinite;
}
@keyframes sg{to{transform:rotate(360deg)}}
.disk-ico{
  font-size:clamp(86px,12vw,158px);line-height:1;
  position:relative;z-index:1;
  filter:drop-shadow(0 22px 44px rgba(232,93,4,.26));
  animation:hf 4.2s ease-in-out infinite;
  will-change:transform;
}
@keyframes hf{
  0%,100%{transform:translateY(0) rotate(-2deg)}
  50%{transform:translateY(-16px) rotate(2deg)}
}

.hr{display:flex;flex-direction:column;align-items:flex-end;gap:18px;text-align:right}
.hpron{
  font-family:var(--fb);font-size:12px;font-weight:300;font-style:italic;
  color:rgba(26,18,8,.42);letter-spacing:.04em;
  opacity:0;animation:wr .8s .55s cubic-bezier(.16,1,.3,1) forwards;
}
.hdesc{
  font-family:var(--fb);font-size:13.5px;line-height:1.75;
  color:rgba(26,18,8,.6);max-width:226px;
  opacity:0;animation:wr .8s .7s cubic-bezier(.16,1,.3,1) forwards;
}
.hbtn{
  display:inline-flex;align-items:center;gap:10px;
  background:var(--dark);color:var(--white);
  font-family:var(--fb);font-size:11px;font-weight:500;
  letter-spacing:.18em;text-transform:uppercase;
  padding:13px 28px;border-radius:40px;
  transition:background .24s,gap .22s;
  opacity:0;animation:wr .8s .88s cubic-bezier(.16,1,.3,1) forwards;
}
.hbtn:hover{background:var(--orange);gap:16px}
.hbtn em{font-style:normal;font-size:14px;transition:transform .2s}
.hbtn:hover em{transform:translateX(4px)}

.hs{
  display:flex;justify-content:space-between;align-items:flex-end;
  padding:0 48px 16px;position:relative;z-index:2;
  opacity:0;animation:wr 1s .44s cubic-bezier(.16,1,.3,1) forwards;
}
.hs .bw{
  font-family:var(--fd);font-size:clamp(54px,9.5vw,130px);
  line-height:.85;letter-spacing:.03em;color:var(--dark);
}
.hs .bw.ac{color:var(--orange)}

/* ════════════════════════════════════════
   VIDEO SECTION
════════════════════════════════════════ */
.vsec{position:relative;height:100vh;overflow:hidden;background:var(--dark)}
.vsec video{position:absolute;inset:0;width:100%;height:100%;object-fit:cover;z-index:0}
.vov{
  position:absolute;inset:0;z-index:1;
  background:linear-gradient(to bottom,rgba(26,18,8,.2) 0%,rgba(26,18,8,.72) 100%);
}
.vc{
  position:relative;z-index:2;height:100%;
  display:flex;flex-direction:column;
  justify-content:center;align-items:center;
  text-align:center;padding:0 48px;
}
.ve{font-family:var(--fb);font-size:10px;font-weight:500;letter-spacing:.28em;text-transform:uppercase;color:var(--gold);margin-bottom:18px}
.vt{font-family:var(--fd);font-size:clamp(50px,8vw,108px);line-height:.88;letter-spacing:.03em;color:var(--white);margin-bottom:10px}
.vs{font-family:var(--fs);font-size:clamp(18px,2.4vw,28px);color:var(--gold);font-style:italic;margin-bottom:20px}
.vbd{font-family:var(--fb);font-size:14px;line-height:1.8;color:rgba(255,255,255,.6);max-width:400px}
.vbd em{color:var(--gold);font-style:normal}

/* ════════════════════════════════════════
   TICKER
════════════════════════════════════════ */
.tk{overflow:hidden;background:var(--dark);padding:13px 0;user-select:none}
.tk.light{background:var(--orange)}
.tk-t{display:flex;white-space:nowrap;animation:tkr 30s linear infinite}
.tk:hover .tk-t{animation-play-state:paused}
.tk.rev .tk-t{animation-direction:reverse}
.tk-t s{font-family:var(--fd);font-size:14px;letter-spacing:.18em;text-transform:uppercase;color:var(--white);text-decoration:none;padding:0 34px;flex-shrink:0}
.tk.light .tk-t s{color:var(--white)}
.tk-t .td{padding:0 2px;color:var(--gold);font-size:16px}
.tk.light .tk-t .td{color:rgba(26,18,8,.6)}
@keyframes tkr{from{transform:translateX(0)}to{transform:translateX(-50%)}}

/* ════════════════════════════════════════
   STATS
════════════════════════════════════════ */
.stats{
  background:var(--dark);
  display:grid;grid-template-columns:repeat(4,1fr);
  padding:72px 48px;
}
.stt{text-align:center;padding:16px;border-right:1px solid rgba(255,255,255,.07)}
.stt:last-child{border-right:none}
.stn{font-family:var(--fd);font-size:clamp(44px,5vw,68px);color:var(--gold);letter-spacing:.04em;line-height:1}
.stl{font-family:var(--fb);font-size:10px;font-weight:400;letter-spacing:.2em;text-transform:uppercase;color:rgba(255,255,255,.4);margin-top:8px}

/* ════════════════════════════════════════
   SECTION INTRO
════════════════════════════════════════ */
.intro{padding:90px 48px 48px;background:var(--cream);text-align:center}
.ey{font-family:var(--fb);font-size:10px;font-weight:500;letter-spacing:.28em;text-transform:uppercase;color:var(--orange);margin-bottom:16px}
.ib{font-family:var(--fd);font-size:clamp(42px,7vw,90px);line-height:.9;letter-spacing:.035em;color:var(--dark)}
.isc{font-family:var(--fs);font-size:clamp(18px,2.8vw,30px);color:var(--orange);font-style:italic;margin-top:10px}

/* search */
.srch{
  max-width:520px;margin:34px auto 0;
  display:flex;align-items:center;
  background:var(--white);
  border:1.5px solid rgba(26,18,8,.12);
  border-radius:40px;padding:6px 6px 6px 22px;
  box-shadow:0 8px 28px rgba(26,18,8,.06);
  transition:border-color .3s,box-shadow .3s;
}
.srch:focus-within{border-color:var(--orange);box-shadow:0 8px 36px rgba(232,93,4,.12)}
.srch input{
  flex:1;border:none;background:transparent;
  font-family:var(--fb);font-size:13.5px;color:var(--dark);outline:none;
}
.srch input::placeholder{color:#bbb;font-style:italic}
.sb{
  background:var(--dark);color:var(--white);border:none;border-radius:32px;
  padding:11px 24px;font-family:var(--fb);font-size:10px;font-weight:500;
  letter-spacing:.14em;text-transform:uppercase;cursor:pointer;transition:background .24s;
}
.sb:hover{background:var(--orange)}

/* pills */
.pills{
  display:flex;justify-content:center;gap:8px;flex-wrap:wrap;
  padding:26px 48px 0;background:var(--cream);
}
.pill{
  font-family:var(--fb);font-size:10px;font-weight:500;
  letter-spacing:.14em;text-transform:uppercase;
  padding:8px 20px;border-radius:40px;
  border:1.5px solid rgba(26,18,8,.18);
  background:transparent;color:var(--dark);
  cursor:pointer;transition:all .2s;
}
.pill:hover,.pill.on{background:var(--dark);color:var(--white);border-color:var(--dark)}

/* ════════════════════════════════════════
   ╔══════════════════════════════════════╗
   ║  2×3 PAGE CAROUSEL                  ║
   ║  Each page = 2 rows × 3 cols = 6    ║
   ║  cards. Snaps page-by-page.          ║
   ╚══════════════════════════════════════╝
════════════════════════════════════════ */
.car-sec{
  background:var(--cream);
  padding:48px 0 72px;
  position:relative;
}

/* header row above carousel */
.car-hdr{
  display:flex;align-items:center;justify-content:space-between;
  padding:0 48px 24px;
}
.car-hdr-left{display:flex;align-items:baseline;gap:14px}
.car-count{
  font-family:var(--fd);font-size:14px;letter-spacing:.1em;
  color:rgba(26,18,8,.3);text-transform:uppercase;
}

/* arrow buttons */
.car-arrows{display:flex;gap:10px}
.arrow-btn{
  width:44px;height:44px;border-radius:50%;
  border:1.5px solid rgba(26,18,8,.18);
  background:var(--white);
  display:flex;align-items:center;justify-content:center;
  cursor:pointer;transition:all .22s;color:var(--dark);
}
.arrow-btn:hover{background:var(--dark);color:var(--white);border-color:var(--dark)}
.arrow-btn svg{width:16px;height:16px;stroke:currentColor;stroke-width:2.3;fill:none}

/*
  The outer wrapper clips overflow.
  The track is a FLEX ROW of "pages".
  Each page is a 2×3 CSS grid.
*/
.car-outer{
  overflow:hidden;   /* clip — no native scrollbar */
  position:relative;
}

.car-track{
  display:flex;
  /* We'll set width and translate via JS */
  will-change:transform;
  /* smooth transition controlled by JS momentum */
  transition:transform 0s; /* JS overrides this */
}

/* One "page" = exactly the viewport-wide slide */
.car-page{
  flex:0 0 100%;      /* full width each */
  width:100%;
  padding:0 48px;
  display:grid;
  grid-template-columns:repeat(3,1fr);
  grid-template-rows:auto auto;
  gap:24px;
}

/* on mobile: 1 column */
@media(max-width:700px){
  .car-page{
    grid-template-columns:1fr;
    padding:0 20px;
  }
  .car-hdr,.car-hdr-left{padding-left:20px;padding-right:20px}
}
@media(min-width:701px) and (max-width:1000px){
  .car-page{
    grid-template-columns:repeat(2,1fr);
    padding:0 28px;
  }
}

/* ═══ CARD ═══ */
.ccard{
  background:var(--white);
  border-radius:4px;overflow:hidden;
  position:relative;cursor:pointer;
  /* AOS initial state */
  opacity:0;transform:translateY(40px);
  transition:
    opacity .75s cubic-bezier(.16,1,.3,1),
    transform .85s cubic-bezier(.16,1,.3,1),
    box-shadow .3s;
}
.ccard.show{opacity:1;transform:translateY(0)}
.ccard:hover{
  box-shadow:-8px 12px 44px rgba(26,18,8,.18);
  transform:translateY(-6px) !important;
}

/* image */
.ci{position:relative;height:196px;overflow:hidden}
.ci img{width:100%;height:100%;object-fit:cover;transition:transform .55s cubic-bezier(.25,.8,.25,1)}
.ccard:hover .ci img{transform:scale(1.06)}
.ci::after{content:'';position:absolute;inset:0;background:linear-gradient(to top,rgba(26,18,8,.52) 0%,transparent 50%);pointer-events:none}
.ctag{position:absolute;top:12px;left:12px;background:var(--dark);color:var(--white);font-family:var(--fb);font-size:9px;font-weight:600;letter-spacing:.2em;text-transform:uppercase;padding:4px 11px;border-radius:40px}
.crat{position:absolute;top:12px;right:12px;background:var(--gold);color:var(--dark);font-family:var(--fb);font-size:11px;font-weight:700;padding:4px 10px;border-radius:40px}
.ctim{position:absolute;bottom:10px;left:12px;z-index:1;font-family:var(--fb);font-size:10px;font-weight:400;letter-spacing:.08em;color:rgba(255,255,255,.86);display:flex;align-items:center;gap:4px}

/* body */
.cb{padding:18px 20px 20px}
.cn{font-family:var(--fd);font-size:25px;letter-spacing:.04em;color:var(--dark);text-transform:uppercase;line-height:.95;margin-bottom:8px}
.ca{font-family:var(--fb);font-size:12px;color:rgba(26,18,8,.45);line-height:1.5;margin-bottom:14px;display:flex;align-items:flex-start;gap:5px}
.ca svg{flex-shrink:0;margin-top:1px;opacity:.4}
.cst{display:inline-flex;align-items:center;gap:5px;font-family:var(--fb);font-size:9px;font-weight:500;letter-spacing:.14em;text-transform:uppercase;color:rgba(26,18,8,.4);margin-bottom:14px}
.sdot{width:5px;height:5px;border-radius:50%;background:#4caf50;animation:sp 2s ease-in-out infinite}
@keyframes sp{0%,100%{opacity:1;transform:scale(1)}50%{opacity:.4;transform:scale(.8)}}
.cbtn{
  display:flex;align-items:center;justify-content:space-between;
  width:100%;background:var(--dark);color:var(--white);
  font-family:var(--fb);font-size:10px;font-weight:500;letter-spacing:.16em;text-transform:uppercase;
  padding:12px 18px;border-radius:20px;text-decoration:none;
  position:relative;overflow:hidden;
}
.cbtn::before{
  content:'';position:absolute;top:0;left:-100%;
  width:100%;height:100%;background:var(--orange);
  transition:left .3s cubic-bezier(.25,.8,.25,1);z-index:0;
}
.cbtn:hover::before{left:0}
.cbtn span,.cbtn svg{position:relative;z-index:1}
.cbtn svg{stroke:currentColor;fill:none;stroke-width:2.4;transition:transform .22s}
.cbtn:hover svg{transform:translateX(5px)}

/* dots */
.car-dots{display:flex;justify-content:center;gap:8px;margin-top:28px}
.dp{width:6px;height:6px;border-radius:50%;background:rgba(26,18,8,.2);cursor:pointer;transition:all .3s}
.dp.on{background:var(--orange);width:22px;border-radius:3px}

/* empty */
.empty{text-align:center;padding:80px 40px;width:100%}
.empty-i{font-size:52px;margin-bottom:14px}
.empty h3{font-family:var(--fd);font-size:36px;letter-spacing:.04em;color:var(--dark);margin-bottom:8px}
.empty p{font-family:var(--fb);font-size:13px;color:rgba(26,18,8,.45)}

/* ════════════════════════════════════════
   DARK FEATURE
════════════════════════════════════════ */
.df{
  background:var(--dark);
  display:grid;grid-template-columns:1fr 1fr;
  gap:60px;align-items:center;padding:90px 48px;
  position:relative;overflow:hidden;
}
.df::before{
  content:'';position:absolute;top:-80px;right:-80px;
  width:340px;height:340px;border-radius:50%;
  background:radial-gradient(circle,rgba(244,161,36,.13) 0%,transparent 70%);
  pointer-events:none;
}
.dfe{font-family:var(--fb);font-size:10px;font-weight:500;letter-spacing:.28em;text-transform:uppercase;color:var(--gold);margin-bottom:18px}
.dfb{font-family:var(--fd);font-size:clamp(40px,5.5vw,74px);line-height:.9;letter-spacing:.03em;color:var(--white);margin-bottom:8px}
.dfs{font-family:var(--fs);font-size:clamp(17px,2.2vw,26px);color:var(--gold);font-style:italic;margin-bottom:22px}
.dfd{font-family:var(--fb);font-size:13.5px;line-height:1.85;color:rgba(255,255,255,.55);max-width:330px}
.df-ico{font-size:clamp(68px,11vw,148px);text-align:center;filter:drop-shadow(0 20px 50px rgba(244,161,36,.28));animation:hf 5s ease-in-out infinite}

/* ════════════════════════════════════════
   MINI SECTION
════════════════════════════════════════ */
.ms{background:var(--cream);padding:90px 48px;position:relative;overflow:hidden;text-align:center}
.ms-bg{
  position:absolute;inset:0;display:flex;align-items:center;justify-content:center;
  font-family:var(--fd);font-size:clamp(70px,14vw,180px);
  color:rgba(26,18,8,.03);letter-spacing:.08em;pointer-events:none;white-space:nowrap;overflow:hidden;
}
.mg{display:flex;gap:18px;justify-content:center;flex-wrap:wrap;position:relative;z-index:1;margin-top:40px}
.mc{
  background:var(--white);border-radius:4px;padding:26px 22px;width:196px;text-align:center;
  box-shadow:-5px 7px 28px rgba(26,18,8,.07);
  transition:transform .38s cubic-bezier(.16,1,.3,1),box-shadow .3s;
}
.mc:hover{transform:translateY(-8px);box-shadow:-8px 14px 38px rgba(26,18,8,.13)}
.mc-i{font-size:32px;margin-bottom:10px}
.mc-t{font-family:var(--fd);font-size:21px;letter-spacing:.04em;color:var(--dark);margin-bottom:4px}
.mc-s{font-family:var(--fb);font-size:10px;font-weight:400;letter-spacing:.1em;text-transform:uppercase;color:rgba(26,18,8,.4)}

/* ════════════════════════════════════════
   FOOTER
════════════════════════════════════════ */
.ft{background:var(--dark);padding:54px 48px 34px;position:relative;overflow:hidden}
.ft-bg{
  position:absolute;bottom:-16px;left:0;right:0;text-align:center;
  font-family:var(--fd);font-size:clamp(58px,12vw,160px);
  color:rgba(255,255,255,.025);letter-spacing:.08em;pointer-events:none;
}
.ft-in{
  max-width:1200px;margin:0 auto;
  display:flex;justify-content:space-between;align-items:flex-end;
  flex-wrap:wrap;gap:24px;position:relative;z-index:1;
}
.ft-brand{font-family:var(--fd);font-size:42px;letter-spacing:.07em;color:var(--white);line-height:.9}
.ft-brand small{display:block;font-family:var(--fs);font-size:15px;color:var(--gold);font-style:italic;letter-spacing:.04em;margin-top:4px}
.ft-r{text-align:right}
.ft-copy{font-family:var(--fb);font-size:10px;letter-spacing:.1em;text-transform:uppercase;color:rgba(255,255,255,.28);margin-bottom:14px}
.ft-top{
  display:inline-flex;align-items:center;gap:7px;
  font-family:var(--fb);font-size:10px;font-weight:500;letter-spacing:.16em;text-transform:uppercase;
  color:var(--gold);border:1px solid rgba(244,161,36,.3);padding:9px 20px;border-radius:40px;
  transition:all .24s;
}
.ft-top:hover{background:var(--gold);color:var(--dark);border-color:var(--gold)}

/* ════════════════════════════════════════
   AOS — animate on scroll
════════════════════════════════════════ */
.af{opacity:0;transform:translateY(34px);transition:opacity .85s cubic-bezier(.16,1,.3,1),transform .95s cubic-bezier(.16,1,.3,1)}
.al{opacity:0;transform:translateX(-46px);transition:opacity .9s cubic-bezier(.16,1,.3,1),transform 1.05s cubic-bezier(.16,1,.3,1)}
.ar{opacity:0;transform:translateX(46px);transition:opacity .9s cubic-bezier(.16,1,.3,1),transform 1.05s cubic-bezier(.16,1,.3,1)}
.af.show,.al.show,.ar.show{opacity:1;transform:translate(0)}
.d1{transition-delay:.06s}.d2{transition-delay:.12s}.d3{transition-delay:.19s}.d4{transition-delay:.26s}

/* ════════════════════════════════════════
   RESPONSIVE
════════════════════════════════════════ */
@media(max-width:960px){
  .hb{grid-template-columns:1fr;text-align:center;gap:16px}
  .hr{align-items:center;text-align:center}
  .hlinks{display:none}
  .hw{padding:34px 24px 0}
  .hs{padding:0 24px 12px}
  .stats{grid-template-columns:1fr 1fr}
  .df{grid-template-columns:1fr;gap:30px}
  .intro,.ms,.ft{padding-left:24px;padding-right:24px}
  .vc{padding:0 24px}
  .pills{padding:22px 24px 0}
  .nav{padding:0 20px}
  .nav-links{display:none}
  .ham{display:flex}
  .car-hdr{padding:0 24px 20px}
}
@media(max-width:600px){
  .stats{grid-template-columns:1fr 1fr}
  .disk{width:190px}
  .disk-ico{font-size:78px}
  .df{padding:56px 20px}
  .mg{gap:12px}
  .mc{width:150px;padding:20px 14px}
}
@media(prefers-reduced-motion:reduce){
  *,*::before,*::after{animation:none !important;transition-duration:.01ms !important}
}
</style>
</head>
<body>

<div id="spbar"></div>
<div class="cur-dot" id="cdot"></div>
<div class="cur-ring" id="cring"></div>

<!-- ══════════════════════════════════════
     NAV
══════════════════════════════════════ -->
<nav class="nav" id="mainNav">
  <a href="restaurantServlet" class="nav-logo">
    FLAVORA<small><em>fine food delivery</em></small>
  </a>

  <div class="nav-links" id="navDsk">
    <a href="callOrderHistoryServlet" class="btnn">Order History</a>
    <a href="cart.jsp"                class="btnn">Cart</a>
    <%User user=(User)session.getAttribute("user");%>
    <%if(user==null){%>
      <a href="register.html" class="btnn">Sign Up</a>
      <a href="login.jsp"     class="btnn primary">Login</a>
    <%}%>
    <a href="admin/dashBoard.jsp" class="btnn primary">Admin Dashboard</a>
    <div class="u-wrap">
      <div class="btnn primary" style="cursor:pointer;">
        👤 <%=user!=null?user.getUserName():"User"%>
      </div>
      <ul class="u-menu">
        <%if(user != null){ %>
        <li><a href="<%=request.getContextPath()%>/callLogoutServlet">Logout</a></li>
        <li><a href="<%=request.getContextPath()%>/callProfileServlet">Profile</a></li>
        <%} %>
      </ul>
    </div>
  </div>

  <div class="ham" id="hamBtn" onclick="toggleDrawer()">
    <span></span><span></span><span></span>
  </div>
</nav>

<div class="drawer" id="navDrawer">
  <a href="callOrderHistoryServlet" class="btnn">Order History</a>
  <a href="cart.jsp"                class="btnn">Cart</a>
  <%if(user==null){%>
    <a href="register.html" class="btnn">Sign Up</a>
    <a href="login.jsp"     class="btnn primary">Login</a>
  <%}%>
  <a href="admin/dashBoard.jsp" class="btnn primary">Admin Dashboard</a>
  <a href="<%=request.getContextPath()%>/callLogoutServlet" class="btnn">Logout</a>
</div>

<!-- ══════════════════════════════════════
     HERO
══════════════════════════════════════ -->
<section class="hero" id="hero">
  <div class="hw">
    <span>Fresh.</span>
    <span>Fast.</span>
    <span>Flavourful.</span>
  </div>

  <div class="hb" id="heroTilt">
    <div class="hl">
      <p class="htag">#TasteTheCity</p>
      <div class="hlinks">
        <a href="#restaurants">Browse Restaurants</a>
        <a href="#why">Why Flavora</a>
      </div>
    </div>

    <div class="disk">
      <div class="disk-glow"></div>
      <div class="disk-ico" id="heroEmoji">🍽️</div>
    </div>

    <div class="hr">
      <p class="hpron"><em>flavora — taste the city</em></p>
      <p class="hdesc">More than delivery — a curated experience bringing the city's finest kitchens straight to your door.</p>
      <a href="#restaurants" class="hbtn">Discover restaurants <em>→</em></a>
    </div>
  </div>

  <div class="hs">
    <div class="bw">ORDER</div>
    <div class="bw ac">NOW</div>
  </div>
</section>

<!-- ══════════════════════════════════════
     VIDEO
══════════════════════════════════════ -->
<section class="vsec">
  <video autoplay muted loop playsinline>
    <source source src="${pageContext.request.contextPath}/assets/videos/kitchen-bg.mp4" type="video/mp4">
  </video>
  <div class="vov"></div>
  <div class="vc af">
    <p class="ve">✦ From our kitchen ✦</p>
    <h2 class="vt">Crafted<br>with Passion</h2>
    <p class="vs"><em>every dish, a masterpiece</em></p>
    <p class="vbd">Fresh ingredients, skilled chefs,<br>and a dedication to <em>flavour</em> — every order.</p>
  </div>
</section>

<!-- ticker 1 -->
<div class="tk"><div class="tk-t" id="tk1"></div></div>

<!-- ══════════════════════════════════════
     STATS
══════════════════════════════════════ -->
<div class="stats">
  <div class="stt af d1"><div class="stn">120+</div><div class="stl">Restaurants</div></div>
  <div class="stt af d2"><div class="stn">30 min</div><div class="stl">Avg Delivery</div></div>
  <div class="stt af d3"><div class="stn">4.8 ★</div><div class="stl">Avg Rating</div></div>
  <div class="stt af d4"><div class="stn">50k+</div><div class="stl">Happy Customers</div></div>
</div>

<!-- ══════════════════════════════════════
     INTRO + SEARCH
══════════════════════════════════════ -->
<section class="intro" id="restaurants">
  <p class="ey af">✦ Browse &amp; discover ✦</p>
  <h2 class="ib af d1">Our<br>Restaurants</h2>
  <p class="isc af d2"><em>Handpicked kitchens. Extraordinary flavour.</em></p>
  <div class="srch af d3">
    <input type="text" id="searchInput" placeholder="Search cuisine or restaurant…" oninput="applyFilters()">
    <button class="sb">Search</button>
  </div>
</section>

<div class="pills af" style="background:var(--cream)">
  <button class="pill on" onclick="setFilter(this,'')">All</button>
  <button class="pill" onclick="setFilter(this,'indian')">Indian</button>
  <button class="pill" onclick="setFilter(this,'chinese')">Chinese</button>
  <button class="pill" onclick="setFilter(this,'italian')">Italian</button>
  <button class="pill" onclick="setFilter(this,'fast food')">Fast Food</button>
  <button class="pill" onclick="setFilter(this,'biryani')">Biryani</button>
  <button class="pill" onclick="setFilter(this,'pizza')">Pizza</button>
</div>

<!-- ══════════════════════════════════════
     2×3 PAGE CAROUSEL
══════════════════════════════════════ -->
<section class="car-sec" id="carSec">

  <div class="car-hdr af">
    <div class="car-hdr-left">
      <p class="ey" style="margin:0">Your restaurants</p>
      <span class="car-count" id="carCount"></span>
    </div>
    <div class="car-arrows">
      <button class="arrow-btn" id="carPrev" aria-label="Previous">
        <svg viewBox="0 0 24 24"><polyline points="15 18 9 12 15 6"/></svg>
      </button>
      <button class="arrow-btn" id="carNext" aria-label="Next">
        <svg viewBox="0 0 24 24"><polyline points="9 6 15 12 9 18"/></svg>
      </button>
    </div>
  </div>

  <div class="car-outer" id="carOuter">
    <div class="car-track" id="carTrack">

      <%-- Pages will be built by JS from the flat card list below --%>
      <%-- We render all cards first inside a hidden container --%>

    </div>
  </div>

  <div class="car-dots" id="carDots"></div>
</section>

<%-- Hidden flat card pool — JS will paginate these into 2×3 grids --%>
<div id="cardPool" style="display:none">
<%
List<Restaurant> restaurantList=(List<Restaurant>)request.getAttribute("restaurantList");
if(restaurantList!=null && !restaurantList.isEmpty()){
  for(Restaurant r:restaurantList){
%>
<div class="ccard"
     data-cuisine="<%=r.getCuisineType()!=null?r.getCuisineType().toLowerCase():""%>"
     data-name="<%=r.getName()!=null?r.getName().toLowerCase():""%>">
  <div class="ci">
    <img alt="<%=r.getName()%>" src="assets/<%=r.getImages()%>" loading="lazy">
    <div class="ctag"><%=r.getCuisineType()%></div>
    <div class="crat">⭐ <%=r.getRating()%></div>
    <div class="ctim">
      <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
      <%=r.getDeliveryTime()%> mins
    </div>
  </div>
  <div class="cb">
    <h2 class="cn"><%=r.getName()%></h2>
    <p class="ca">
      <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0118 0z"/><circle cx="12" cy="10" r="3"/></svg>
      <%=r.getAddress()%>
    </p>
    <div class="cst">
      <span class="sdot"></span>
      <span><%=r.getIsActive()==1?"Available":"Not Available"%></span>
    </div>
    <a href="callMenuServlet?restaurantId=<%=r.getRestaurantId()%>" class="cbtn">
      <span>View Restaurant</span>
      <svg width="15" height="15" viewBox="0 0 24 24"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
    </a>
  </div>
</div>
<%}}else{%>
<div class="empty" style="display:block">
  <div class="empty-i">🍽️</div>
  <h3>No Restaurants Yet</h3>
  <p>Great things are cooking. Check back soon.</p>
</div>
<%}%>
</div>

<!-- ticker 2 -->
<div class="tk light rev"><div class="tk-t" id="tk2"></div></div>

<!-- ══════════════════════════════════════
     DARK FEATURE
══════════════════════════════════════ -->
<section class="df" id="why">
  <div class="al">
    <p class="dfe">✦ Why Flavora ✦</p>
    <h2 class="dfb">Crafted<br>with Care</h2>
    <p class="dfs"><em>every meal, a moment of joy</em></p>
    <p class="dfd">We partner only with kitchens that treat ingredients with respect — fresh produce sourced daily, recipes refined over generations, delivered to the people who matter most. No shortcuts. Just flavour.</p>
  </div>
  <div class="ar">
    <div class="df-ico">🥘</div>
  </div>
</section>

<!-- ══════════════════════════════════════
     MINI CARDS
══════════════════════════════════════ -->
<section class="ms">
  <div class="ms-bg">FLAVORA</div>
  <p class="ey af">✦ Always nearby ✦</p>
  <h2 class="ib af d1">Order from<br>Anywhere</h2>
  <p class="isc af d2"><em>the city's best food, one tap away</em></p>
  <div class="mg af d3">
    <div class="mc"><div class="mc-i">🛵</div><div class="mc-t">Fast</div><div class="mc-s">Delivery</div></div>
    <div class="mc"><div class="mc-i">🌿</div><div class="mc-t">Fresh</div><div class="mc-s">Ingredients</div></div>
    <div class="mc"><div class="mc-i">⭐</div><div class="mc-t">Rated</div><div class="mc-s">Kitchens</div></div>
    <div class="mc"><div class="mc-i">🔒</div><div class="mc-t">Secure</div><div class="mc-s">Payments</div></div>
  </div>
</section>

<!-- ══════════════════════════════════════
     FOOTER
══════════════════════════════════════ -->
<footer class="ft">
  <div class="ft-bg">FLAVORA</div>
  <div class="ft-in">
    <div class="ft-brand">FLAVORA<small><em>fine food delivery</em></small></div>
    <div class="ft-r">
      <p class="ft-copy">© 2026 Flavora. All rights reserved.</p>
      <a href="#hero" class="ft-top">Back to top ↑</a>
    </div>
  </div>
</footer>

<!-- ══════════════════════════════════════
     SCRIPTS
══════════════════════════════════════ -->
<script>
/* ═══════════════════════════════
   1. LENIS PREMIUM SMOOTH SCROLL
═══════════════════════════════ */
const lenis = new Lenis({
  duration: 1.3,           /* scroll duration — Apple-like */
  easing: t => Math.min(1, 1.001 - Math.pow(2, -10 * t)), /* expo-out */
  direction: 'vertical',
  gestureDirection: 'vertical',
  smooth: true,
  smoothTouch: false,      /* native feel on touch */
  touchMultiplier: 2,
});

function lenisRAF(time){ lenis.raf(time); requestAnimationFrame(lenisRAF); }
requestAnimationFrame(lenisRAF);

/* ═══════════════════════════════
   2. SCROLL PROGRESS BAR
═══════════════════════════════ */
const spbar = document.getElementById('spbar');
lenis.on('scroll', ({ progress }) => {
  spbar.style.width = (progress * 100) + '%';
});

/* ═══════════════════════════════
   3. NAV INVERT
═══════════════════════════════ */
const mainNav = document.getElementById('mainNav');
lenis.on('scroll', ({ scroll }) => {
  mainNav.classList.toggle('inv', scroll > window.innerHeight - 80);
});

/* ═══════════════════════════════
   4. MOBILE DRAWER
═══════════════════════════════ */
const drawer = document.getElementById('navDrawer');
function toggleDrawer(){ drawer.classList.toggle('open'); }

/* ═══════════════════════════════
   5. CUSTOM CURSOR — DESKTOP ONLY
═══════════════════════════════ */
const isTouch = window.matchMedia('(pointer:coarse)').matches;
const cdot  = document.getElementById('cdot');
const cring = document.getElementById('cring');

if(!isTouch){
  cdot.style.display  = 'block';
  cring.style.display = 'block';
  let mx=0, my=0, rx=0, ry=0;
  document.addEventListener('mousemove', e=>{ mx=e.clientX; my=e.clientY; });
  (function raf(){
    rx += (mx-rx) * .13;
    ry += (my-ry) * .13;
    cdot.style.left  = mx+'px'; cdot.style.top  = my+'px';
    cring.style.left = rx+'px'; cring.style.top = ry+'px';
    requestAnimationFrame(raf);
  })();
  document.querySelectorAll('a,button,.ccard,.pill,.arrow-btn,.mc').forEach(el=>{
    el.addEventListener('mouseenter',()=>cring.classList.add('big'));
    el.addEventListener('mouseleave',()=>cring.classList.remove('big'));
  });
}

/* ═══════════════════════════════
   6. TICKERS
═══════════════════════════════ */
function buildTicker(id, words){
  const t = document.getElementById(id);
  if(!t) return;
  const all = [...words,...words];
  all.forEach((w,i)=>{
    const s=document.createElement('s'); s.textContent=w; t.appendChild(s);
    if(i<all.length-1){ const d=document.createElement('span'); d.className='td'; d.textContent=' ✦ '; t.appendChild(d); }
  });
}
buildTicker('tk1',['Fresh Delivery','Top Restaurants','Fast & Reliable','Order Now','Premium Kitchens','Great Taste','Fresh Delivery','Top Restaurants','Fast & Reliable','Order Now']);
buildTicker('tk2',["City's Finest","Rated 4.8 Stars","30 Min Delivery","50k+ Orders","Eat Well","Flavora","City's Finest","Rated 4.8 Stars","30 Min Delivery","50k+ Orders"]);

/* ═══════════════════════════════
   7. AOS — scroll reveal
═══════════════════════════════ */
const aosEls = document.querySelectorAll('.af,.al,.ar,.ccard');
const aio = new IntersectionObserver(entries=>{
  entries.forEach(e=>{
    if(e.isIntersecting){ e.target.classList.add('show'); aio.unobserve(e.target); }
  });
},{threshold:0.1, rootMargin:'0px 0px -44px 0px'});

aosEls.forEach((el,i)=>{
  const r=el.getBoundingClientRect();
  if(r.top < window.innerHeight-60){ setTimeout(()=>el.classList.add('show'), i*36); }
  else{ aio.observe(el); }
});

/* ═══════════════════════════════
   8. HERO MOUSE TILT (desktop)
═══════════════════════════════ */
if(!isTouch){
  const ht  = document.getElementById('heroTilt');
  const he  = document.getElementById('heroEmoji');
  const hs  = document.querySelector('.hero');
  hs.addEventListener('mousemove', e=>{
    const r=hs.getBoundingClientRect();
    const dx=(e.clientX-r.left-r.width/2)/r.width;
    const dy=(e.clientY-r.top-r.height/2)/r.height;
    ht.style.transform=`perspective(900px) rotateX(${dy*-5}deg) rotateY(${dx*5}deg)`;
    he.style.transform=`translateZ(34px) rotateX(${dy*-2.5}deg) rotateY(${dx*2.5}deg)`;
  });
  hs.addEventListener('mouseleave',()=>{
    ht.style.transition='transform .6s cubic-bezier(.16,1,.3,1)';
    he.style.transition='transform .6s cubic-bezier(.16,1,.3,1)';
    ht.style.transform='perspective(900px) rotateX(0) rotateY(0)';
    he.style.transform='translateZ(0)';
  });
  hs.addEventListener('mouseenter',()=>{
    ht.style.transition='transform .1s ease-out';
    he.style.transition='transform .1s ease-out';
  });
}

/* ═══════════════════════════════
   9. 2×3 PAGE CAROUSEL
   Logic:
   • Collect all .ccard from #cardPool
   • Group into pages of 6 (2 rows × 3 cols)
   • On mobile (≤700px) → 1 col → pages of 2
   • On tablet (≤1000px) → 2 col → pages of 4
   • Momentum-based JS translate (no CSS scroll)
   • Arrow btn / dot → snap to page
   • Touch swipe supported
═══════════════════════════════ */
const pool       = document.getElementById('cardPool');
const carTrack   = document.getElementById('carTrack');
const carOuter   = document.getElementById('carOuter');
const carDots    = document.getElementById('carDots');
const carPrev    = document.getElementById('carPrev');
const carNext    = document.getElementById('carNext');
const carCount   = document.getElementById('carCount');

let allCards     = [];   /* master list */
let visCards     = [];   /* after filter */
let pages        = [];   /* [[card,card,...], ...] */
let currentPage  = 0;
let targetX      = 0;
let currentX     = 0;
let isAnimating  = false;
let cols         = 3;
let rows         = 2;

function getCols(){
  const w = window.innerWidth;
  if(w <= 700)  return 1;
  if(w <= 1000) return 2;
  return 3;
}

/* Build pages from visCards */
function buildPages(){
  cols = getCols();
  const perPage = cols * rows;  /* 6 on desktop, 4 tablet, 2 mobile */
  pages = [];
  for(let i=0; i<visCards.length; i+=perPage){
    pages.push(visCards.slice(i, i+perPage));
  }
  if(pages.length === 0) pages = [[]];

  /* clear track */
  carTrack.innerHTML = '';

  /* for each page, create a .car-page grid */
  pages.forEach(pg=>{
    const div = document.createElement('div');
    div.className = 'car-page';
    /* set cols via inline style so it adapts */
    div.style.gridTemplateColumns = `repeat(${cols}, 1fr)`;
    pg.forEach(card=>{ div.appendChild(card); });
    carTrack.appendChild(div);
  });

  /* force track width = pages × 100% */
  carTrack.style.width = (pages.length * 100) + '%';
  /* each page takes equal slice */
  document.querySelectorAll('.car-page').forEach(p=>{ p.style.flex = `0 0 ${100/pages.length}%`; p.style.width = `${100/pages.length}%`; });

  /* reset position */
  currentPage = 0;
  currentX    = 0;
  targetX     = 0;
  carTrack.style.transform = 'translateX(0)';

  buildDots();
  updateCount();

  /* re-observe cards for AOS */
  pg_cards_reObserve();
}

function pg_cards_reObserve(){
  document.querySelectorAll('.ccard').forEach((c,i)=>{
    c.classList.remove('show');
    setTimeout(()=>{
      const r=c.getBoundingClientRect();
      if(r.top < window.innerHeight-60) c.classList.add('show');
      else aio.observe(c);
    }, i*40);
  });
}

/* Dots */
function buildDots(){
  carDots.innerHTML='';
  pages.forEach((_,i)=>{
    const d=document.createElement('div');
    d.className='dp'+(i===0?' on':'');
    d.addEventListener('click',()=>goToPage(i));
    carDots.appendChild(d);
  });
}
function updateDots(){
  document.querySelectorAll('.dp').forEach((d,i)=>d.classList.toggle('on',i===currentPage));
}
function updateCount(){
  const total = allCards.length;
  const vis   = visCards.length;
  carCount.textContent = vis === total ? total+' restaurants' : vis+' of '+total+' shown';
}

/* Go to page with momentum animation */
function goToPage(p){
  currentPage = Math.max(0, Math.min(pages.length-1, p));
  /* target = -(pageIndex / totalPages) * totalTrackWidth */
  /* Since track width = pages.length * outerWidth, each page = outerWidth */
  const outerW = carOuter.offsetWidth;
  targetX = -(currentPage * outerW);
  animateTo();
  updateDots();
}

function animateTo(){
  if(isAnimating) return;
  isAnimating = true;
  function step(){
    /* Exponential ease — same feel as Apple/Linear */
    currentX += (targetX - currentX) * 0.072;
    if(Math.abs(targetX - currentX) < 0.4){
      currentX = targetX;
      carTrack.style.transform = `translateX(${currentX}px)`;
      isAnimating = false;
      return;
    }
    carTrack.style.transform = `translateX(${currentX}px)`;
    requestAnimationFrame(step);
  }
  requestAnimationFrame(step);
}

carPrev.addEventListener('click',()=>goToPage(currentPage-1));
carNext.addEventListener('click',()=>goToPage(currentPage+1));

/* Touch/swipe on carousel */
let tStartX=0, tStartPage=0;
carOuter.addEventListener('touchstart', e=>{ tStartX=e.touches[0].clientX; tStartPage=currentPage; lenis.stop(); },{passive:true});
carOuter.addEventListener('touchend',   e=>{
  const dx = tStartX - e.changedTouches[0].clientX;
  if(Math.abs(dx)>40){
    goToPage(dx>0 ? currentPage+1 : currentPage-1);
  }
  lenis.start();
},{passive:true});

/* Mouse drag on carousel */
let mDown=false, mStartX=0, mStartPage=0;
carOuter.addEventListener('mousedown', e=>{ mDown=true; mStartX=e.clientX; mStartPage=currentPage; lenis.stop(); carOuter.style.cursor='grabbing'; });
window.addEventListener('mouseup', ()=>{ if(mDown){ mDown=false; lenis.start(); carOuter.style.cursor=''; } });
window.addEventListener('mousemove', e=>{
  if(!mDown) return;
  const dx = mStartX - e.clientX;
  if(Math.abs(dx)>60){
    mDown=false; lenis.start(); carOuter.style.cursor='';
    goToPage(dx>0 ? mStartPage+1 : mStartPage-1);
  }
});

/* Resize */
let resizeTimer;
window.addEventListener('resize',()=>{
  clearTimeout(resizeTimer);
  resizeTimer=setTimeout(()=>{ buildPages(); goToPage(currentPage); },220);
});

/* ═══════════════════════════════
   10. SEARCH & FILTER
═══════════════════════════════ */
let activeFilter='';

function setFilter(btn, cuisine){
  document.querySelectorAll('.pill').forEach(p=>p.classList.remove('on'));
  btn.classList.add('on');
  activeFilter=cuisine;
  applyFilters();
}

function applyFilters(){
  const q=(document.getElementById('searchInput').value||'').toLowerCase().trim();
  visCards = allCards.filter(card=>{
    const n=card.dataset.name||'';
    const c=card.dataset.cuisine||'';
    return (!q||n.includes(q)||c.includes(q)) && (!activeFilter||c.includes(activeFilter));
  });
  buildPages();
}

/* ═══════════════════════════════
   11. INIT CAROUSEL
═══════════════════════════════ */
(function init(){
  /* move all cards from pool into allCards */
  const poolCards = Array.from(pool.querySelectorAll('.ccard'));
  allCards = poolCards;
  visCards = [...allCards];
  buildPages();
})();

/* ═══════════════════════════════
   12. SMOOTH ANCHOR SCROLL
═══════════════════════════════ */
document.querySelectorAll('a[href^="#"]').forEach(a=>{
  a.addEventListener('click', e=>{
    const t=document.querySelector(a.getAttribute('href'));
    if(t){ e.preventDefault(); lenis.scrollTo(t, {offset:-68, duration:1.4}); }
  });
});

/* ═══════════════════════════════
   13. FOOTER "back to top"
═══════════════════════════════ */
document.querySelector('.ft-top')?.addEventListener('click', e=>{
  e.preventDefault();
  lenis.scrollTo(0, {duration:1.6});
});
</script>

</body>
</html>
 