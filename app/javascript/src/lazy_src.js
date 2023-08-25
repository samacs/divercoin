document.addEventListener('turbo:load', () => {
    document.querySelectorAll('[data-lazy-src]').forEach(element => {
        element.src = element.dataset.lazySrc
    })
})
