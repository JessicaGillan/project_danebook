require 'rails_helper'

RSpec.describe Profile, type: :model do
  it "belongs to a user"
  it "validates the presence of first_name and last_name"
  it "validates the length of tagline and about me"
  it "does not allow non-number telephone to be saved"
  it "validates maximum length for college, hometown, and current location"
  it "does not accept birthday dates in the future"

  it 'does not run injected SQL or scripts'
end
