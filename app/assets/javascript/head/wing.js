document.addEventListener('DOMContentLoaded', function() {

  document.querySelectorAll('.js-head-wing__curtain').forEach(function (item) {
    console.debug("Binding to Head Wing Curtain")

    item.addEventListener('click', function(event) {
      event.preventDefault()

      const wing = event.currentTarget.parentNode
      const identifier = wing.dataset.identifier

      document.querySelectorAll(`.js-head-knob[data-identifier="${identifier}"]`).forEach(function (knob) {
        knob.click()
      })
    })
  })

})
