$("#profile-show").replaceWith("<%= escape_javascript(render(:partial => 'profiles/profile_details', locals: {profile: @profile})) %>");
new Noty({
    type: 'error',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :detached%>'
}).show();
