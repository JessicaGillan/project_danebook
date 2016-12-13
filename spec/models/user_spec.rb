require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has one profile that gets destroyed if it is destroyed'
  it 'accepts nested attributes for its profile'

  it 'has a secure password'

  it 'has many posts that get destroyed if it is destroyed'
  it 'has many likes that get destroyed if it is destroyed'
  it 'has many comments that get destroyed if it is destroyed'

  it 'has many initiated and received friendings that get destroyed if it is destroyed'
  it 'has many friended users'
  it 'has many users friended by'

  it 'validates the length and presence of password'
  it 'will not save a user without an email or password'

  it 'validates email addresses are unique'
  it 'validates email addresses match expected format'
  it 'saves all emails in down case'

  it 'does not run injected SQL or scripts'

  describe '#regenerate_token' do
    it 'sets users auth_token'

    it 'does not set duplicate user tokens'
  end
end
