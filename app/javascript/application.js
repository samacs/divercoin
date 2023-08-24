// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import 'flowbite/dist/flowbite.turbo'
import '@fortawesome/fontawesome-free/js/all'

import "./controllers"


document.addEventListener('turbo:load', () => {
    document.querySelectorAll('a[href="#"]').forEach(element => element.href = 'javascript:;')
})
