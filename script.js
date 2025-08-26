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
  // First animate navigation - make it more visible
  gsap.to("nav", {
    y: 0,
    duration: 1,
    ease: "power3.out",
    onComplete: () => {
      // Start home content animations after nav completes
      console.log("Nav animation complete, starting home animations");
      startHomeAnimations();
    }
  });
}

function startHomeAnimations() {
  console.log("Starting home animations");
  
  // Create separate timeline for each element to ensure proper sequence
  const greetingTimeline = gsap.timeline({delay: 0.1});
  
  // Step 1: Animate greeting FIRST and ONLY
  greetingTimeline.to(".greeting", {
    opacity: 1,
    filter: 'blur(0px)',
    duration: 1,
    y: 0,
    ease: "power3.out",
    onComplete: () => {
      // Step 2: After greeting completes, start the rest
      startRestOfAnimations();
    }
  });
}

function startRestOfAnimations() {
  const restTimeline = gsap.timeline();
  
  restTimeline.to(".name", {
    opacity: 1,
    filter: 'blur(0px)',
    y: 0,
    duration: 0.8,
    ease: "power3.out",
  })
  .to(".description", {
    opacity: 1,
    filter: 'blur(0px)',
    y: 0,
    duration: 0.8,
    ease: "power3.out",
  }, "-=0.3")
  .to(".buttons", {
    opacity: 1,
    filter: 'blur(0px)',
    y: 0,
    duration: 0.8,
    ease: "power3.out",
  }, "-=0.3")
  .to(".profile-img", {
    opacity: 1,
    scale: 1,
    duration: 1,
    ease: "back.out(1.7)",
  }, "-=0.4")
  .to(".social-icons", {
    opacity: 1,
    filter: "blur(0px)",
    y: 0,
    duration: 0.8,
    ease: "power3.out",
  }, "-=0.3");
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

// Typewriter effect
const typewriterElement = document.querySelector(".typing-demo");
const words = [
  "Programmer",
  "Flutter Developer",
  "Web Developer",
  "Photographer",
];
let wordIndex = 0;
let charIndex = 0;
let isDeleting = false;

function typeWriter() {
  const currentWord = words[wordIndex];

  if (isDeleting) {
    typewriterElement.textContent = currentWord.substring(0, charIndex - 1);
    charIndex--;
  } else {
    typewriterElement.textContent = currentWord.substring(0, charIndex + 1);
    charIndex++;
  }
  let typeSpeed = isDeleting ? 50 : 100;
  if (!isDeleting && charIndex === currentWord.length) {
    typeSpeed = 2000;
    isDeleting = true;
  } else if (isDeleting && charIndex === 0) {
    // Move to next word
    isDeleting = false;
    wordIndex = (wordIndex + 1) % words.length;
    typeSpeed = 500;
  }
  setTimeout(typeWriter, typeSpeed);
}
document.addEventListener("DOMContentLoaded", () => {
  setTimeout(typeWriter, 4000); // Start after 1 second
});
