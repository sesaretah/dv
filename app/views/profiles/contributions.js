$("#profile-show").replaceWith("<%= escape_javascript(render(:partial => 'profiles/article_contributions', locals: {profile: @profile})) %>");
