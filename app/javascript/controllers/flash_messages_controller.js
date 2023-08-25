import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = ['message']

    messages = {}

    messageTargetConnected = element => {
        this.messages[element.id] = new Dismiss(element)
    }

    dismiss = e => {
        e.preventDefault()

        const message = this.messages[e.params.id]
        if (message) {
            message.hide()
        }
    }
}
