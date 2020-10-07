class OfferPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    return true if @user.admin?
    return true if @user.salesman? && @record.salesman_id == @user.id
    return true if @user.client? && @record.client_id == @user.id

    false
  end

  def create?
    @user.admin? || @user.salesman?
  end

  def accept?
    @user.admin? || (@user.client? && @record.client_id == @user.id)
  end

  def reject?
    accept?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      return scope.all if @user.admin?
      return scope.where(salesman_id: @user.id) if @user.salesman?

      scope.where(client_id: @user.id)
    end
  end
end
