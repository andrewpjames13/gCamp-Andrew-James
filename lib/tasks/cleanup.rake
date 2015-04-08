namespace :clean do

  task :user_memberships_remove => :environment do
    Membership.all.each do |member|
      if member.user.nil?
        member.destroy
      end
    end
  end

  task :project_memberships_remove => :environment do
    Membership.all.each do |member|
      if member.project.nil?
        member.destroy
      end
    end
  end

  task :project_tasks_remove => :environment do
    Task.all.each do |task|
      if task.project.nil?
        task.destroy
      end
    end
  end

  task :task_comments_remove => :environment do
    Comment.all.each do |comment|
      if comment.task.nil?
        comment.destroy
      end
    end
  end

  task :user_id_nil_on_comments => :environment do
    Comment.all.each do |comment|
      if comment.user.nil?
        comment.user_id = nil
        comment.save
      end
    end
  end

  task :removes_tasks_with_nil_project_id => :environment do
    Task.all.each do |task|
      if task.project_id.nil?
        task.destroy
      end
    end
  end

  task :removes_comments_with_nil_task_id => :environment do
    Comment.all.each do |comment|
      if comment.task_id.nil?
        comment.destroy
      end
    end
  end

  task :removes_memberships_with_nil_project_or_user_id => :environment do
    Membership.all.each do |membership|
      if membership.project_id.nil? || membership.user_id.nil?
        membership.destroy
      end
    end
  end

end
