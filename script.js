// const gsap = window.gsap
const ScrollTrigger = window.ScrollTrigger;

//  -----------year script-----------
document.getElementById("year").textContent = new Date().getFullYear();
//custom cursor
const cursor = document.querySelector(".cursor");
const cursorInner = document.querySelector(".cursor-inner");
if (window.innerWidth > 768) {
  document.addEventListener("mousemove", (e) => {
    gsap.to(cursor, {
      left: e.clientX - 6,
      top: e.clientY - 6,
      duration: 0.1,
    });
    gsap.to(cursorInner, {
      left: e.clientX - 14,
      top: e.clientY - 14,
      duration: 0.2,
    });
  });
}
// loading
function initializeLoader() {
  const loader = document.querySelector(".loader");
  const txt = document.querySelector(".txt");
  const spinner = document.querySelector(".spinner");
  gsap.to(txt, {
    opacity: 1,
    duration: 0.6,
    ease: "power2.out",
  });
  gsap.to(spinner, {
    width: "100%",
    duration: 2,
    ease: "power2.inOut",
    delay: 0.6,
    onComplete: () => {
      gsap.to(loader, {
        opacity: 0,
        duration: 0.6,
        onComplete: () => {
          loader.style.display = "none";
          initializeAnime();
        },
      });
    },
  });
}
window.addEventListener("load", initializeLoader);
function initializeAnime() {
  gsap.to("nav", {
    y: 0,
    duration: 1,
    ease: "power3.out",
  });
}
//themeToggle
const themeToggle = document.getElementById("themeToggle");
const body = document.body;

const curr = localStorage.getItem("theme") || "dark";
body.setAttribute("data-theme", curr);

themeToggle.addEventListener("click", () => {
  const current = body.getAttribute("data-theme");
  const newTheme = current === "light" ? "dark" : "light";
  body.setAttribute("data-theme", newTheme);
  localStorage.setItem("theme", newTheme);
});
