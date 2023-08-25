import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    modal

    connect = () => {
        this.modal = new Modal(this.element, {
            placement: 'center-center',
            backdrop: 'dynamic',
            closable: true,
        })

        this.modal.show()
    }

    toggle = e => {
        e.preventDefault()

        if (this.modal) {
            this.modal.toggle()
        }
    }
}
