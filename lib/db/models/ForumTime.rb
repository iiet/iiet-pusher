class ForumTime < ActiveRecord::Base
  scope :order_time, -> { order(time: :desc) }

  def self.last_sync_time(atom_id)
    ForumTime.where(atom_id: atom_id).order_time.first
  end
end