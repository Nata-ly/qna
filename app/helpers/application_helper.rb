module ApplicationHelper
  def authenticated_message(current_user)
    if user_signed_in?
      link_to('Sign out', destroy_user_session_path, method: :delete)
    else
      link_to('Sign in', user_session_path)
    end
  end

  def user_with_rights?(user)
    user_signed_in? && current_user == user
  end

  def gist_id(url)
    url.split('/').last
  end
end
