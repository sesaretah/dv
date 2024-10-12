module ApplicationHelper
  def user_accessible?(article, user)
    flag = false
    #@role = Role.find_by_id(user.current_role_id)
    role_ids = user.roles.pluck(:id)

    if !role_ids.blank?
      @workflow_state_ids = WorkflowState.where("role_id in (?)", role_ids).pluck(:id)
      if !article.workflow_state.blank?
        workflow_role_accesses = article.workflow_state.workflow.workflow_role_accesses.where("role_id in (?)", role_ids)
        if @workflow_state_ids.include? article.workflow_state_id || workflow_role_accesses.blank?
          flag = true
        else
          if article.user_id == user.id
            for workflow_role_access in workflow_role_accesses
              flag = flag || workflow_role_access.own_article_traceable
            end
            if flag == false # to handle cases when user has access to article in current state
              flag = true if role_ids.include? article.workflow_state.role_id
            end
          else
            for workflow_role_access in workflow_role_accesses
              if article.workflow_state.workflow.roles.map(&:id).include?(workflow_role_access.role_id)
                flag = flag || workflow_role_access.other_articles_traceable
              end 
            end
          end
        end
      end
    end
    flag = true if article.workflow_state.blank?
    return flag
  end

  def viewable?(article)
    flag = false
    @role = Role.find_by_id(current_user.current_role_id)
    if !@role.blank?
      if article.workflow_state
        @workflow_ids = WorkflowState.where(role_id: @role.id).collect(&:workflow_id).uniq
        if @workflow_ids.include? article.workflow_state.workflow_id
          flag = true
        end
      end
      if article.access_for_others == "none" || article.access_for_others.blank?
        flag = false
      end
      for access_group in @role.access_groups
        if article.access_group_id == access_group.id
          flag = true
        end
      end
    end
    return flag
  end

  def viewable_level?(article, level)
    flag = false
    role_ids = current_user.roles.pluck(:id)
    if !role_ids.blank?
      if article.access_for_others == level
        flag = true
      end
      access_group_ids = RoleAccess.where("role_id in (?)", role_ids).pluck(:access_group_id)
      access_groups = AccessGroup.where("id in (?)", access_group_ids)
      for access_group in access_groups
        if !access_group.access_groupings.where(article_id: article.id).first.blank?
          flag = true
        end
      end
    end
    return flag
  end

  def organization_types
    @options = [
      [t(:temporal), 1],
      [t(:permanent), 0],
    ]
    return @options
  end

  def item_names
    @options = [
      [t(:article_attachment), "article_attachment"],
      [t(:article_citation), "article_citation"],
      [t(:article_documents), "article_documents"],
    ]
    return @options
  end

  def attachment_types
    @options = [
      [t(:article_attachment), "article_attachment"],
      [t(:article_citation), "article_citation"],
      [t(:article_documents), "article_documents"],
    ]
    return @options
  end

  def controls
    @options = [
      [t(:allow), 1],
      [t(:deny), 0],
    ]
    return @options
  end

  def rcontrols(s)
    if !s.blank?
      @options = [t(:allow), t(:deny)]
      return @options[s - 1]
    else
      return t(:deny)
    end
  end

  def ability
    @options = [
      [t(:has), 1],
      [t(:has_not), 2],
    ]
    return @options
  end

  def existence
    @options = [
      [t(:is_not), 1],
      [t(:is), 2],
    ]
    return @options
  end

  def carrier
    @options = [
      [t(:none), 0],
      [t(:majority), 1],
      [t(:consensus), 2],
    ]
    return @options
  end

  def default_state_pages 
    @options = [
      [t(:suggestion), 0],
      [t(:review), 1],
      [t(:decision), 2],
      [t(:full), 3],
      [t(:compact), 4],
    ]
    return @options
  end 

  def rcarrier(s)
    @options = ["none", "majority", "consensus"]
    return @options[s]
  end

  def rability(s)
    @options = ["has", "has_not"]
    return @options[s - 1]
  end

  def permit_by_workflow(article, user, caller)
    if article.workflow_state.blank?
      return true
    end
    if article.workflow_state.workflow.user_id == user.id
      return true
    end
    # @role = Role.find_by_id(user.current_role_id)
    # if !@role.blank?
    #   if article.workflow_state.role_id != @role.id
    #     return false
    #   end
    # end
    role_ids = user.roles.pluck(:id)
    @role_workflow_state_ids = WorkflowState.where("role_id in (?)", role_ids).pluck(:id).uniq
    @user_workflows = user.workflows.pluck(:id)
    if @role_workflow_state_ids.include?(article.workflow_state.id) || @user_workflows.include?(article.workflow_state.workflow.id) || article.workflow_state&.workflow.admin_id == user.id || article.workflow_state&.workflow.moderator_id == user.id 
      return true
    end
    @items = article.workflow_state.editable.split(",")
    @flag = false
    for item in @items
      if !item.blank?
        if item == caller + "_" + "checkbox"
          @flag = true
        end
      end
    end
    if @flag
      return true
    else
      return false
    end
  end

  def owner(obj, user)
    if obj.user_id == user.id || ( defined?(obj.admin_id) && obj.admin_id == user.id ) || ( defined?(obj.moderator) && obj.moderator == user.id )
      return true
    else
      return false
    end
  end

  def grant_access(ward, user)
    @flag = 0
    if user.assignments.blank?
      return false
    end
    if user.current_role_id.blank?
      return false
    else
      @ac = AccessControl.where(role_id: user.current_role_id).first
      @flag = @ac["#{ward}"].to_i if !@ac.blank?
    end
    if @flag == 0
      return false
    else
      return true
    end
  end


  def article_owner(article, user, action='edit')
    return true if grant_access("edit_workflow", user)

    role_ids = user.roles.pluck(:id)
    @workflow_state_ids = WorkflowState.where("role_id in (?)", role_ids).pluck(:id)
    @user_workflows = user.workflows.pluck(:id)

    if action == 'edit'
      if @workflow_state_ids.include?(article.workflow_state.id) || @user_workflows.include?(article.workflow_state.workflow.id) || article.workflow_state&.workflow.admin_id == user.id || article.workflow_state&.workflow.moderator_id == user.id 
        return true
      else
        return false
      end
    end

    if action == 'destroy'
      if @user_workflows.include?(article.workflow_state.workflow.id) || @user_workflows.include?(article.workflow_state.workflow.id) || article.workflow_state&.workflow.admin_id == user.id || article.workflow_state&.workflow.moderator_id == user.id 
        return true
      else
        return false
      end
    end
  end
end
