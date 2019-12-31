module ApplicationHelper
  def user_accessible?(article, user)
    flag = false
    @role = Role.find_by_id(user.current_role_id)
    if !@role.blank?
      @workflow_state_ids = WorkflowState.where(role_id: @role.id).collect(&:id)
      if @workflow_state_ids.include? article.workflow_state_id
        flag = true
      end
    end
    return flag
  end
  def viewable?(article)
    flag = false
    @role = Role.find_by_id(current_user.current_role_id)
    if !@role.blank?
      @workflow_state_ids = WorkflowState.where(role_id: @role.id).collect(&:id)
      if @workflow_state_ids.include? article.workflow_state_id
        flag = true
      end
      if article.access_for_others != 'none'
        flag = true
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
    @role = Role.find_by_id(current_user.current_role_id)
    if !@role.blank?
      @workflow_state_ids = WorkflowState.where(role_id: @role.id).collect(&:id)
      if @workflow_state_ids.include? article.workflow_state_id
        flag = true
      end
      if article.access_for_others == level
        flag = true
      end
      for access_group in @role.access_groups
        if article.access_group_id == access_group.id
          flag = true
        end
      end
    end
    return flag
  end
  def organization_types
    @options = [
      [t(:temporal), 1],
      [t(:permanent) , 0]
    ]
    return @options
  end

  def item_names
    @options = [
      [t(:article_attachment), 'article_attachment'],
      [t(:article_citation), 'article_citation'],
      [t(:article_documents), 'article_documents']
    ]
    return @options
  end
  def attachment_types
    @options = [
      [t(:article_attachment), 'article_attachment'],
      [t(:article_citation), 'article_citation'],
      [t(:article_documents), 'article_documents']
    ]
    return @options
  end
  def controls
    @options = [
      [t(:allow), 1],
      [t(:deny) , 0]
    ]
    return @options
  end

  def rcontrols(s)
    if !s.blank?
      @options = [t(:allow),t(:deny)]
      return @options[s-1]
    else
      return t(:deny)
    end
  end

  def ability
    @options = [
      [t(:has), 1],
      [t(:has_not) , 2]
    ]
    return @options
  end

  def existence
    @options = [
      [t(:is_not), 1],
      [t(:is) , 2]
    ]
    return @options
  end

  def rability(s)
    @options = ['has','has_not']
    return @options[s-1]
  end

  def permit_by_workflow(article,user,caller)
    if article.workflow_state.blank?
      return true
    end
    @role = Role.find_by_id(user.current_role_id)
    if !@role.blank?
      if article.workflow_state.role_id != @role.id
        return false
      end
    end
    @items = article.workflow_state.editable.split(',')
    @flag = false
    for item in @items
      if !item.blank?
        if item == caller+'_'+'checkbox'
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
    if obj.user_id == user.id
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
      @flag = @ac["#{ward}"].to_i
    end
    if @flag == 0
      return false
    else
      return true
    end
  end

  def article_owner(article, user)
    @role_workflow_state_ids = WorkflowState.where(role_id: user.current_role_id).pluck(:id).uniq
    @user_workflows = user.workflows.pluck(:id)
    if @role_workflow_state_ids.include?(article.workflow_state.id) || @user_workflows.include?(article.workflow_state.workflow.id)
      return true
    else
      return false
    end
  end

end
