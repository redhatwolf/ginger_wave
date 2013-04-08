class Post < ActiveRecord::Base
  attr_accessible :content, :name, :title, :created_at, :avatar, :tags_attributes#, :user_id
  mount_uploader :avatar, AvatarUploader
  
  validates_presence_of :owner
  
  validates :name, :presence => true,
                      :length => {:minimum => 2}
  validates :title, :presence => true,
                      :length => {:minimum => 5}
                    has_many :comments,  :dependent => :destroy     
                    has_many :tags
                    belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  accepts_nested_attributes_for :tags, :allow_destroy => :true,
  :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }                   
end
