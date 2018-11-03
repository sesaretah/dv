$("#profile-show").replaceWith("<%= escape_javascript(render(:partial => 'profiles/profile_details', locals: {profile: @profile})) %>");
