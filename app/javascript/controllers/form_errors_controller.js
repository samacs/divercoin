import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = ['dismiss']

    connect = () => new Dismiss(this.element, this.dismissTarget)
}
