import React, { useState } from 'react';
import PropTypes from 'prop-types';

export default function EditTrip({ name, startDate, endDate, notes, updateUrl, csrfToken }) {
  const [tripName, setTripName] = useState(name || '');
  const [tripStartDate, setTripStartDate] = useState(startDate || '');
  const [tripEndDate, setTripEndDate] = useState(endDate || '');
  const [tripNotes, setTripNotes] = useState(notes || '');

  return (
    <div className="container mt-5">
      <div className="row justify-content-center">
        <div className="col-md-8">
          <div className="card shadow">
            <div className="card-body p-5">
              <h2 className="card-title mb-4">Edit Trip</h2>

              <form action={updateUrl} method="post">
                <input type="hidden" name="authenticity_token" defaultValue={csrfToken} />
                <input type="hidden" name="_method" defaultValue="patch" />

                <div className="mb-3">
                  <label className="form-label fw-bold" htmlFor="trip_name">Trip Name</label>
                  <input
                    type="text"
                    id="trip_name"
                    name="trip[name]"
                    className="form-control form-control-lg"
                    value={tripName}
                    onChange={(e) => setTripName(e.target.value)}
                  />
                </div>

                <div className="row">
                  <div className="col-md-6">
                    <div className="mb-3">
                      <label className="form-label fw-bold" htmlFor="trip_start_date">Start Date</label>
                      <input
                        type="date"
                        id="trip_start_date"
                        name="trip[start_date]"
                        className="form-control form-control-lg"
                        value={tripStartDate}
                        onChange={(e) => setTripStartDate(e.target.value)}
                      />
                    </div>
                  </div>
                  <div className="col-md-6">
                    <div className="mb-3">
                      <label className="form-label fw-bold" htmlFor="trip_end_date">End Date</label>
                      <input
                        type="date"
                        id="trip_end_date"
                        name="trip[end_date]"
                        className="form-control form-control-lg"
                        value={tripEndDate}
                        onChange={(e) => setTripEndDate(e.target.value)}
                      />
                    </div>
                  </div>
                </div>

                <div className="mb-4">
                  <label className="form-label fw-bold" htmlFor="trip_notes">Notes & Ideas</label>
                  <textarea
                    id="trip_notes"
                    name="trip[notes]"
                    className="form-control form-control-lg"
                    rows="5"
                    value={tripNotes}
                    onChange={(e) => setTripNotes(e.target.value)}
                  />
                </div>

                <div className="d-flex gap-2">
                  <button type="submit" className="btn btn-success btn-lg flex-grow-1">Update Trip</button>
                  <a href="/trips" className="btn btn-outline-secondary btn-lg">Cancel</a>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

EditTrip.propTypes = {
  name: PropTypes.string,
  startDate: PropTypes.string,
  endDate: PropTypes.string,
  notes: PropTypes.string,
  updateUrl: PropTypes.string.isRequired,
  csrfToken: PropTypes.string.isRequired,
};
