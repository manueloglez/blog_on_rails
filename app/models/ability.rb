# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 
    alias_action :create, :read, :update, :destroy, to: :crud
    
    # Only signed in users can create blog posts or comments.
    can :create, Post do |post|
      user.persisted?
    end

    can :create, Comment do |comment|
      user.persisted?
    end

    # Only the creator of blog posts can edit or delete them.
    can :crud, Post, user_id: user.id

    # Only the creator of comments or the creator of blogs can delete comments.
    can :destroy, Comment do |comment| 
      (comment.user == user) || (comment.post.user == user)
    end

    # Signed in users can only edit their user account.
    can :update, User do |u|
      u.persisted? && u == user
    end

    # Support an admin user that can do anything.
    if user.is_admin?
      can :manage, :all 
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
