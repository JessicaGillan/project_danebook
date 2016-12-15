module ControllerExpectationMacros

  def login(user)
    cookies[:auth_token] = user.auth_token
  end

  def expect_render_with_error
    assert_response :ok # Does not redirect
    expect(flash[:error]).not_to be_nil
  end

  def expect_render
    assert_response :ok # Does not redirect
  end

  def expect_success
    expect(flash[:success]).not_to be_nil
  end

  def expect_error
    expect(flash[:error]).not_to be_nil
  end

  def expect_redirect( path = nil )
    if path
      expect(response).to redirect_to path
    else
      assert_response :redirect
    end
  end
end
