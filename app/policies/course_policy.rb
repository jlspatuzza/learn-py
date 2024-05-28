class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def index?
      user.present?
    end

    def new?
      create?
    end

    def create?
      true
    end
  end
end
