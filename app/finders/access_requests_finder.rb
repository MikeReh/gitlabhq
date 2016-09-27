class AccessRequestsFinder
  attr_accessor :source

  # Arguments:
  #   source - a Group or Project
  def initialize(source)
    @source = source
  end

  def execute(*args)
    execute!(*args)
  rescue Gitlab::Access::AccessDeniedError
    []
  end

  def execute!(current_user)
    raise Gitlab::Access::AccessDeniedError unless can_see_access_requests?(current_user)

    source.requesters
  end

  private

  def can_see_access_requests?(current_user)
    source && current_user && current_user.can?(:"admin_#{source.class.to_s.underscore}", source)
  end
end
