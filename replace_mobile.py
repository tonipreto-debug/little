import sys

file_path = r'c:\Users\tonip\Desktop\LITTLE\css\style.css'

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

# The target is lines 2543 (0-indexed 2542) to 2562 (0-indexed 2561)
start_line = 2541 # Line 2542 in 1-index is '/* Timeline Responsiveness */'
end_line = 2562 # Line 2562 in 1-index is '}'

new_css = """/* Timeline Responsiveness */
@media (max-width: 935px) {
    .timeline-img-box, .vertical-reel,
    #vertical-reel-video, #vertical-reel-image {
        position: relative !important;
        width: 100% !important;
        max-width: 85vw !important;
        height: 120vw !important;
        max-height: 580px !important;
        min-width: 0 !important;
        min-height: 0 !important;
        margin: 30px auto 0 auto !important;
        top: 0 !important;
        right: 0 !important;
        left: 0 !important;
        transform: none !important;
        display: block !important;
        border: 6px solid white !important;
        box-shadow: 0 15px 30px rgba(0,0,0,0.15) !important;
        opacity: 0; /* Pre-animation state */
    }
    
    .timeline-item, .timeline-item:nth-child(even) {
        flex-direction: column !important;
        padding: 0 20px 0 60px !important;
        align-items: flex-start !important;
        min-height: auto !important;
    }

    /* WOW effect sequenced pop-in animation on scroll */
    .timeline-item.animate-show .timeline-img-box,
    .timeline-item.animate-show .vertical-reel,
    .timeline-item.animate-show #vertical-reel-video,
    .timeline-item.animate-show #vertical-reel-image {
        animation: scaleUpMobileImage 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards !important;
        animation-delay: 0.4s !important;
    }

    @keyframes scaleUpMobileImage {
        0% { opacity: 0; transform: translateY(50px) scale(0.9) !important; }
        100% { opacity: 1; transform: translateY(0) scale(1) !important; }
    }
}
"""

lines = lines[:start_line] + [new_css] + lines[end_line:]

with open(file_path, 'w', encoding='utf-8') as f:
    f.writelines(lines)

print("CSS Replaced Successfully!")
