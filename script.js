//  -----------year script-----------

document.getElementById("year").textContent = new Date().getFullYear();

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
    duration: 0.6,
    ease: "power2.inOut",
    delay: 0.6,
    onComplete: () => {
      gsap.to(loader, {
        opacity: 0,
        duration: 0.6,
        onComplete: () => {
          loader.style.display = "none";
          initializeAnime();
        }
      });
    }
  });
}
