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
    onComplete: () => {
      // Start home content animations after nav completes
      console.log("Nav animation complete, starting home animations");
      startHomeAnimations();
      // Initialize scroll-triggered animations after home animations start
      initializeScrollAnimations();
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
  "Student",
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
  setTimeout(typeWriter, 4000); // Start after 4 seconds
});

// Initialize scroll-triggered animations for contact section
function initializeScrollAnimations() {
  console.log("Initializing scroll animations");
  
  // Contact Section Animation
  if (document.querySelector("#contact-section")) {
    // Animate contact section title
    gsap.to("#contact-section h1", {
      opacity: 1,
      y: 0,
      duration: 1,
      ease: "power3.out",
      scrollTrigger: {
        trigger: "#contact-section",
        start: "top 80%",
        toggleActions: "play none none reverse"
      }
    });
    
    // Animate contact background container
    gsap.to(".contact-bg", {
      opacity: 1,
      y: 0,
      duration: 1.2,
      ease: "power3.out",
      scrollTrigger: {
        trigger: ".contact-bg",
        start: "top 85%",
        toggleActions: "play none none reverse"
      }
    });
    
    // Animate contact info (left side)
    gsap.to(".contact-info", {
      opacity: 1,
      x: 0,
      duration: 0.8,
      ease: "power3.out",
      delay: 0.2,
      scrollTrigger: {
        trigger: ".contact-info",
        start: "top 80%",
        toggleActions: "play none none reverse"
      }
    });
    
    // Animate contact form (right side)
    gsap.to(".contact-form", {
      opacity: 1,
      x: 0,
      duration: 0.8,
      ease: "power3.out",
      delay: 0.4,
      scrollTrigger: {
        trigger: ".contact-form",
        start: "top 80%",
        toggleActions: "play none none reverse"
      }
    });
    
    // Animate contact info items one by one
    gsap.to(".contact-info li", {
      opacity: 1,
      y: 0,
      duration: 0.6,
      ease: "power2.out",
      stagger: 0.2,
      scrollTrigger: {
        trigger: ".contact-info ul",
        start: "top 80%",
        toggleActions: "play none none reverse"
      }
    });
    
    // Animate form elements
    gsap.to(".contact-form label, .contact-form input, .contact-form textarea, .contact-form button", {
      opacity: 1,
      y: 0,
      duration: 0.5,
      ease: "power2.out",
      stagger: 0.1,
      scrollTrigger: {
        trigger: ".contact-form form",
        start: "top 80%",
      }
    });
  }
  
  // Skills Section Animation
  if (document.querySelector("#skills")) {
    // Animate skills section title
    gsap.to("#skills h1", {
      opacity: 1,
      y: 0,
      duration: 1,
      ease: "power3.out",
      scrollTrigger: {
        trigger: "#skills",
        start: "top 80%",
        toggleActions: "play none none reverse"
      }
    });
    
    // Animate main skills container
    gsap.to(".soft-technical", {
      opacity: 1,
      y: 0,
      duration: 1.2,
      ease: "power3.out",
      scrollTrigger: {
        trigger: ".soft-technical",
        start: "top 85%",
        toggleActions: "play none none reverse"
      }
    });
    
    // Animate each skill category box
    gsap.to(".programing-lang, .frame-lib, .tool-technology, .soft", {
      opacity: 1,
      y: 0,
      scale: 1,
      duration: 0.8,
      ease: "power3.out",
      stagger: 0.2,
      scrollTrigger: {
        trigger: ".soft-technical",
        start: "top 80%",
        toggleActions: "play none none reverse"
      }
    });
    
    // Animate skill category titles
    gsap.to(".programing-lang h2, .frame-lib h2, .tool-technology h2, .soft h2", {
      opacity: 1,
      y: 0,
      duration: 0.6,
      ease: "power2.out",
      stagger: 0.15,
      delay: 0.3,
      scrollTrigger: {
        trigger: ".soft-technical",
        start: "top 75%",
        toggleActions: "play none none reverse"
      }
    });
    
    // Animate individual skill buttons with stagger
    gsap.to(".programing-lang li, .frame-lib li, .tool-technology li, .soft li", {
      opacity: 1,
      y: 0,
      scale: 1,
      duration: 0.4,
      ease: "power2.out",
      stagger: 0.05,
      delay: 0.6,
      scrollTrigger: {
        trigger: ".soft-technical",
        start: "top 70%",
        toggleActions: "play none none reverse"
      }
    });
  }
}

//mobile menu
const menuToggle = document.getElementById("menuToggle");
const mobileMenu = document.querySelector(".mobile-menu");
const menuIcon = menuToggle.querySelector("span");
const mobileMenuLinks = document.querySelectorAll(".mobile-menu a");

menuToggle.addEventListener("click", () => {
  mobileMenu.classList.toggle("active");
  menuToggle.classList.toggle("active");
  
  // Change icon from menu to close
  if(mobileMenu.classList.contains("active")) {
    menuIcon.textContent = "close";
    document.body.style.overflow = "hidden";
    gsap.to(mobileMenuLinks, {
      opacity: 1,
      y: 0,
      duration: 0.5,
      stagger: 0.1,
      delay: 0.1,
      ease: "power2.out"
    });
  } else {
    menuIcon.textContent = "menu";
    document.body.style.overflow = "auto";
    
    // Reset menu links
    gsap.set(mobileMenuLinks, {
      opacity: 0,
      y: 20
    });
  }
});

function closeMobileMenu() {
  mobileMenu.classList.remove("active");
  menuToggle.classList.remove("active");
  menuIcon.textContent = "menu";
  document.body.style.overflow = "";
  gsap.set(mobileMenuLinks, {
    opacity: 0,
    y: 20
  });
}
mobileMenuLinks.forEach(link => {
  link.addEventListener("click", (e) => {
    setTimeout(() => {
      closeMobileMenu();
    }, 200);
  });
});

// about me tabs
const tabLinks = document.getElementsByClassName("tablink");
const tabContents = document.getElementsByClassName("tabcontent");

function toggleTab(tabName) {
  // Remove active classes from all tab links
  for (let i = 0; i < tabLinks.length; i++) {
    tabLinks[i].classList.remove("active-link");
  }
  
  // Remove active classes from all tab contents
  for (let i = 0; i < tabContents.length; i++) {
    tabContents[i].classList.remove("active-content");
  }
  
  // Add active class to clicked tab link
  event.currentTarget.classList.add("active-link");
  
  // Add active class to corresponding tab content
  document.getElementById(tabName).classList.add("active-content");
}

// Dynamic Work Experience Functions
function loadWorkExperiences(experiences = []) {
  const experienceList = document.getElementById('experienceList');
  const noExperience = document.getElementById('noExperience');
  
  if (experiences.length === 0) {
    // Show no experience message
    experienceList.classList.add('hidden');
    noExperience.classList.remove('hidden');
  } else {
    // Show experience list and hide no experience message
    noExperience.classList.add('hidden');
    experienceList.classList.remove('hidden');
    
    // Clear existing content
    experienceList.innerHTML = '';
    
    // Add each experience
    experiences.forEach(exp => {
      const experienceItem = createExperienceItem(exp);
      experienceList.appendChild(experienceItem);
    });
  }
}

function createExperienceItem(experience) {
  const item = document.createElement('div');
  item.className = 'experience-item';
  
  item.innerHTML = `
    <div class="company">${experience.company}</div>
    <div class="position">${experience.position}</div>
    <div class="duration">${experience.duration}</div>
    <div class="description">
      ${experience.description}
      ${experience.achievements ? `<ul>${experience.achievements.map(achievement => `<li>${achievement}</li>`).join('')}</ul>` : ''}
    </div>
  `;
  
  return item;
}

// Example usage - call this function when data is loaded from database
// loadWorkExperiences([
//   {
//     company: "Tech Company Inc.",
//     position: "Frontend Developer",
//     duration: "Jan 2024 - Present",
//     description: "Developed responsive web applications using React and JavaScript.",
//     achievements: [
//       "Improved website performance by 40%",
//       "Led a team of 3 developers",
//       "Implemented modern design patterns"
//     ]
//   }
// ]);

// Initialize with empty experiences (shows no experience message)
loadWorkExperiences();