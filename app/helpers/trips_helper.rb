module TripsHelper
  def trip_props(trip)
    {
      id: trip.id,
      name: trip.name,
      startDate: trip.start_date&.strftime("%b %d, %Y"),
      endDate: trip.end_date&.strftime("%b %d, %Y"),
      notes: trip.notes.to_s.truncate(100),
      photoUrl: trip.photo.attached? ? url_for(trip.photo) : (UnsplashClient.fetch_photo_url(trip.name) || trip.stock_photo_url),
      url: trip_path(trip),
      editUrl: edit_trip_path(trip),
    }
  end
end
