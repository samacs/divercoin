import { Controller } from '@hotwired/stimulus'
import { post } from '@rails/request.js'

export default class extends Controller {
    static targets = ['file']
    static values = { uploadUrl: String }

    send = async e => {
        const file = e.target.files[0]
        const formData = new FormData()
        formData.append('file', file)

        console.log(this.uploadUrlValue)
        const response = await post(this.uploadUrlValue, { body: formData, responseKind: 'turbo-stream' })

        this.fileTarget.value = ''
    }
}
