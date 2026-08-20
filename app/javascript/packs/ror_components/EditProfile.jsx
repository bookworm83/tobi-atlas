import React, { useState } from 'react';
import PropTypes from 'prop-types';


export default function EditProfile({ bio, updateUrl, csrfToken, uploadUrl }) {
    const [userBio, setUserBio] = useState(bio || '');
    const [showPassword, setShowPassword] = useState(false);

    return (
      <div className="container mt-5">
        <div className="row justify-content-center">
          <div className="col-md-8">
            <div className="card shadow">
              <div className="card-body p-5">
                <h2 className="card-title mb-4">Edit Profile</h2>
                <form action={updateUrl} method="post">
                    <input type="hidden" name="authenticity_token" defaultValue={csrfToken} />
                    <input type="hidden" name="_method" defaultValue="patch" />

                    <div className="mb-3">
                      <label className="form-label fw-bold" htmlFor="user_bio">Bio</label>
                      <textarea
                        id="user_bio"
                        name="user[bio]"
                        className="form-control form-control-lg"
                        rows="4"
                        value={userBio}
                        onChange={(e) => setUserBio(e.target.value)}
                      />
                    </div>

                    <button type="button" className="btn btn-outline-secondary mb-3"
                            onClick={() => setShowPassword(!showPassword)}>
                        Change Password
                    </button>

                    {showPassword && (
                      <div>
                        <div className="mb-3">
                          <label className="form-label fw-bold" htmlFor="user_current_password">Current Password</label>
                          <input
                            type="password"
                            id="user_current_password"
                            name="user[current_password]"
                            className="form-control"
                          />
                        </div>
                        <div className="mb-3">
                          <label className="form-label fw-bold" htmlFor="user_password">New Password</label>
                          <input
                            type="password"
                            id="user_password"
                            name="user[password]"
                            className="form-control"
                          />
                        </div>
                        <div className="mb-3">
                          <label className="form-label fw-bold" htmlFor="user_password_confirmation">Confirm New Password</label>
                            <input
                              type="password"
                              id="user_password_confirmation"
                              name="user[password_confirmation]"
                              className="form-control"
                            />
                        </div>
                      </div>
                    )}

                    <div className="d-flex gap-2">
                      <button type="submit" className="btn btn-success btn-lg flex-grow-1">Update Profile</button>
                      <a href="/profile" className="btn btn-outline-secondary btn-lg">Cancel</a>
                    </div>
                </form>
                <hr className="my-4" />
                <form action={uploadUrl} method="post" encType="multipart/form-data">
                    <input type="hidden" name="authenticity_token" defaultValue={csrfToken} />
                      <div className="mb-3">
                        <label className="form-label fw-bold" htmlFor="user_file">Profile Picture</label>
                        <input
                          type="file"
                          id="user_file"
                          name="file"
                          accept=".png,.jpg,.jpeg"
                          className="form-control"
                        />
                      </div>
                        <div className="d-flex gap-2">
                          <button type="submit" className="btn btn-success btn-lg flex-grow-1">Update Profile Picture</button>
                        </div>

                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
}

EditProfile.proptypes = {
    bio: PropTypes.string,
    updateUrl: PropTypes.string.isRequired,
    csrfToken:PropTypes.string.isRequired,
    uploadUrl: PropTypes.string.isRequired
}