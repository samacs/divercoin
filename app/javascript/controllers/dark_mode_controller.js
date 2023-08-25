import { Controller } from '@hotwired/stimulus'

export const COLOR_SCHEME_KEY = 'color-scheme'
export const DARK_MODE = 'dark'
export const DARK_MODE_CSS_CLASS = 'dark'
export const LIGHT_MODE = 'light'

export default class extends Controller {
    static targets = ['lightIcon', 'darkIcon']

    get isDark() {
        return (
            localStorage.getItem(COLOR_SCHEME_KEY) === DARK_MODE ||
            (!(COLOR_SCHEME_KEY in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)
        )
    }

    connect = () => {
        if (this.isDark) {
            this.darkIconTarget.classList.remove('hidden')
            this.setDark()
        } else {
            this.lightIconTarget.classList.remove('hidden')
            this.setLight()
        }
    }

    toggle = e => {
        e.preventDefault()

        this.lightIconTarget.classList.toggle('hidden')
        this.darkIconTarget.classList.toggle('hidden')

        const dark = document.documentElement.classList.toggle(DARK_MODE_CSS_CLASS)
        dark ? this.setDark() : this.setLight()
    }

    setLight = () => {
        document.documentElement.classList.remove(DARK_MODE_CSS_CLASS)
        localStorage.setItem(COLOR_SCHEME_KEY, LIGHT_MODE)
    }

    setDark = () => {
        document.documentElement.classList.add(DARK_MODE_CSS_CLASS)
        localStorage.setItem(COLOR_SCHEME_KEY, DARK_MODE)
    }
}
