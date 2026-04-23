// Firebase integration has been removed visually to simplify review moderation.
// Reseñas se enviarán por email vía FormSubmit directo desde el HTML (index.html).

document.addEventListener('DOMContentLoaded', () => {
    // Check if URL has ?submit=ok for the thank you message
    if (window.location.search.includes('submit=ok')) {
        setTimeout(() => {
            if (typeof openReviewModal === 'function') openReviewModal();
            const formObj = document.getElementById('review-form-content');
            const thanksObj = document.getElementById('review-thanks-content');
            if (formObj && thanksObj) {
                formObj.style.display = 'none';
                thanksObj.style.display = 'flex';
            }
        }, 800);
    }
});
