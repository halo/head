document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.js-head-knob').forEach((item) => {
    const identifier = item.dataset.identifier

    // If this knob doesn't open a sidebar, it is a standalone link.
    if (!identifier) return

    item.addEventListener('click', function(event) {
      event.preventDefault()
      const identifier = event.currentTarget.dataset.identifier
      const group = event.currentTarget.dataset.group
      const active = event.currentTarget.classList.contains('is-active')

      document.querySelectorAll('.js-head-knob, .js-head-wing').forEach((item) => {
        if (!active && item.dataset.identifier == identifier) {
          item.classList.add('is-active')
          item.classList.remove('is-force-deactive')

        } else if (item.dataset.group == group){
          item.classList.remove('is-active')
          item.classList.add('is-force-deactive')
        }
      })
    })

  })
})
