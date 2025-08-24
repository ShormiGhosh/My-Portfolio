//  -----------year script-----------

document.getElementById("year").textContent = new Date().getFullYear();

const gsap = window.gsap 
const ScrollTrigger = window.ScrollTrigger 
// loading
function initializeLoader() {
  const loader = document.querySelector(".loader");
  const txt = document.querySelector(".txt");
  const spinner = document.querySelector(".spinner");
  gsap.to(txt,{
    opacity: 1,
    duration: 0.6,
    ease: "power2.out"
  });
  gsap.to(spinner,{
    width: "100%",
    duration: 2,
    ease: "power2.inOut",
    delay: 0.6,
    onComplete: () => {
      gsap.to(loader, {
        opacity: 0,
        onComplete: () =>    {
          loader.style.display = "none";
          initializeAnime();
        }
      });
    }
  });
}
window.addEventListener("load", initializeLoader);
function initializeAnime() {
  gsap.to("nav", {
    y: 0,
    duration: 1,
    ease: "power3.out" 
  });
}