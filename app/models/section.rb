class Section < ActiveRecord::Base

	  belongs_to :page
  has_many :section_edits
    #has_many :editors,:through => :section_edits,:class_name => "AdminUser"
    has_many :editors, :through => :section_edits, :class_name => "AdminUser"

    #has_many :admin_users,:through => :section_edits

  CONTENT_TYPES = ['text', 'HTML']

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_inclusion_of :content_type, :in => CONTENT_TYPES,
    :message => "must be one of: #{CONTENT_TYPES.join(', ')}"
  validates_presence_of :content
    

scope :visible,lambda{where(:visible => true)}

scope :invisible,lambda{where(:visible => false)}

scope :sorted,lambda{order("sections.position ASC")}

scope :newest_first,lambda{order("subject.created_at DESC")}

scope :search , lambda{|query|
where(["name like ?","%#{query}%"])

}

end
