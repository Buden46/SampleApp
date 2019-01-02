class User < ActiveRecord::Base

  attr_accessible :name, :email, :phone_number, :address, :hobbies

  validates :email, :uniqueness => { :case_sensitive => false },
                    format: { with: /\A[-a-zA-Z0-9.'’&_%+]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,20}\z/ }
                    # :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}, on: :create
  # validates :phone_number, :numericality => true
  validates_format_of :phone_number, :with =>  /\d[0-9]\)*\z/ , :message => "Only positive number without spaces are allowed"
end
