document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.js-head-sidebar__category').forEach(function (category) {
    console.debug("Binding to Sidebar Category")
    const href = category.getAttribute('href')

    // If this category doesn't open a secondary sidebar, it is a standalone link.
    if (href != '#') return

    category.addEventListener('click', function(event) {
      event.preventDefault()
      const category = event.currentTarget

      // The identifier of a category always matches that of its links list.
      const identifier = category.dataset.identifier
      const active = category.classList.contains('is-active')
      const links = document.querySelector(`.js-head-sidebar__links[data-identifier="${identifier}"]`)

      // Close all others
      document.querySelectorAll('.js-head-sidebar__links').forEach((someLinks) => {
        if (links == someLinks) return

        someLinks.classList.remove('is-active')
          const categoryClass = `.js-head-sidebar__category[data-identifier="${someLinks.dataset.identifier}"]`
          document.querySelectorAll(categoryClass).forEach((someCategory) => {
            someCategory.classList.remove('is-active')
          })
      })

      // Now toggle the desired one.
      if (active) {
        category.classList.remove('is-active')
        links.classList.remove('is-active')
      } else {
        category.classList.add('is-active')
        links.classList.add('is-active')
      }
    })
  })
})
