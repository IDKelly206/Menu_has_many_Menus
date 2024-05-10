module TurboStreamActionsHelper
  def redirect(url)
    turbo_stream_action_tag :adv_redirect, url: url
  end
end

Turbo::Streams::TagBuilder.prepend(TurboStreamActionsHelper)
