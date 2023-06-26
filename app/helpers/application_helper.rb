module ApplicationHelper
  # Added a helper so it's convenient to render the partial in our views.
  def render_modal(title: "", body: "", footer: "")
    render(partial: '/partials/modal', locals: { title: title, body: body, footer: footer })
  end
end
