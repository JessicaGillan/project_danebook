require 'rails_helper'

RSpec.describe Post, type: :model do
  it "has many likes that are destroyed if it is destroyed"
  it "has many comments that are destroyed if it is destroyed"

  it "belongs to an author"

  it 'does not run injected SQL or scripts'
end
