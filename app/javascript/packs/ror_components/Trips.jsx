import React, { useState } from 'react';
import PropTypes from 'prop-types';

export default function Trips({ trips: initialTrips, newTripUrl, csrfToken }) {
  const [trips, setTrips] = useState(initialTrips);

  const handleDelete = async (trip) => {
    if (!window.confirm('Are you sure you want to delete this trip?')) return;

    const response = await fetch(trip.url, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': csrfToken,
        Accept: 'application/json',
      },
    });

    if (response.ok) {
      setTrips((current) => current.filter((t) => t.id !== trip.id));
    }
  };

  return (
    <div className="container mt-5">
      <div className="row mb-4">
        <div className="col-md-8">
          <h1>My trips</h1>
          <p className="text-muted">Manage all your travel plans</p>
        </div>
        <div className="col-md-4 text-end">
          <a href={newTripUrl} className="btn btn-success btn-lg">➕ Add New Trip</a>
        </div>
      </div>

      {trips.length > 0 ? (
        <div className="row">
          {trips.map((trip) => (
            <div className="col-md-6 mb-4" key={trip.id}>
              <div className="card shadow-sm h-100">
                {trip.photoUrl && (
                  <img src={trip.photoUrl} className="card-img-top" alt={trip.name} />
                )}
                <div className="card-body">
                  <h4 className="card-title">
                    <a href={trip.url} className="text-decoration-none">{trip.name}</a>
                  </h4>

                  <p className="text-muted small">
                    {trip.startDate} - {trip.endDate}
                  </p>

                  <p className="card-text">{trip.notes}</p>

                  <div className="d-flex gap-2">
                    <a href={trip.url} className="btn btn-sm btn-primary">View</a>
                    <a href={trip.editUrl} className="btn btn-sm btn-warning">Edit</a>
                    <button
                      type="button"
                      className="btn btn-sm btn-danger"
                      onClick={() => handleDelete(trip)}
                    >
                      Delete
                    </button>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      ) : (
        <div className="alert alert-info text-center" role="alert">
          <h5>No trips yet!</h5>
          <p>Start planning your adventure by <a href={newTripUrl}>adding a trip</a></p>
        </div>
      )}

      <div className="mt-5 text-center">
        <a href="/" className="btn btn-outline-secondary">← Back to Home</a>
      </div>
    </div>
  );
}

Trips.propTypes = {
  trips: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number.isRequired,
      name: PropTypes.string.isRequired,
      startDate: PropTypes.string,
      endDate: PropTypes.string,
      notes: PropTypes.string,
      photoUrl: PropTypes.string,
      url: PropTypes.string.isRequired,
      editUrl: PropTypes.string.isRequired,
    }),
  ).isRequired,
  newTripUrl: PropTypes.string.isRequired,
  csrfToken: PropTypes.string.isRequired,
};
