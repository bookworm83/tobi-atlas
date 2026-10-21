# README

# TobiAtlas 🌍

A travel planning web app where you can keep all your upcoming trips in one place. Create an account, add trips with dates and notes, and TobiAtlas gives each one a cover photo of the destination automatically.

> 🚧 **Work in progress.** TobiAtlas is a learning project I'm building while training as a software engineer, with guidance from a senior engineer mentor. It isn't deployed yet.

## Features

- **Accounts** – sign up, log in and log out, with passwords securely hashed using bcrypt
- **Profiles** – edit your username and bio, and upload a profile picture
- **Trips** – create, view, edit and delete trips with a name, start and end dates, notes and a photo
- **Validation** – every trip needs a name and a start date, and the end date can't be before the start date
- **Search** – find trips by name (case-insensitive) or filter them by date range
- **Automatic cover photos** – each new trip gets a destination photo from the [Unsplash API](https://unsplash.com/developers)
- **File storage** – uploads go to S3-compatible storage (MinIO in development)

## Tech stack

| Area | Tools |
|---|---|
| Back end | Ruby 3.4, Ruby on Rails 8.1 |
| Front end | React 19 via React on Rails, Shakapacker/Rspack, Bootstrap 5, Sass |
| Database | SQLite |
| Storage | AWS SDK for S3, MinIO (run with Docker Compose) |
| External APIs | Unsplash, called with Faraday |
| Testing | RSpec |
| Code quality | RuboCop, Brakeman, bundler-audit, GitHub Actions CI |

## How it's organised

- `app/models` – `User` and `Trip` with their validations, plus `S3Upload` to record uploaded files
- `app/controllers` – trips, users/profile, sessions (login) and uploads
- `app/services` – small service objects that keep external calls out of the controllers:
  - `UnsplashClient` fetches a destination photo for a trip
  - `S3Uploader` uploads a file to the S3 bucket and saves its details
- `app/javascript/packs/ror_components` – React components rendered inside Rails views
- `spec/` – RSpec model tests
