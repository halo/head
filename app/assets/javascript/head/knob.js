document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('.js-head-knob').forEach((knob) => {
    const href = knob.getAttribute('href')

    // If this knob doesn't open a sidebar, it is a standalone link.
    if (href != '#') return

    knob.addEventListener('click', function (event) {
      event.preventDefault()
      const knob = event.currentTarget

      // The identifier of a knob always matches that of its wing.
      const identifier = knob.dataset.identifier

      // Check screen size
      const mainMenuWing = document.querySelector(`.js-head-wing[data-identifier="mainmenu"]`)
      const tight = mainMenuWing ? getComputedStyle(mainMenuWing).getPropertyValue('position') === 'absolute' : false

      // Handle current wing
      const wing = document.querySelector(`.js-head-wing[data-identifier="${identifier}"]`)
      const visible = getComputedStyle(wing).getPropertyValue('display') == 'block'
      const group = knob.dataset.group

      // Always close sidebars on the same side of the screen (left/right)
      document.querySelectorAll(`.js-head-wing[data-group="${group}"]`).forEach((someWing) => {
        someWing.classList.remove('is-active')
        someWing.classList.add('is-force-deactive')
      })

      if (tight) {
        // On small screens, only ever show one menu, so close all others.
        document.querySelectorAll('.js-head-wing').forEach((someWing) => {
          if (someWing != wing) {
            someWing.classList.remove('is-active')
            someWing.classList.add('is-force-deactive')
          }
        })
      }

      // Now toggle the desired one.
      if (visible) {
        wing.classList.remove('is-active')
        wing.classList.add('is-force-deactive')
      } else {
        wing.classList.add('is-active')
        wing.classList.remove('is-force-deactive')
      }
    })

  })
})
