import { Application } from '@hotwired/stimulus'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

const registerControllers = controllers => {
    controllers.forEach(controller => {
        const controllerName = controller.filename
            .replace(/\_controller\.js/i, '')
            .replace(/\_/g, '-')
            .replace(/\//i, '--')
        application.register(controllerName, controller.module.default)
    })
}

export { application, registerControllers }
