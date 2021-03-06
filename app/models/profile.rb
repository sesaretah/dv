class Profile < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  after_save ThinkingSphinx::RealTime.callback_for(:profile)

  has_attached_file :avatar, :styles => { :medium => "140x140>", :tiny => "20x20>", :thumb => "35x35>", :large => "500x500>" }, :default_url => "/assets/noimage-35-:style.jpg", :processors => [:cropper]
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_attached_file :signature, :styles => { :medium => "200x200>", :tiny => "20x20>", :thumb => "35x35>", :large => "500x500>" }, :default_url => "/assets/noimage-35-:style.jpg", :processors => [:cropper]
  validates_attachment_content_type :signature, :content_type => /\Aimage\/.*\Z/

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :ratio, :caller
  after_update :reprocess_avatar, :if => :cropping?

  #validates :name, presence: true
  #validates :surename, presence: true
  #validate :fullname_or_stage_name

  before_destroy :delete_contributions
  has_many :articles, :through => :contributions
  has_many :contributions

  has_many :profile_groups, :through => :profile_groupings
  has_many :profile_groupings, dependent: :destroy

  def self.merge_profile(profile_1, profile_2)
    @contributions = profile_2.contributions
    for contribution in @contributions
      contribution.profile_id = profile_1.id
      contribution.save
    end
    profile_2.destroy
  end

  def delete_contributions
    for contribution in Contribution.where(profile_id: self.id)
      contribution.destroy
    end
  end

  def fullname
    "#{self.name} #{self.surename}"
  end

  def title
    "#{self.name} #{self.surename}"
  end

  belongs_to :user

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end

  def profile_tag
    return "<span class='tag' data-toggle='tooltip' data-placement='top' title='#{self.fullname}'><span class='tag-avatar avatar' style='background-image: url(#{self.avatar(:tiny)})'></span>#{truncate(self.fullname, length: 15)}</span>"
  end

  private

  def reprocess_avatar
    avatar.assign(avatar)
    avatar.save
  end
end
